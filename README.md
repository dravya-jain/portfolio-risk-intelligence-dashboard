Portfolio Risk Intelligence Dashboard
SQL + Excel Market Risk and Performance Analysis
Objective
Built a portfolio analytics project to assess whether a six-stock US equity portfolio generated returns to justify the risk taken relative to the S&P 500. The analysis uses market risk measurement, dynamic volatility modelling, VaR backtesting and performance evaluation.
Portfolio Scope
•	Holdings: Broadcom (AVGO), Visa (V), American Express (AXP), AMD (AMD), Marvell Technology (MRVL), and Eli Lilly (LLY)
•	 Benchmark: S&P 500 
•	Period: August 2024 to July 2026 
•	Frequency and currency: Daily observations; USD
Tools 
•	MySQL: Structured positions, equity prices, and benchmark prices; performed data-quality checks; calculated daily returns with LAG() window functions; and produced portfolio market-value, daily P&L, and benchmark-comparison outputs through joins and CTEs. 
•	Excel: Built the risk engine, EWMA volatility/covariance calculations, VaR backtesting, performance analytics, KPI cards, and four-chart dashboard.
Methods Used
•	Historical, parametric, Monte Carlo, and EWMA dynamic one-day 99% Value at Risk (VaR) 
•	60-day rolling annualised volatility and EWMA volatility using λ = 0.94
•	EWMA covariance matrix and dynamic parametric VaR
•	 VaR exception testing and Kupiec unconditional-coverage validation
•	 Sharpe Ratio, Sortino Ratio, Information Ratio, tracking error, active return, and maximum drawdown.


Key Results
Metrics	Results
Historical 99% VaR	$14,686
Parametric 99% VaR	$12,734
Monte Carlo 99% VaR	$11,088
Current EWMA Dynamic 99% VaR	$16,967
Sharpe Ratio	1.19
Information Ratio	1.18
Maximum Drawdown 	-32.7%
EWMA VaR Backtest	7 Exceptions across 440 forecasts
Exception Rate	1.59%
Kupiec Test	Pass

Findings 
The portfolio produced returns at the end of the analysis period that were greater than those produced by the S&P 500 and exhibited positive risk adjusted returns based upon a Sharpe Ratio of 1.19 and an Information Ratio of 1.18. However, the increase in returns was accompanied by increased downside risk, the portfolio recorded a maximum drawdown of -32.7%.
The current EWMA 99 % VaR estimate of about $16,967 exceeds the estimates from both historical, parametric, and Monte Carlo estimates. This indicates that the volatility-weighted approach detected an increase in recent market risk compared to the full  samples static estimates. As expected, EWMA volatility responded faster to shocks than did the 60-day rolling volatility.
There were 7 exceptions during the 440 valid one-day, an exception rate of 1.59 %. The Kupiec unconditional-coverage results showed that the number of exceptions was statistically acceptable for the test period. 
Conclusion
This project demonstrates that performance must be assessed alongside risk. The six-stock portfolio outperformed the S&P 500 during the sample period, there was an increased level of volatility and materially larger drawdowns. The dynamic EWMA offered a timely view into current downside risks, while backtesting demonstrated that the model's forecast coverage was reasonable.
Skills Demonstrated
Data modelling with MySQL and validating data, SQL Joins, CTEs, aggregating and window functions
 Financial Modelling with Excel, Portfolio Risk Measurement, VaR and Expected Shortfall, Volatility/Covariance Modelling, Backtesting Models, Benchmark Relative Performance Analysis, Dashboard Design.
