# ======================================================================
# UAE FDI Resilience (ARDL + Scenarios + Anchor Blend)
# Script for GitHub
# ======================================================================

rm(list = ls())

# ---------------------------- Libraries -------------------------------
suppressPackageStartupMessages({
  library(tidyverse)     # dplyr, ggplot2, tidyr, readr, purrr
  library(lubridate)
  library(janitor)
  library(readxl)
  library(scales)

  library(urca)          # ADF/KPSS (df, kpss)
  library(ARDL)          # auto_ardl, bounds_f_test
  library(dynlm)         # dynamic linear models
  library(lmtest)        # bgtest, bptest, coeftest
  library(sandwich)      # NeweyWest
  library(tseries)       # jarque.bera.test
  library(strucchange)   # CUSUM/MOSUM stability tests
})

# ---------------------------- Paths -----------------------------------
DATA_DIR    <- "data"


# ---------------------------- Helpers ---------------------------------
numify <- function(x) {
  if (is.numeric(x)) return(x)
  readr::parse_number(as.character(x), na = c("..", "NA", "", "n/a"))
}

read_wdi_uae <- function(file, value_name) {
  raw <- readr::read_csv(file.path(DATA_DIR, file), skip = 4, show_col_types = FALSE) |>
    janitor::clean_names()

  raw |>
    filter(country_code == "ARE") |>
    pivot_longer(
      cols = matches("^(x)?\\d{4}$"),
      names_to = "year_raw",
      values_to = value_name
    ) |>
    mutate(
      year = readr::parse_number(year_raw),
      !!value_name := numify(.data[[value_name]])
    ) |>
    select(year, all_of(value_name)) |>
    arrange(year)
}

# ======================================================================
# SECTION 1 — Load & Transform Data
# ======================================================================

# (a) WDI: FDI net inflows (current US$)
fdi <- read_wdi_uae(
  file = "API_BX.KLT.DINV.CD.WD_DS2_en_csv_v2_130169.csv",
  value_name = "fdi_usd"
) |>
  filter(year >= 1970)  # range

# (b) WDI: Trade (% of GDP)
trade <- read_wdi_uae(
  file = "API_NE.TRD.GNFS.ZS_DS2_en_csv_v2_130005.csv",
  value_name = "trade_pct_gdp"
) |>
  filter(year >= 2001)  # modelling window starts 2001

# (c) GDP growth (xls)
gdp_raw <- readxl::read_xls(file.path(DATA_DIR, "GDPg.xls"))
stopifnot(nrow(gdp_raw) >= 2)

gdpg <- gdp_raw |>
  slice(2) |>
  pivot_longer(cols = -1, names_to = "year", values_to = "gdp_real_growth") |>
  mutate(
    year = as.integer(year),
    gdp_real_growth = numify(gdp_real_growth)
  ) |>
  select(year, gdp_real_growth) |>
  arrange(year)

# (d) Brent (FRED series)
brent_raw <- readr::read_csv(file.path(DATA_DIR, "POILBREUSDA.csv"), show_col_types = FALSE)

date_col <- dplyr::case_when(
  "observation_date" %in% names(brent_raw) ~ "observation_date",
  "DATE"             %in% names(brent_raw) ~ "DATE",
  TRUE ~ NA_character_
)
stopifnot(!is.na(date_col), "POILBREUSDA" %in% names(brent_raw))

brent <- brent_raw |>
  mutate(
    date  = lubridate::ymd(.data[[date_col]]),
    year  = lubridate::year(date),
    brent = numify(POILBREUSDA)
  ) |>
  group_by(year) |>
  summarise(brent = mean(brent, na.rm = TRUE), .groups = "drop") |>
  arrange(year)

# ------------------------ Merge into one df ----------------------------
df <- fdi |>
  left_join(brent, by = "year") |>
  left_join(gdpg,  by = "year") |>
  left_join(trade, by = "year") |>
  arrange(year) |>
  mutate(
    ln_fdi   = log(pmax(fdi_usd, 1)),   # avoid log(0)
    ln_brent = log(pmax(brent,  1))
  )

# Missing value check 
na_check <- df |> summarise(across(everything(), ~ sum(is.na(.))))
print(na_check)

# ======================================================================
# SECTION 2 — Build model_df (2001–2024, complete cases)
# ======================================================================

# Flat-carry for 2024 trade%GDP if missing (use 2023)
trade_2023 <- df |> filter(year == 2023) |> pull(trade_pct_gdp)
trade_2023 <- if (length(trade_2023) == 1) trade_2023 else NA_real_

df_fix <- df |>
  mutate(
    trade_pct_gdp = case_when(
      year == 2024 & is.na(trade_pct_gdp) & !is.na(trade_2023) ~ trade_2023,
      TRUE ~ trade_pct_gdp
    ),
    ln_fdi   = log(pmax(fdi_usd, 1)),
    ln_brent = log(pmax(brent,  1))
  )

model_df <- df_fix |>
  filter(year >= 2001, year <= 2024) |>
  filter(if_all(c(fdi_usd, brent, gdp_real_growth, trade_pct_gdp), ~ !is.na(.))) |>
  arrange(year)

model_df |>
  summarise(min_year = min(year), max_year = max(year), n = n()) |>
  print()

# ---------------------------- Visuals ---------------------------------
p_fdi_clean <- ggplot(model_df, aes(year, fdi_usd / 1e9)) +
  geom_line(linewidth = 1.2) +
  scale_y_continuous(
    limits = c(0, 50),
    breaks = seq(0, 50, 5),
    labels = label_number(prefix = "$", suffix = " bn")
  ) +
  scale_x_continuous(breaks = seq(2001, 2024, 2)) +
  labs(
    title = "UAE FDI Inflows (2001–2024)",
    subtitle = "Cyclical shocks and structural acceleration",
    x = NULL,
    y = NULL
  ) +
  theme_minimal(base_size = 12) +
  theme(
    plot.title = element_text(face = "bold"),
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank()
  )


# Pairwise correlations (levels + logs)
num_df <- model_df |> select(fdi_usd, trade_pct_gdp, gdp_real_growth, brent, ln_fdi, ln_brent)
print(round(cor(num_df, use = "complete.obs"), 2))

# ======================================================================
# SECTION 3 — Unit Root Tests (ADF + KPSS)
# ======================================================================

adf_suite <- function(series, name, max_lag = 2) {
  cat("\n=============================\n", name, "\n=============================\n")

  for (L in 0:max_lag) {
    cat(sprintf("\nADF (LEVEL, drift), lags = %d\n", L))
    print(summary(ur.df(series, type = "drift", lags = L)))

    cat(sprintf("\nADF (LEVEL, trend), lags = %d\n", L))
    print(summary(ur.df(series, type = "trend", lags = L)))
  }

  for (L in 0:max_lag) {
    cat(sprintf("\nADF (DIFF, drift), lags = %d\n", L))
    print(summary(ur.df(diff(series), type = "drift", lags = L)))
  }

  kpss_mu  <- ur.kpss(series, type = "mu",  lags = "short")
  kpss_tau <- ur.kpss(series, type = "tau", lags = "short")
  cat("\nKPSS (level-stationarity, mu):\n");  print(summary(kpss_mu))
  cat("\nKPSS (trend-stationarity, tau):\n"); print(summary(kpss_tau))
}

adf_suite(model_df$ln_fdi,          "ln_fdi")
adf_suite(model_df$ln_brent,        "ln_brent")
adf_suite(model_df$trade_pct_gdp,   "trade_pct_gdp")
adf_suite(model_df$gdp_real_growth, "gdp_real_growth")

# ======================================================================
# SECTION 4 — ARDL Lag Selection + Bounds Test
# ======================================================================

ardl_aic <- auto_ardl(
  ln_fdi ~ ln_brent + trade_pct_gdp + gdp_real_growth,
  data = model_df,
  max_order = c(3, 3, 3, 3),
  selection = "AIC"
)

print(ardl_aic$best_order)
print(head(ardl_aic$top_orders, 10))
print(summary(ardl_aic$best_model))

# Optional cross-check with BIC
ardl_bic <- auto_ardl(
  ln_fdi ~ ln_brent + trade_pct_gdp + gdp_real_growth,
  data = model_df,
  max_order = c(3, 3, 3, 3),
  selection = "BIC"
)
print(head(ardl_bic$top_orders, 10))

# Bounds test (case 3: unrestricted intercept, no trend)
print(bounds_f_test(ardl_aic$best_model, case = 3))

lm_fit <- ardl_aic$best_model

# ======================================================================
# SECTION 5 — Diagnostics (Serial corr, heterosked, normality, residual ADF)
# ======================================================================

# A) Serial correlation (BG)
print(bgtest(lm_fit, order = 1))
print(bgtest(lm_fit, order = 2))

# B) Heteroskedasticity
print(bptest(lm_fit)) # Breusch–Pagan

# White-type auxiliary test: u^2 ~ fit + fit^2
u   <- residuals(lm_fit)
u2  <- u^2
fit <- fitted(lm_fit)

aux_lm <- lm(u2 ~ fit + I(fit^2))
LM_stat <- length(u2) * summary(aux_lm)$r.squared
p_white <- pchisq(LM_stat, df = 2, lower.tail = FALSE)
print(p_white)

# C) Normality
print(jarque.bera.test(residuals(lm_fit)))

# D) Residual stationarity (ADF on residuals)
adf_resid <- ur.df(residuals(lm_fit), type = "drift", lags = 1, selectlags = "AIC")
print(summary(adf_resid))

# ======================================================================
# SECTION 6 — HAC (Newey–West) Robust Inference
# ======================================================================

nw_vcov <- NeweyWest(lm_fit, lag = 2, prewhite = FALSE, adjust = TRUE)
print(coeftest(lm_fit, vcov. = nw_vcov))

rmse_log <- sqrt(mean(residuals(lm_fit)^2))
print(rmse_log)

# ======================================================================
# SECTION 7 — Stability (CUSUM + MOSUM)
# ======================================================================

mf <- model.frame(lm_fit)

lhs <- names(mf)[1]
rhs <- paste(sprintf("`%s`", names(mf)[-1]), collapse = " + ")
f_plain <- as.formula(paste(lhs, "~", rhs))

cusum_proc <- efp(f_plain, type = "OLS-CUSUM", data = mf)
plot(cusum_proc, main = "CUSUM — Parameter Stability (5% boundaries)")
print(sctest(cusum_proc))

mosum_proc <- efp(f_plain, type = "OLS-MOSUM", data = mf)
plot(mosum_proc, main = "OLS-MOSUM — Abrupt Break Detection (5% boundaries)")
print(sctest(mosum_proc, type = "supF"))

# ======================================================================
# SECTION 8 — Scenario Forecasting (2025–2026)
# ======================================================================

# Scenario assumptions (brent in USD/bbl; GDP growth in %)
assump_base <- tibble(year = c(2025, 2026),
                      brent = c(78.1939130434782, 72),
                      gdp_real_growth = c(4.8, 5.0))

assump_down <- tibble(year = c(2025, 2026),
                      brent = c(65, 62),
                      gdp_real_growth = c(3.5, 4.0))

assump_up <- tibble(year = c(2025, 2026),
                    brent = c(88, 90),
                    gdp_real_growth = c(5.5, 5.8))

# Trade openness projection via AR(1) from in-sample trade series in mf
stopifnot("trade_pct_gdp" %in% names(mf))
trd <- mf$trade_pct_gdp
fit_ar1 <- lm(trd[-1] ~ trd[-length(trd)])

alpha <- coef(fit_ar1)[1]
phi   <- coef(fit_ar1)[2]

t2024 <- tail(trd, 1)
t2025 <- alpha + phi * t2024
t2026 <- alpha + phi * t2025

build_assump <- function(df) {
  df |>
    mutate(
      trade_pct_gdp = c(t2025, t2026),
      ln_brent = log(brent)
    ) |>
    select(year, ln_brent, gdp_real_growth, trade_pct_gdp)
}

assump_base <- build_assump(assump_base)
assump_down <- build_assump(assump_down)
assump_up   <- build_assump(assump_up)

# Last observed row from regression frame (state at end of sample)
last <- tail(mf, 1)

run_forecast <- function(assump_df, last_row, lm_fit) {
  beta   <- coef(lm_fit)
  xnames <- names(model.frame(lm_fit))[-1]

  # Guardrails: required lag terms must exist in last_row
  need <- c("L(ln_fdi, 1)", "L(ln_fdi, 2)",
            "L(ln_brent, 1)", "L(ln_brent, 2)", "L(ln_brent, 3)",
            "L(trade_pct_gdp, 1)", "L(trade_pct_gdp, 2)", "L(trade_pct_gdp, 3)")
  stopifnot(all(need %in% names(last_row)))

  # ---------------- 2025 ----------------
  new_2025 <- last_row

  # set contemporaneous exogenous for 2025
  new_2025$ln_brent        <- assump_df$ln_brent[assump_df$year == 2025]
  new_2025$gdp_real_growth <- assump_df$gdp_real_growth[assump_df$year == 2025]
  new_2025$trade_pct_gdp   <- assump_df$trade_pct_gdp[assump_df$year == 2025]

  # lags carried from last observed row
  new_2025[need] <- last_row[need]

  x_2025 <- setNames(numeric(length(xnames)), xnames)
  for (nm in xnames) x_2025[nm] <- as.numeric(new_2025[[nm]])

  ln_fdi_2025 <- as.numeric(beta[1] + sum(beta[-1] * x_2025[names(beta)[-1]]))

  # ---------------- 2026 ----------------
  new_2026 <- last_row

  new_2026$ln_brent        <- assump_df$ln_brent[assump_df$year == 2026]
  new_2026$gdp_real_growth <- assump_df$gdp_real_growth[assump_df$year == 2026]
  new_2026$trade_pct_gdp   <- assump_df$trade_pct_gdp[assump_df$year == 2026]

  # update dependent lags
  new_2026[["L(ln_fdi, 1)"]] <- ln_fdi_2025
  new_2026[["L(ln_fdi, 2)"]] <- last_row[["L(ln_fdi, 1)"]]

  # update brent lags (t-1 uses 2025 assumption)
  new_2026[["L(ln_brent, 1)"]] <- assump_df$ln_brent[assump_df$year == 2025]
  new_2026[["L(ln_brent, 2)"]] <- last_row[["L(ln_brent, 1)"]]
  new_2026[["L(ln_brent, 3)"]] <- last_row[["L(ln_brent, 2)"]]

  # update trade lags
  new_2026[["L(trade_pct_gdp, 1)"]] <- assump_df$trade_pct_gdp[assump_df$year == 2025]
  new_2026[["L(trade_pct_gdp, 2)"]] <- last_row[["L(trade_pct_gdp, 1)"]]
  new_2026[["L(trade_pct_gdp, 3)"]] <- last_row[["L(trade_pct_gdp, 2)"]]

  x_2026 <- setNames(numeric(length(xnames)), xnames)
  for (nm in xnames) x_2026[nm] <- as.numeric(new_2026[[nm]])

  ln_fdi_2026 <- as.numeric(beta[1] + sum(beta[-1] * x_2026[names(beta)[-1]]))

  tibble(
    year = c(2025, 2026),
    ln_fdi_hat = c(ln_fdi_2025, ln_fdi_2026),
    fdi_level = exp(c(ln_fdi_2025, ln_fdi_2026))
  )
}

fc_base <- run_forecast(assump_base, last, lm_fit) |> mutate(scenario = "Base")
fc_down <- run_forecast(assump_down, last, lm_fit) |> mutate(scenario = "Downside")
fc_up   <- run_forecast(assump_up,   last, lm_fit) |> mutate(scenario = "Upside")

fc_all <- bind_rows(fc_base, fc_down, fc_up)
print(fc_all)

# ARDL Scenario Results table (USD bn)
ardl_table <- fc_all |>
  mutate(fdi_usd_bn = fdi_level / 1e9) |>
  select(scenario, year, fdi_usd_bn) |>
  arrange(factor(scenario, levels = c("Base", "Downside", "Upside")), year) |>
  pivot_wider(names_from = year, values_from = fdi_usd_bn, names_prefix = "FDI_") |>
  mutate(
    FDI_2025 = round(FDI_2025, 1),
    FDI_2026 = round(FDI_2026, 1)
  )

print(ardl_table)

# ======================================================================
# SECTION 9 — Trend Anchor + Blending
# ======================================================================

mdf_win <- model_df |> filter(year >= 2004, year <= 2024)
stopifnot(nrow(mdf_win) > 5)

fdi_level <- mdf_win$fdi_usd
yr        <- mdf_win$year

win_idx <- which(yr >= 2016)
fdi_win <- fdi_level[win_idx]
yr_win  <- yr[win_idx]

g <- diff(log(fdi_win))

# mild winsorization to IQR endpoints
p <- quantile(g, probs = c(0.25, 0.75), na.rm = TRUE)
g_winz <- pmin(pmax(g, p[1]), p[2])

w <- seq_along(g_winz)
yr_growth_to <- yr_win[-1]  # 2017..2024

w[yr_growth_to == 2023] <- w[yr_growth_to == 2023] * 1.5
w[yr_growth_to == 2024] <- w[yr_growth_to == 2024] * 2.0

g_hat <- sum(w * g_winz) / sum(w)
anchor_growth <- exp(g_hat) - 1

fdi_2024    <- tail(fdi_level, 1)
anchor_2025 <- fdi_2024 * (1 + anchor_growth)^1
anchor_2026 <- fdi_2024 * (1 + anchor_growth)^2

ardl_2025 <- fc_base$fdi_level[fc_base$year == 2025]
ardl_2026 <- fc_base$fdi_level[fc_base$year == 2026]

w_ardl <- 0.5  # 50% ARDL, 50% anchor (neutral reference)
blended_2025 <- w_ardl * ardl_2025 + (1 - w_ardl) * anchor_2025
blended_2026 <- w_ardl * ardl_2026 + (1 - w_ardl) * anchor_2026

blend_out <- tibble(
  year          = 2025:2026,
  ardl_level    = c(ardl_2025, ardl_2026),
  anchor_level  = c(anchor_2025, anchor_2026),
  blended_level = c(blended_2025, blended_2026),
  anchor_growth = anchor_growth
)

print(blend_out)

# ======================================================================
# SECTION 10 — Sensitivity Visuals + Table
# ======================================================================

w_lo <- 0.3
w_hi <- 0.6

fc <- blend_out |> select(year, ardl_level, anchor_level)
fc <- fc |>
  mutate(
    blend_30 = w_lo * ardl_level + (1 - w_lo) * anchor_level,
    blend_60 = w_hi * ardl_level + (1 - w_hi) * anchor_level
  )

act <- mdf_win |> select(year, fdi_usd) |>
  mutate(value = fdi_usd / 1e9, series = "Actual") |>
  select(year, value, series)

f1 <- fc |> transmute(year, value = blend_30 / 1e9, series = "Anchor-heavy (w=0.30)")
f2 <- fc |> transmute(year, value = blend_60 / 1e9, series = "ARDL-heavy (w=0.60)")

band <- fc |>
  transmute(
    year,
    ymin = pmin(blend_30, blend_60) / 1e9,
    ymax = pmax(blend_30, blend_60) / 1e9
  )

plot_df <- bind_rows(act, f1, f2)

p_sensitivity <- ggplot() +
  geom_ribbon(data = band, aes(x = year, ymin = ymin, ymax = ymax), alpha = 0.15) +
  geom_line(data = filter(plot_df, series == "Actual"),
            aes(x = year, y = value, color = series), linewidth = 1.2) +
  geom_line(data = filter(plot_df, series != "Actual"),
            aes(x = year, y = value, color = series),
            linewidth = 1.1, linetype = "22") +
  geom_point(data = filter(plot_df, year >= 2025),
             aes(x = year, y = value, color = series), size = 2.2) +
  geom_vline(xintercept = 2024.5, linetype = "dashed") +
  scale_y_continuous(labels = label_number(suffix = " bn", accuracy = 1)) +
  labs(
    title = "UAE FDI net inflows: Actuals and blended forecast sensitivity",
    subtitle = "Sensitivity to ARDL weight (w): Anchor-heavy vs ARDL-heavy blends for 2025–2026",
    x = NULL, y = "USD (bn)"
  ) +
  theme_minimal(base_size = 12) +
  theme(
    legend.position = "top",
    legend.title = element_blank(),
    plot.title.position = "plot"
  )

print(p_fdi_clean)
print(p_sensitivity)

# Sensitivity table
w_grid <- seq(0.30, 0.60, by = 0.10)

blend_table <- tibble(w = w_grid) |>
  mutate(
    FDI_2025 = (w * ardl_2025 + (1 - w) * anchor_2025) / 1e9,
    FDI_2026 = (w * ardl_2026 + (1 - w) * anchor_2026) / 1e9
  ) |>
  mutate(
    FDI_2025 = round(FDI_2025, 1),
    FDI_2026 = round(FDI_2026, 1)
  )

print(blend_table)

