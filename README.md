# UAE FDI Resilience Analysis (2025–2026)

This repository contains a **scenario-based econometric assessment of UAE Foreign Direct Investment (FDI) resilience** under varying global financial and energy conditions.

The analysis applies an **Autoregressive Distributed Lag (ARDL) framework**, complemented by a **trend-anchor adjustment**, to evaluate short-run macroeconomic drivers and construct forward-looking FDI forecasts for **2025–2026**.

---

# Key Findings

- UAE FDI entered a structurally stronger phase in 2023–2024, with inflows reaching ~\$45bn in 2024.
- Short-run volatility remains linked to oil prices and global liquidity conditions.
- Structural positioning across technology, logistics, and advanced manufacturing supports sustained inflows beyond cyclical normalization.
- A strategic anchor-heavy baseline (w = 0.3) suggests inflows remain elevated in 2025 with gradual moderation in 2026.

---

# Executive Slides

Executive policy brief presentation:

👉 **[UAE FDI Resilience — Executive Policy Brief](slides/UAE_FDI_Resilience_ARDL_Forecast_2025_2026.pdf)**

These slides summarize the **strategic insights, forecast scenarios, and policy implications** derived from the econometric analysis.

---

# Full Report

Full policy brief and analysis:

👉 **[UAE_FDI_Resilience_2025_2026.md](UAE_FDI_Resilience_2025_2026.md)**

The report includes:

- Background and economic context  
- Model framework and estimation  
- Scenario forecasts  
- Strategic interpretation and policy implications  

---

# Methodology

Technical documentation of the modelling framework:

👉 **["Methodology & Model Framework"](methodology/Methodology.md)**

Key components include:

- ARDL short-run dynamic framework
- Unit root testing (ADF & KPSS)
- Lag selection via AIC
- HAC robust inference (Newey–West)
- CUSUM / MOSUM stability diagnostics
- Trend anchor adjustment
- Blended forecast sensitivity analysis

---

# Code

R implementation of the econometric model:

👉 **[ARDL Model Script](code/r/uae_fdi_resilience.R)**

The script includes:

- Data ingestion and transformation  
- Stationarity testing  
- ARDL model estimation  
- Diagnostic testing  
- Scenario forecasting  
- Trend anchor and blended forecasts  

---

# Data

Input datasets used for the analysis:

👉 **[Raw Data Files](data)**

Sources include:

- World Bank — FDI net inflows  
- Brent crude oil prices (FRED)  
- Real GDP growth  
- Trade openness (% of GDP)

---

# Repository Structure

The repository is organized as follows:

```
/code/r
   uae_fdi_resilience.R

/data
   API_BX.KLT.DINV.CD.WD_DS2_en_csv_v2_130169.csv
   API_NE.TRD.GNFS.ZS_DS2_en_csv_v2_130005.csv
   GDPg.xls
   POILBREUSDA.csv

/methodology
   Methodology.md
   /figures
      anchor_fdi.png
      anchor_growth.png
      blended_forecast.png
      cusum.png
      mosum.png

/outputs
   anchor_heavy_forecasts.png
   ardl_scenario_results_2025_2026.csv
   blended_formula.png
   fdi_blend_sensitivity.png
   fdi_historical.png

/slides
   UAE_FDI_Resilience_Policy_Brief.pdf

README.md
UAE_FDI_Resilience_2025_2026.md
```

---

# Author

**Odud Bin Yousuf**
