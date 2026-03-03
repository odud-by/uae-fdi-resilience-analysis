# UAE FDI Outlook (2025–2026): Resilience, Scenarios, and Policy Levers

## Executive Overview

Foreign Direct Investment (FDI) plays a central role in the UAE’s economic diversification and long-term growth strategy. While recent years have demonstrated strong investment momentum, short-term FDI inflows remain sensitive to global financing conditions, regional oil price movements, and shifts in investor confidence.

Over the past 2 years, global monetary tightening has raised the cost of capital and constrained cross-border financing. In the UAE, domestic financial conditions tightened alongside global rates, as the Central Bank moved in step with the US Federal Reserve. At the same time, movements in oil prices continue to shape regional liquidity and investor sentiment, highlighting how external macroeconomic conditions influence investment timing.

In this context, understanding the resilience of UAE FDI has become essential. This analysis therefore examines UAE FDI inflows over the 2025–2026 forecast horizon using a scenario-based framework. Rather than solely focusing on forecast accuracy, the objective is to assess how recent investment momentum performs under different global conditions, identify the key drivers of short-term volatility, and determine which factors are most relevant for stabilizing outcomes over the next 2 years.

---

## Evolution of UAE FDI Inflows 

To assess forward-looking resilience, it is first necessary to examine how UAE FDI has behaved historically. Between 2001 and 2024, inflows exhibited clear cyclical responses to global shocks alongside distinct phases of structural acceleration.

![Historical FDI Chart](outputs/fdi_historical.png)

The chart highlights three distinct regimes in UAE FDI inflows:

**1. Early-2000s Expansion**  
The early-2000s expansion in FDI aligned with the UAE’s emergence as a regional trade and logistics hub, supporting increased project finance and cross-border investment.

**2. Global Financial Crisis and Recovery**  
The global financial crisis of 2008–09 reduced inflows by more than 90% between 2007 and 2009. Unlike many emerging markets, inflows rebounded within a few years rather than entering prolonged stagnation. By 2019, FDI had recovered to nearly USD 17.9 billion, supported by greenfield activity and further expansion across logistics, free zones, and service-related sectors.

**3. Post-COVID Structural Step-Up**  
The COVID period diverged from conventional crisis patterns: instead of contracting, inflows remained elevated through 2020–2022. The post-pandemic phase marked a structural step-up rather than a cyclical rebound. In 2023, inflows jumped to USD 30.7 billion, ranking the UAE among the world’s leading FDI destinations and second globally in greenfield project announcements. In 2024, inflows reached a record USD 45.6 billion, placing the UAE in the global top 10 and accounting for a dominant share of Middle East inflows.

The magnitude and consistency of recent inflows across greenfield projects, reinvestments, and diversified sectors indicate a distinct upward shift rather than a typical cyclical upswing. This raises an important policy question: how durable is this momentum under tighter global conditions?

---

## Policy Question & Decision Context

From a policy perspective, the key issue is not whether FDI will be marginally higher or lower in a given year. The more relevant questions are:

- How exposed are UAE FDI inflows to external shocks over the next 1-2 years?
- Which macroeconomic variables most strongly influence investor behaviour in the short term?
- What range of outcomes should decision-makers reasonably plan for under different global scenarios?

These questions are particularly relevant in an environment where capital remains selective, post-COVID investment pipelines are still adjusting, and competition for international investment remains intense. To address these questions clearly, it is important to define the scope and limits of the analysis.

---

## What This Analysis Is (and Is Not)

### What This Analysis Is
- A short-term assessment of UAE FDI resilience for the forecast period of 2025–2026  
- A scenario-based framework for evaluating upside and downside risks under alternative global conditions  
- An empirical analysis of short-run macroeconomic channels affecting FDI inflows  
- A policy-oriented interpretation grounded in observed economic relationships  

### What This Analysis Is Not
- A long-run structural growth or development model  
- A precise point prediction of future FDI inflows  
- A cross-country benchmarking or panel-data exercise  
- An academic exercise focused on econometric optimization  

---

## Analytical Framework & Model

This analysis uses a short-run time-series framework to evaluate how UAE FDI inflows respond to changes in key macroeconomic and financial conditions over the short term.

The core empirical tool is an Autoregressive Distributed Lag (ARDL) model estimated on annual UAE data from 2001 to 2024. The ARDL specification is well suited to the dataset, as it accommodates variables with mixed integration orders and captures short-run dynamics without requiring pre-differencing. 

However, ARDL-based forecasts can overreact to short-term fluctuations. To mitigate this, base-case forecasts are blended with a trend anchor derived from recent realized FDI growth, keeping projections grounded in observed momentum while preserving sensitivity to macroeconomic conditions.  

The ARDL model's role is to:

- Quantify the short-run exposure of FDI inflows to movements in oil prices, economic growth, and trade openness  
- Capture delayed responses and persistence effects that are common in investment data  
- Provide a baseline trajectory around which alternative scenarios can be constructed  


### Data & Estimation Window

The estimation sample covers the period from 2001 to 2024, reflecting the availability and consistency of key macroeconomic data for the UAE. Data are updated through 18 November 2025; however, 2024 is the most recent year with complete annual observations across all variables. Accordingly, 2025 and 2026 are treated as forecast periods. Variables are selected to balance economic relevance with data reliability and include:

- UAE FDI net inflows (current US dollars)  
- Brent crude oil prices (annual average)  
- Real GDP growth  
- Trade Openness (trade as a percentage of GDP)  

Given the short annual sample and the presence of mixed integration orders, the analysis focuses on robust short-run inference rather than formal long-run cointegration relationships. 

### Model Diagnostics & Stability

A comprehensive diagnostic framework is applied to ensure statistical reliability and structural stability of the ARDL specification.

The model is tested for serial correlation, heteroskedasticity, residual normality, parameter stability, and potential long-run cointegration. Where serial correlation is detected, inference is conducted using heteroskedasticity- and autocorrelation-consistent (Newey–West HAC) standard errors.

Results indicate:

- No evidence of heteroskedasticity  
- Approximately normal residuals  
- Stable parameters over the estimation window  
- No evidence of long-run cointegration  

Accordingly, the model is treated explicitly as a short-run dynamic framework suitable for conditional scenario-based forecasting.

A detailed technical exposition of model specification, diagnostics, and forecast construction is provided in the ["Methodology & Model Framework"](methodology/Methodology.md).

---

## ARDL-Implied FDI Dynamics

The ARDL estimates highlight four short-run transmission channels shaping UAE FDI dynamics:

- **Persistence (Lagged FDI):**  FDI inflows exhibit strong year-to-year persistence, with last-year inflows influencing next-year outcomes. This reflects the role of project pipelines, reinvestment decisions, and implementation lags in large-scale investments. Once momentum builds, it tends to carry into the following year before gradually dissipating.

- **Oil-Linked Liquidity Effects:**  Oil prices affect FDI in stages rather than instantaneously. Initial oil shocks generate caution and uncertainty, but as liquidity improves and confidence returns, inflows recover. This means UAE FDI moves closely with regional liquidity conditions.

- **Domestic Growth & Trade Openness:**  Real GDP growth supports FDI but plays a secondary role relative to persistence and oil dynamics. 
  Trade openness does not materially influence year-to-year fluctuations and operates more as a structural backdrop than a cyclical driver.
  
These channels provide the foundation for interpreting the results that follow.

---

## Scenario Analysis (2025–2026)

### Scenario Framework & Assumptions

Rather than relying on a single forecast path, this analysis evaluates UAE FDI outcomes under a small set of macroeconomic scenarios. Each scenario reflects a plausible combination of global financial conditions, energy market dynamics, and regional growth expectations over the 2025–2026 horizon.

#### Base Case: Gradual Normalization

The base case reflects a continuation of recent trends, with global financial conditions easing gradually but remaining tighter than the pre-2022 period. Energy prices stabilize near recent averages, and UAE growth remains solid but not accelerating.

Key assumptions:
- Brent crude reflects the observed January 2025 levels, with prices moderating toward the USD 70–75 range in 2026, consistent with major energy market outlooks (EIA/IEA).
- UAE real GDP growth remains close to 5%, reflecting projections from the IMF World Economic Outlook.
- Trade openness remains broadly stable, with no major structural shift  

#### Downside Case: Prolonged External Tightness

The downside scenario reflects a more challenging global environment, where tighter financial conditions persist. Softer energy prices reduce regional liquidity, and investors become more selective in committing capital.

Key assumptions:
- Brent crude declines toward the USD 60–65 range  
- Global financing conditions remain restrictive 
- UAE growth moderates but remains positive  

#### Upside Case: Liquidity and Confidence Rebound

The upside scenario reflects a faster-than-expected improvement in global financial conditions, alongside stronger energy prices and improved investor confidence.

Key assumptions:
- Brent crude moves toward the USD 85–90 range  
- Global financial conditions ease more rapidly than anticipated  
- UAE growth remains robust, supported by strong domestic demand and external inflows  

### ARDL Scenario Results

Using the estimated ARDL framework and the macroeconomic assumptions above, conditional forecasts for 2025 and 2026 are generated. The table below reflects pure ARDL forecasts, prior to any anchor adjustment or blending.

| Scenario   | FDI 2025 (USD bn) | FDI 2026 (USD bn) |
|------------|-------------------|-------------------|
| Base       | 42.8              | 30.8              |
| Downside   | 36.9              | 33.2              |
| Upside     | 46.9              | 31.3              |

Key takeaways from the ARDL scenarios:

- In the Upside scenario, 2025 inflows are greater than the Base, supported by stronger oil-linked liquidity and improved investor confidence.  
- In the Downside scenario, 2025 inflows are lower than the Base, reflecting tighter global financial conditions and weaker energy prices.
- Across scenarios, 2026 outcomes converge, suggesting partial normalization after the initial scenario shock.
- Differences across scenarios are most pronounced in 2025, when oil effects and persistence are strongest.

While the ARDL results capture historical transmission mechanisms, they do not fully incorporate the post-2023 structural shift. The next section introduces a trend anchor to reflect recent momentum and assess how conclusions change when forecasts are anchored to post-pandemic inflow dynamics. 

---

## Trend Anchor & Momentum Adjustment

The ARDL projections are based on historical relationships in the data. As a result, they naturally allow for some normalization following exceptionally strong inflows. However, the scale of FDI in 2023–2024 suggests a higher investment trajectory than implied by the prior decade.

The anchor is constructed using a weighted average of recent FDI growth, with greater emphasis on post-pandemic years. This approach allows recent momentum to influence the forward-looking baseline without discarding the discipline of the ARDL framework. 

### Trend Anchor Projection

The structural trend anchor generates the following anchor projection based solely on recent FDI growth.

| Projection Type | FDI 2025 (USD bn) | FDI 2026 (USD bn) |
|-----------------|-------------------|-------------------|
| Trend Anchor    | 57.3              | 72.0              |

The anchor projection maintains a substantially higher trajectory relative to the ARDL-based scenarios. This reflects the assumption that observed 2023–2024 inflows represent sustained strength rather than a temporary spike.

Unlike the ARDL framework, the anchor path does not incorporate oil-price sensitivity or scenario stress testing. Instead, it embeds recent realized growth directly into the forward outlook. As such, the anchor should be interpreted as a momentum-driven reference path rather than a standalone forecast.

---

## Blended FDI Forecast

To balance model-implied normalization with recent structural momentum, a blended forecast is constructed.

The blended forecast combines the ARDL Base forecast and the Trend Anchor projection using a fixed weight:

![Blended Forecast Formula](outputs/blended_formula.png)

For the neutral specification, w_ARDL = 0.5. This assigns equal weight to:
- The historical dynamics captured by the ARDL model  
- The recent inflow acceleration reflected in the trend anchor  

Applying this weight produces the following blended Base forecast:

| Forecast Type | FDI 2025 (USD bn) | FDI 2026 (USD bn) |
|-----------------|-------------------|-------------------|
| Blended (w = 0.5) | 50.1 | 51.4 |

This neutral blend (w_ARDL = 0.5) is used as the technical reference case; the strategic baseline for policy interpretation is introduced later (w = 0.3).

## Sensitivity to ARDL Weight

The blended forecast depends on the weight (w) assigned to the ARDL model relative to the trend anchor. To test robustness, forecasts are recalculated across a reasonable range of weights from w = 0.3 to 0.6.

| w | FDI 2025 (USD bn) | FDI 2026 (USD bn) |
|--------|-------------------|-------------------|
| 0.3    | 53.0              | 59.7              |
| 0.4    | 51.5              | 55.5              |
| 0.5    | 50.1              | 51.4              |
| 0.6    | 48.6              | 47.3              |

While the table shows the numerical range, the chart below illustrates how the forecast path shifts as the weight moves from Anchor-heavy to ARDL-heavy specifications.

![ARDL Weight Sensitivity](outputs/fdi_blend_sensitivity.png)

Several clear patterns emerge:

- As the weight on the ARDL model increases, projected inflows decline in both years.  
- The adjustment is more pronounced in 2026, where outcomes range from USD 59.7 bn under an anchor-heavy specification (w = 0.3) to USD 47.3 bn under an ARDL-heavy specification (w = 0.6). 
- This dispersion captures the balance between recent acceleration and historical mean reversion.

Across the examined weights, the central pattern holds: 2025 remains elevated, while 2026 reflects partial moderation depending on the weight assigned to the ARDL model.

---

## Strategic Recommendation: Anchor-Heavy Specification

The trade-off between the ARDL model and the trend anchor framework illustrates why blending is necessary. The ARDL specification captures historical dynamics and allows for partial normalization after exceptionally strong inflows. The trend anchor, by contrast, reflects the acceleration evident in 2023–2024.

An equal-weighted blend (w = 0.5) provides a neutral midpoint between normalization and momentum. However, forward-looking evidence supports an anchor-heavy baseline for policy interpretation. In practice, w = 0.3 better aligns the forecast with current structural momentum. This recommendation rests on three key considerations:

**1. Multi-year capital deployment in advanced technology**

Large-scale AI and data infrastructure investments are committed and phased beyond 2025. The Microsoft–G42 partnership includes a USD 15 billion investment program, with significant deployment completed by end-2025 and additional capital scheduled through 2026–2029. The UAE’s 5 GW “Stargate” AI campus, supported by global partners including Nvidia and Oracle, is rolling out capacity through 2026. These long-horizon capex programs support a forecast that moderates gradually rather than reverting quickly.

**2. Ongoing greenfield pipeline, not fully realized flows**

While full-year 2025 inflow data are not yet available, greenfield announcements remain strong. Early-2025 project data show continued activity across technology, manufacturing, and free zones, with the UAE ranking second globally in project announcements and project values rising materially relative to prior years. Greenfield projects typically deploy capital over multiple years. This reduces the likelihood of an abrupt reversion toward pre-2023 inflow levels.

**3. Explicit structural investment strategy**

The National Investment Strategy 2031 targets raising annual FDI to AED 240 billion and expanding total FDI stock to AED 2.2 trillion. Complementary reforms — including 100% foreign ownership provisions and the NextGen FDI programme — reinforce competitiveness. This is an expansionary medium-term policy push, reinforcing that the post-2023 step-up reflects stronger positioning rather than a temporary surge.

---

Using the strategic baseline (w = 0.3) for policy interpretation avoids understating the sustained component in recent inflows. The resulting forecast path under w = 0.3 is shown below.

![Anchor heavy forecasts](outputs/anchor_heavy_forecasts.png)

The chart highlights the post-2023 step-up and sustained increase through 2026 under this specification, reinforcing it as the most realistic central forecast for 2025–2026.

---

## Policy Implications

Short-term FDI volatility is driven by global liquidity and oil prices, but durability is shaped by domestic policy. Not all drivers are policy-controllable: global monetary conditions, energy prices, and shifts in risk sentiment can temporarily compress inflows. Overreaction to cyclical pressures risks policy overreach.

The relevant policy question for 2025–2026 is not how to eliminate volatility, but how to prevent temporary shocks from undermining the durability of inflows. 

**1. Momentum Signaling & Investor Retention**

The 2023–2024 step-up created visible investment momentum. Policy signaling should be used to lean into this momentum and reflect strengthened positioning rather than a temporary surge. Existing investors represent one of the most reliable channels for sustained FDI. Prioritizing after-care, expansion support, and reinvestment facilitation can stabilize inflows even if new project announcements fluctuate.

**2. Regulatory Stability & Predictability**
- Maintain and actively promote 100% foreign ownership provisions  
- Preserve long-horizon visa pathways  
- Ensure transparent dispute-resolution mechanisms and service-level timelines  

Reducing regulatory uncertainty lowers the pass-through from oil volatility to investment decisions. Predictability itself becomes a stabilizing force.

**3. Platform Consistency & Structural Investment**

Stable free-zone rules, streamlined licensing, and consistent incentive frameworks reinforce credibility. Frequent rule changes would amplify normalization pressures embedded in historical dynamics. Continued investment in logistics, digital infrastructure, education, and advanced manufacturing reduces reliance on cyclical liquidity effects and strengthens the structural drivers underlying recent inflows.

---

## Conclusion & Next Steps

UAE FDI has entered a new phase. The scale and breadth of inflows in 2023–2024 represent more than a cyclical rebound; they reflect strengthened structural positioning across technology, logistics, advanced manufacturing, and digital infrastructure.

Accordingly, the anchor-heavy specification (w = 0.3) is adopted as the strategic baseline for 2025–2026. Under this path, inflows remain elevated in 2025 and moderate gradually in 2026, reflecting resilience with measured normalization rather than sharp reversion.

The strategic priority for policymakers is therefore consistency. Maintaining regulatory clarity, reinforcing investment facilitation, and supporting sectoral diversification will matter more than reactive counter-cyclical adjustments to external shocks.

Future refinements could include:
- Incorporating additional explanatory variables such as global risk indicators, sector-level investment data, or capital market conditions  
- Moving toward higher-frequency data as availability improves  
- Testing for structural breaks explicitly as post-2024 data accumulate  

As new data emerge, the blend between historical dynamics and structural momentum can be recalibrated. For now, the evidence supports a disciplined but momentum-aware outlook.

The central message is clear: UAE FDI remains exposed to global cycles, yet its medium-term trajectory is increasingly shaped by domestic structural strength. Sustaining that strength is the critical policy task for 2025–2026.

