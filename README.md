# Overview

This project contains the R code, analysis, visualization, and final
submission for APM1205 – Applied Regression Analysis, Formative
Assessment 4.

The assessment investigates factors associated with diamond prices
using the `diamonds` dataset from the `ggplot2` package.

The analysis focuses on:

- Response variable: `price`
- Quantitative predictor: `carat`
- Categorical predictor: `cut`
- Interaction: `carat × cut`

The `cut` variable contains five categories:

- Fair
- Good
- Very Good
- Premium
- Ideal

`Ideal` was selected as the reference category.

---

# Files and Folders

# `FA4_Dummy_Regression.R`

Contains the R commands used to:

1. Load the `ggplot2` package and `diamonds` dataset.
2. Explore and prepare the data.
3. Set `Ideal` as the reference category.
4. Construct dummy variables for `cut`.
5. Fit the additive dummy-variable regression model.
6. Fit the interaction model.
7. Perform the incremental F-test/ANOVA.
8. Create the required scatterplot and regression lines.
9. Save the visualization.

# `FA_Dummy_Regression.Rmd`

Contains the R Markdown version of the analysis and assignment
documentation.

# `FA_Dummy_Regression.html`

Rendered HTML version of the R Markdown document.

# `diamond_price_by_cut.png`

Required visualization showing diamond price versus carat with
different colors and regression lines for the different cut
categories.

# `FA4_Dummy_Regression.pdf`

Final PDF submission containing the answers to Parts A–E, R commands,
relevant results, dummy-variable coding table, regression equations,
ANOVA/incremental F-test results, visualization, and statistical
interpretation.

---

# Statistical Analysis

# Part A – Data Exploration and Preparation

The `diamonds` dataset contains 53,940 observations and 10 variables.

The response variable is `price`, measured in US dollars.

The quantitative explanatory variable is `carat`, which measures
diamond weight in carats.

The categorical explanatory variable is `cut`, which describes the
quality of the diamond cut.

`Ideal` was selected as the reference category.

# Part B – Dummy Variables

Because `cut` has five categories and the regression model includes
an intercept, four dummy variables are used:

- Fair
- Good
- Very Good
- Premium

The all-zero dummy-variable category represents `Ideal`.

# Part C – Additive Regression

The additive model is:

`price ~ carat + cut`

This model allows the different cut categories to have different
intercepts while assuming a common slope for `carat`.

# Part D – Interaction Model

The interaction model is:

`price ~ carat * cut`

This model allows the effect of `carat` on price to vary across the
different cut categories.

The additive and interaction models are compared using an incremental
F-test/ANOVA at:

`alpha = 0.05`

# Part E – Visualization

A scatterplot of price versus carat is created using different colors
for the five cut categories, together with separate linear regression
lines.

# Reproducibility

The analysis can be reproduced using R or RStudio/Posit Cloud.

Required R package:

```r
install.packages("ggplot2")
