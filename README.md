# Pregnancy Data Analysis & Birth Weight Prediction

An empirical statistical analysis and predictive modeling project that investigates the impact of maternal demographic features and lifestyle choices on infant birth weight. This analysis is based on a historical dataset of pregnancies from the San Francisco East Bay area.

---

## 📌 Project Objectives
1. Identify maternal and gestational factors that influence infant birth weight (`bwt`).
2. Fit an optimized Multiple Linear Regression (MLR) framework to forecast exact continuous birth weights.
3. Apply Ordinal Logistic Regression to model and predict categorized infant weight brackets (*Underweight*, *Normal Weight*, *Overweight*).

## 📊 Dataset Overview
* **Observations:** 1,236 instances with 8 baseline predictor variables.

### Variable Dictionary
| Variable | Description | Type / Units |
| :--- | :--- | :--- |
| `case` | Unique identification number per mother | ID |
| `bwt` | Target Variable (MLR): Infant Birth weight | Ounces (Range: 55–176) |
| `gestation` | Total duration of the pregnancy | Days |
| `parity` | Indicator if it's the mother's first pregnancy | Binary ($0$ = First, $1$ = Non-First) |
| `age` | Maternal age | Years (Range: 15–45) |
| `height` | Maternal height | Inches |
| `weight` | Maternal weight | Pounds |
| `smoke` | Smoking status during pregnancy | Binary ($0$ = No, $1$ = Yes) |
| `weight_status` | Target Variable (Ordinal): Weight classifications | Ordinal Factor (`Underweight` <88oz, `Normal` 88-141oz, `Overweight` >141oz) |

---

## 🛠️ Methodology & Modeling Workflow

### 1. Continuous Predictive Modeling: Multiple Linear Regression (MLR)
Variables were isolated step-by-step using a forward selection framework based on statistical significance ($p$-value $< 0.05$):
* **Selected Main Effects Model:** `gestation`, `smoke`, `height`, `parity`, and `weight`. 
* **Omitted Feature:** Maternal `age` was excluded due to statistical insignificance ($p = 0.917$).

$$\text{bwt} = -80.636 + 0.444(\text{gestation}) - 8.383(\text{smoke}) + 1.154(\text{height}) - 3.292(\text{parity}) + 0.050(\text{weight})$$

* **Model Refinement:** An interaction terms expansion revealed that the combined relationship of `gestation * smoke` is highly significant ($p = 0.000532$) and enhances predictive precision.

### 2. Categorical Classification: Ordinal Logistic Regression
Since `weight_status` represents an ordered categorical metric (`Underweight` < `Normal Weight` < `Overweight`), an **Ordinal Logistic Regression Model (Cumulative Link Model / Proportional Odds Logistic Regression)** was deployed:
* **Variable Choice:** Built using forward entry step adjustments matching the structure found in the continuous domain (`gestation + height + smoke + parity`).
* **Optimization:** Evaluated via structural change in residual log-likelihood deviances (`deviance(fit)`) across nested interaction conditions.

---

## 📉 Statistical Insights: Understanding the Low $R^2$ / Model Deviance Explained

The fitted continuous MLR model results in an **Adjusted $R^2$ of $0.2547$**, meaning approximately **$25.5\%$** of the variation in infant birth weight is accounted for by the maternal features. Similarly, the Ordinal Regression indicates a high remaining balance of unexplained structural deviance. 

While a low $R^2$ value might initially appear problematic, it is entirely expected and acceptable within human biological and biomedical studies for the following reasons:

1. **Inherent Biological Complexity:** Infant birth weight is dictated by a vast network of biological, environmental, and socio-economic variables. Critical features—such as maternal/paternal genetics, placental health, maternal nutrition during pregnancy, prenatal medical care, and medical history—are omitted from this historical snapshot.
2. **High Human Variability:** Human physiological data contains substantial natural variance. Two mothers with identical heights, weights, smoking habits, and gestation durations can still naturally give birth to infants with noticeably differing weights.
3. **Primary Focus on Parameter Significance:** The primary objective of this project is to explore and identify *influential factors* rather than generating a flawless physical law forecast. Because the parameters (`gestation`, `smoke`, etc.) yield exceptionally small $p$-values ($p < 2\times 10^{-16}$), the relationships are highly authentic, establishing that these maternal attributes are powerful, statistically valid indicators of health risk regardless of the baseline variance.

---

## 🚀 Future Enhancements: Improving Performance with Machine Learning

While standard linear and generalized linear frameworks provide highly interpretable baselines, they are restricted by rigid assumptions of linearity, proportional odds, and pre-specified interactions. The predictive boundaries and variance capture can be substantially improved by moving beyond classical modeling to more flexible, data-driven Machine Learning (ML) algorithms:

* **Tree-Based Ensembles:** Algorithms like **Random Forests** and **Gradient Boosting Machines (XGBoost, LightGBM)** can automatically capture complex, non-linear dependencies and high-order interaction terms (e.g., compounding impacts of smoking patterns combined with gestation stages) without needing explicit manual declarations.
* **Support Vector Machines (SVM):** Utilizing Radial Basis Function (RBF) kernels can project non-separable physiological metrics into higher-dimensional mathematical spaces to uncover subtle classification boundary lines between infant weight categories.
* **Regularized Regression Techniques:** Utilizing **Ridge** or **Lasso** regression models can help introduce shrinkage penalties to limit structural variance if broader datasets including more maternal features are integrated.
* **Artificial Neural Networks (ANNs):** Multi-Layer Perceptrons (MLPs) could optimize the continuous mapping architecture, maximizing variance tracking capability directly from noisy biomedical patterns.

---

## 💻 Script Execution & Usage

The R runtime script (`group3.R`) orchestrates the parsing, linear stepwise validation, diagnostics, and ordinal evaluations.

### Prerequisites
Install the core modeling engines inside your R instance:
```r
install.packages(c("car", "MASS", "ordinal"))
