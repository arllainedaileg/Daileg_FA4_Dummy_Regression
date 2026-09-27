# Load the ggplot2 package
library(ggplot2)

# Load the diamonds dataset
data(diamonds)

# View the first few observations
head(diamonds)

# Check the structure of the dataset
str(diamonds)

# Get summary statistics
summary(diamonds)

# Number of observations
nrow(diamonds)

# Number of variables
ncol(diamonds)

diamonds$cut <- factor(diamonds$cut, ordered = FALSE)
diamonds$cut <- relevel(diamonds$cut, ref = "Ideal")

# Check the order of the categories
levels(diamonds$cut)

# PART B - CONSTRUCTING DUMMY VARIABLES

diamonds$Fair <- ifelse(diamonds$cut == "Fair", 1, 0)
diamonds$Good <- ifelse(diamonds$cut == "Good", 1, 0)
diamonds$Very_Good <- ifelse(diamonds$cut == "Very Good", 1, 0)
diamonds$Premium <- ifelse(diamonds$cut == "Premium", 1, 0)

# Display the first few rows of the dummy variables
head(diamonds[, c("cut", "Fair", "Good", "Very_Good", "Premium")])


# PART C - ADDITIVE DUMMY-VARIABLE REGRESSION

model1 <- lm(price ~ carat + cut, data = diamonds)

# Display the regression results
summary(model1)

coef(model1)

cat("\n")
cat("ADDITIVE REGRESSION EQUATION\n")
cat("\n")

cat(
  "Price = ",
  round(coef(model1)[1], 3),
  " + ",
  round(coef(model1)[2], 3),
  "(carat)",
  " + cut effects\n"
)

cat("\nReference category: Ideal\n")

cat("\n")
cat("R-squared =", round(summary(model1)$r.squared, 3), "\n")
cat(
  "Percentage of variation explained =",
  round(summary(model1)$r.squared * 100, 3),
  "%\n"
)

cat("\n")
cat("INTERPRETATION OF CARAT:\n")
cat(
  "Holding cut constant, a 1-carat increase in diamond weight\n",
  "is associated with an increase in predicted price equal to\n",
  "the estimated carat coefficient.\n"
)

cat("\n")
cat("INTERPRETATION OF CUT DUMMY VARIABLES:\n")
cat(
  "Each cut coefficient represents the difference in predicted\n",
  "price compared with the Ideal reference category,\n",
  "holding carat constant.\n"
)

cat("\n")
cat("SLOPE INTERPRETATION:\n")
cat(
  "The additive model has the same carat slope for all cut\n",
  "categories because there are no interaction terms.\n"
)


# PART D - INTERACTION BETWEEN CARAT AND CUT

model2 <- lm(price ~ carat * cut, data = diamonds)

# Display the regression results
summary(model2)

cat("\n")
cat("INTERACTION COEFFICIENTS\n")
cat("\n")

interaction_coefficients <- coef(summary(model2))

# Display coefficients containing "carat:cut"
interaction_coefficients[
  grep("carat:cut", rownames(interaction_coefficients)),
  ,
  drop = FALSE
]

cat("\n")
cat("HYPOTHESES:\n")
cat("\n")
cat("H0: There is no interaction between carat and cut.\n")
cat("    The effect of carat on price is the same for all cuts.\n")
cat("\n")
cat("H1: There is an interaction between carat and cut.\n")
cat("    The effect of carat on price differs across cuts.\n")

anova_result <- anova(model1, model2)

cat("\n")
cat("INCREMENTAL F-TEST / ANOVA\n")
cat("\n")

print(anova_result)

F_value <- anova_result$F[2]
p_value <- anova_result$`Pr(>F)`[2]

cat("\n")
cat("F-statistic =", round(F_value, 3), "\n")
cat("p-value =", format.pval(p_value, digits = 4), "\n")

alpha <- 0.05

cat("\n")
cat("\n")
cat("STATISTICAL DECISION\n")
cat("\n")

if (p_value < alpha) {
  cat("Decision: Reject H0.\n")
  cat(
    "Conclusion: There is statistically significant evidence\n",
    "of an interaction between carat and cut.\n"
  )
} else {
  cat("Decision: Fail to reject H0.\n")
  cat(
    "Conclusion: There is not enough evidence of an interaction\n",
    "between carat and cut.\n"
  )
}

cat("\n")
cat("PRACTICAL INTERPRETATION:\n")
cat(
  "The additive model assumes that carat has the same effect\n",
  "on price for every cut category. The interaction model allows\n",
  "the carat effect to change depending on the cut category.\n"
)

# Create the required scatterplot with regression lines.

diamond_plot <- ggplot(
  diamonds,
  aes(x = carat, y = price, color = cut)
) +
  geom_point(alpha = 0.3) +
  geom_smooth(
    method = "lm",
    se = FALSE
  ) +
  labs(
    title = "Diamond Price versus Carat by Cut",
    x = "Carat",
    y = "Price (US Dollars)",
    color = "Cut"
  ) +
  theme_minimal()


# Display the graph
print(diamond_plot)

if (!dir.exists("figures")) {
  dir.create("figures")
}

# Save the graph to the figures folder.

ggsave(
  filename = "figures/diamond_price_by_cut.png",
  plot = diamond_plot,
  width = 9,
  height = 6,
  dpi = 300
)

cat("\n")
cat("FINAL STATISTICAL SUMMARY\n")
cat("\n")

cat("\n")
cat(
  "The diamonds dataset contains",
  nrow(diamonds),
  "observations and",
  ncol(diamonds),
  "variables.\n"
)

cat("\n")
cat("Response variable: price\n")
cat("Quantitative predictor: carat\n")
cat("Categorical predictor: cut\n")
cat("Reference category: Ideal\n")

cat("\n")
cat(
  "The additive model has an R-squared of",
  round(summary(model1)$r.squared, 3),
  ".\n"
)

cat("\n")
cat(
  "The incremental F-test gives F =",
  round(F_value, 3),
  "and p =",
  format.pval(p_value, digits = 4),
  ".\n"
)

if (p_value < alpha) {
  cat(
    "\nThe p-value is less than 0.05, so the null hypothesis is\n",
    "rejected. This provides evidence that the effect of carat\n",
    "on price differs across at least some cut categories.\n"
  )
} else {
  cat(
    "\nThe p-value is greater than 0.05, so the null hypothesis\n",
    "is not rejected.\n"
  )
}

cat("\n")
cat(
  "The graph has been saved as:\n",
  "figures/diamond_price_by_cut.png\n"
)

cat("\n")
cat("END OF FORMATIVE ASSESSMENT 4\n")