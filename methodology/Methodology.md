 # Methodology & Model Framework

## 1. Research Design and Econometric Strategy

This analysis adopts a country-specific time-series framework to evaluate the short-run dynamics of UAE FDI inflows.

A panel approach is deliberately avoided for two reasons:

1. The objective is to model UAE-specific investment behaviour rather than cross-country averages.  
2. Incorporating additional countries would introduce structural heterogeneity (external / different institutional quality, regulatory regimes, capital controls, and fiscal structures) that could obscure UAE-specific transmission mechanisms.

The dataset is annual and spans 2001–2024. Given the relatively small sample and mixed integration properties of macroeconomic variables, a flexible time-series model suited to limited observations is required.

Accordingly, the core empirical framework is an Autoregressive Distributed Lag (ARDL) model.

---

## 2. Data and Variable Construction

### Estimation Window
The final cleaned and refined dataset covers the period 2001–2024, selected to ensure complete and consistent coverage across all variables used in the analysis.

### Variables

| Variable | Description | Source | Rationale 
|----------|------------|-----------|-----------|
| FDI Net Inflows | Current USD | [BoP database World Bank - WDI](https://data.worldbank.org/indicator/BX.KLT.DINV.CD.WD?locations=AE) | Dependent variable capturing realised foreign direct investment activity |
| Brent Crude Oil Price | USD per barrel | [FRED](https://fred.stlouisfed.org/series/POILBREUSDA) | Proxy for regional liquidity and investor confidence |
| Real GDP Growth (UAE) | Annual % change | [IMF WEO](https://www.imf.org/external/datamapper/NGDP_RPCH@WEO/ARE?zoom=ARE&highlight=ARE) | Captures domestic economic momentum and market potential |
| Trade Openness | Trade as % of GDP | [World Bank](https://data.worldbank.org/indicator/NE.TRD.GNFS.ZS) | Measures integration with global markets and structural openness |

FDI inflows are measured in nominal USD. This is intentional, as Brent oil prices are also nominal; maintaining nominal consistency avoids introducing additional deflation assumptions.

FDI data were cross-validated against UNCTAD to ensure consistency.

### Transformations

To stabilize variance and reduce skewness, a natural logarithm transformation is applied to:
  - FDI inflows  
  - Brent oil prices  

GDP growth and trade openness are used in level form.

---

## 3. Stationarity and Integration Properties

Macroeconomic time-series often exhibit stochastic trends. Regressions involving non-stationary variables can produce spurious relationships and unreliable inference. Stationarity testing is therefore conducted to confirm the time-series properties of the data and guide model specification. Stationarity was assessed using:

- Augmented Dickey–Fuller (ADF) test  
- KPSS test  

Results indicate a mix of I(0) and I(1) variables.

### Stationarity Test Summary (5% Significance Level)

| Variable | ADF Level (drift, lag 1) | ADF Diff (drift, lag 1) | ADF 5% CV | KPSS Level (μ) | KPSS 5% CV | Integration Order |
|----------|--------------------------|--------------------------|-------|---------------|-------|-------------------|
| ln(FDI)  | -4.93 | -4.71 | -3.00 | 0.600 | 0.463 | I(1) |
| ln(Brent)| -2.85 | -4.00 | -3.00 | 0.330 | 0.463 | I(1) |
| Trade (% GDP) | -1.42 | -5.26 | -3.00 | 0.864 | 0.463 | I(1) |
| GDP Growth | -3.10 | -5.03 | -3.00 | 0.177 | 0.463 | I(0) |

**Note:** CV denotes the 5% critical value.

ADF results indicate that ln(FDI), ln(Brent), and Trade openness are non-stationary in levels but stationary in first differences. GDP growth is stationary in levels. KPSS results broadly support these findings. Given this mixture, ARDL is appropriate because it:

- Accommodates I(0) and I(1) regressors  
- Does not require pre-differencing  
- Allows flexible lag structures  
- Performs well in small annual samples  

---

## 4. Model Specification and Lag Selection

Given the small sample size, lag selection in the ARDL model is critical to avoid over-fitting and preserve degrees of freedom. Lag length was determined using:

- Akaike Information Criterion (AIC)  
- Bayesian Information Criterion (BIC)  

Lag caps were restricted to (3,3,3,3) to prevent overfitting. Expanding lag caps resulted in unstable information criteria values, particularly with AIC trending toward extreme values — a known small-sample issue.

### Information Criteria Results

| Model (p, q1, q2, q3) | AIC | BIC |
|------------------------|------|------|
| ARDL(2,3,3,0) | **31.379** | 44.958 |
| ARDL(2,3,2,0) | 34.137 | **43.961** |

The AIC-selected model, ARDL(2,3,3,0), achieves the lowest AIC and is therefore adopted as the baseline specification. The BIC-selected alternative, ARDL(2,3,2,0), is more parsimonious but yields a marginally higher AIC.

Both criteria consistently select:

- 2 lags for FDI  
- 3 lags for Brent  
- 0 lags for GDP growth

### Final Adopted Specification

Based on the information criteria results, the following model is adopted as the final model specification is **ARDL(2,3,3,0)**

This **ARDL(2,3,3,0)** captures:

- FDI persistence (lagged dependent variable)  
- Delayed oil effects  
- Short-run growth effects  
- Contemporaneous trade openness impact

---

## 5. Diagnostic Testing and Model Validity

Extensive diagnostic testing is conducted to ensure that coefficient inference is reliable and that model residuals satisfy core regression assumptions.

### Serial Correlation

Breusch–Godfrey LM test detected serial correlation up to lag 2.


- Breusch–Godfrey (lag 2) statistic: [INSERT]  
- p-value: [INSERT]  
- Newey–West lag length: [INSERT]

Since serial correlation biases inference (not coefficient estimates), HAC/Newey–West robust standard errors were applied.


### Heteroskedasticity

Breusch–Pagan and White tests indicate no systematic heteroskedasticity.

- Statistic: [INSERT]  
- p-value: [INSERT]

### Normality

Jarque–Bera test suggests residuals are approximately normally distributed.

- Statistic: [INSERT]  
- p-value: [INSERT]

### Residual Stationarity

An ADF test on residuals confirms they are I(0), supporting stability of the short-run specification.

### Stability Tests

- CUSUM  
- MOSUM  

No evidence of systematic parameter drift or structural breaks was detected over the estimation window. This supports use of the model for near-term projections.

---

## 6. Bounds Test and Long-Run Considerations

A bounds F-test was conducted to assess cointegration.

Results do not indicate evidence of long-run equilibrium relationships.

Accordingly:

- No error correction term (ECM) is estimated  
- The model is explicitly treated as a short-run dynamic framework  

This is consistent with the small annual sample and the focus on near-term forecasting.

---

## 7. Fitted ARDL & Coefficient Interpretation

Key dynamics:

- **Lagged FDI (t-1):** Positive and statistically significant, indicating strong persistence.  
- **Lagged FDI (t-2):** Negative and insignificant, suggesting diminishing multi-year effects.  
- **Brent oil lags:** Alternating signs, consistent with staged investor response (initial uncertainty, liquidity rebound, subsequent adjustment).  
- **GDP growth:** Positive and borderline significant, indicating macro momentum matters but less than persistence.  
- **Trade openness:** Insignificant in short-run specification, suggesting structural rather than cyclical influence.

Full coefficient values and robust t-statistics are reported in the output tables.

---

## 8. Forecast Construction Framework

### 8.1 ARDL Conditional Forecasts

Forecasts for 2025–2026 require exogenous paths.

Base-case assumptions:

- Brent: USD 78.19 (January 2025 observed level), moderating to 72 in 2026  
- GDP growth: IMF WEO projections  
- Trade openness: AR(1) projection  

The ARDL model generates conditional forecasts under these inputs.

---

## 9. Trend Anchor Construction (Base Case Only)

ARDL models can amplify short-run volatility in small samples, particularly with oil-sensitive regressors.

To address this, a structural anchor is introduced for the base case only.

The anchor is constructed as a weighted geometric average of recent log FDI growth, with greater weight assigned to post-COVID years (2023–2024), reflecting the structural shift in UAE FDI momentum.

Let:

FDI_anchor_growth = Σ (w_i × g_i)

Where w_i are weights applied to recent annual log growth rates.

The anchor:

- Captures structural momentum  
- Reduces short-run oil overreaction  
- Reflects observed post-pandemic investment acceleration  

---

## 10. Blended Forecast Specification (Base Case Only)

Final base forecast:

FDI_final = w × FDI_ARDL + (1 − w) × FDI_anchor  

Where:

w = 0.6  

Downside and Upside scenarios remain purely model-driven to preserve stress-test integrity.

---

## 11. Limitations

- Annual data restricts degrees of freedom.  
- Small sample limits structural break detection power.  
- Oil price proxy may indirectly capture broader liquidity effects.  
- Forecasts are conditional on assumed exogenous paths.  
- No formal out-of-sample validation due to short horizon.  

Where available, in-sample metrics (RMSE, Adjusted R²) are reported in the output section.
