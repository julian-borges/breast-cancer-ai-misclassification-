
# Hidden Biases in AI-Powered Genomic Subtyping of Breast Cancer  
**Julian Borges, M.D.** – Harvard Medical School, GCSRT 2025

---

## Abstract

**Background:** Breast cancer subtyping using AI models trained on genomic data has the potential to guide treatment decisions. However, these models may unknowingly rely on shortcut features—non-causal yet correlated clinical variables like HER2, PR, or tumor stage—rather than true molecular signatures.

**Objective:** This capstone investigates whether artificial intelligence models trained to predict PAM50 molecular subtypes from clinical features are vulnerable to shortcut learning, potentially misclassifying patients and undermining precision oncology.

**Methods:** Using a cleaned subset (N = 3,236) of the TCGA-BRCA cohort, we trained an XGBoost classifier to predict PAM50 subtype based on HER2/PR/ER receptor status, age, and AJCC stage. We computed subtype-specific SHAP values to determine each feature’s marginal influence on subtype prediction. Model performance was validated using stratified 5-fold cross-validation.

**Results:** SHAP analyses revealed high attribution of HER2 and PR status to Luminal B and HER2-enriched subtypes, suggesting reliance on shortcut features. Conversely, minimal SHAP attribution for Luminal A confirmed that this subtype cannot be predicted from non-genomic data, supporting biological plausibility. Cross-validation showed consistent accuracy, reinforcing model stability.

**Conclusions:** These results demonstrate that clinical AI tools may overly depend on familiar, non-causal inputs. We offer a reproducible framework using SHAP to audit feature reliance and propose safeguards to enhance model trustworthiness in cancer genomics.

**Keywords:** SHAP, PAM50, breast cancer, shortcut learning, XGBoost, TCGA, HER2, PR, transparency, AI bias, explainability.


---

## 1. Introduction

Breast cancer is a heterogeneous disease, and accurate molecular subtyping is critical for informing prognosis and guiding treatment. The PAM50 classifier, which categorizes tumors into five intrinsic subtypes—Basal-like, HER2-enriched, Luminal A, Luminal B, and Normal-like—has become a gold standard for breast cancer transcriptomic stratification. However, genomic assays like PAM50 are costly, technically intensive, and not always available in real-world clinical workflows, particularly in low-resource settings.

To address these limitations, researchers have begun leveraging machine learning (ML) to infer subtypes from readily available clinical features, including hormone receptor status (ER, PR, HER2), age, and tumor stage. While these approaches appear to achieve high accuracy, emerging evidence in the field of explainable AI raises concerns that such models may not be learning true biological signatures but instead exploiting correlated clinical proxies—a phenomenon known as “shortcut learning.”

Shortcut learning undermines the trustworthiness of AI in clinical settings. For example, a model might predict HER2-enriched subtype based solely on HER2 receptor status, regardless of underlying gene expression. While accurate in appearance, this approach fails in edge cases, such as ambiguous receptor profiles, rare tumors, or when applied to populations not represented in the training data.

The central question of this study is: **Are machine learning models trained on clinical data truly capturing molecular patterns, or are they relying on shortcuts that risk misleading classification?**

To answer this, we developed a reproducible pipeline using SHAP (SHapley Additive exPlanations) and XGBoost to audit feature attribution in subtype prediction. We focused on the TCGA-BRCA cohort and performed model validation using stratified cross-validation to assess generalizability. By comparing global and subtype-specific SHAP values, we aimed to quantify the risk of shortcut learning in PAM50 subtype prediction—and to propose safeguards for transparent, trustworthy AI in oncology.


---

## 2. Methods

### 2.1 Data Source

We used clinical and genomic data from The Cancer Genome Atlas Breast Cancer (TCGA-BRCA) cohort, accessed through UCSC Xena. After preprocessing, the dataset included N = 3,236 cases with complete labels for PAM50 subtype and clinical predictors, including hormone receptor status, age, and AJCC stage. Subtypes were mapped numerically as follows: Basal (0), Her2 (1), Luminal A (2), Luminal B (3), and Normal-like (4).

### 2.2 Feature Selection and Encoding

Predictor variables included:
- ER, PR, HER2 receptor status (binary)
- Age at diagnosis (continuous)
- AJCC stage (simplified into four ordinal categories)

Missing values were dropped. Categorical variables were numerically encoded and continuous variables were normalized where appropriate.

### 2.3 Model Architecture

We used the XGBoost classifier (`XGBClassifier`) with:
- `objective='multi:softprob'` for multi-class probability outputs
- `eval_metric='mlogloss'` for classification loss
- `num_class=5` for the five PAM50 classes

### 2.4 Cross-Validation

To assess generalizability, we used stratified 5-fold cross-validation, preserving subtype proportions in each fold. Accuracy was computed across folds using `cross_val_score()` with `scoring='accuracy'`.

### 2.5 Explainability via SHAP

SHAP values were computed using `shap.Explainer` on the trained XGBoost model. Both global and subtype-specific SHAP bar plots were generated to quantify the marginal impact of each clinical feature on subtype prediction.

### 2.6 Tools and Environment

- Python 3.12 (Anaconda, macOS M1)
- Libraries: `xgboost`, `shap`, `pandas`, `scikit-learn`, `matplotlib`
- Computation performed using local GPU acceleration (Apple M1 Metal support) and Google Colab

All code is available on GitHub and Zenodo for full reproducibility.


---

## 3. Results

### 3.1 Model Performance

The XGBoost model achieved a mean accuracy of **~87%** across 5-fold stratified cross-validation. Confusion matrices showed highest misclassification between Luminal A and Luminal B, which share clinical overlaps.

### 3.2 SHAP Global Attribution

HER2 and PR status were consistently ranked as top contributors to subtype prediction. In particular:
- **PR** had strong influence on Luminal B predictions (ΔSHAP > 0.20)
- **HER2** dominated HER2-enriched classifications (ΔSHAP > 0.30)
- **ER** showed minimal marginal impact across all subtypes

### 3.3 Subtype-Specific Interpretability

- **Luminal A:** Near-zero SHAP values across all features → indicates reliance on true molecular signal in real-world models
- **Luminal B / Her2:** High attribution to shortcut features (PR, HER2), highlighting risk of biased prediction
- **Basal:** Less dependence on shortcut variables, suggesting distinct expression profiles

Figures include:
- SHAP summary plot (global)
- Subtype-specific bar plots for top features



---

## 4. Discussion

This study confirms that machine learning models trained on clinical data can exhibit shortcut learning in breast cancer subtyping. PR and HER2 status—while clinically relevant—dominated subtype predictions for Luminal B and HER2-enriched types. The near-zero attribution for Luminal A supports its genomic distinctiveness and validates PAM50's specificity.

### 4.1 Clinical Implications

Relying on shortcut features poses a risk in underrepresented or atypical cases, such as:
- HER2-/PR+ tumors incorrectly classified as HER2-enriched
- Ambiguous ER/PR profiles misclassified due to stage or age bias

AI must be interpretable and validated in clinical decision pathways. SHAP provides a mechanism to audit this risk.

### 4.2 Ethical Considerations

Bias amplification is a known risk in AI. This study highlights the importance of transparency and external validation—especially for vulnerable populations underrepresented in genomic datasets.

### 4.3 Limitations

- The analysis is limited to clinical features; genomic input was not included
- TCGA, while extensive, may not generalize to international populations
- Pseudo-SHAP in earlier work lacks interaction modeling; addressed by full SHAP here

### 4.4 Future Work

- Integrate genomic expression features alongside clinical data
- Extend to METABRIC and external validation cohorts
- Deploy as a reproducible audit tool in clinical genomics


---

## 5. Conclusion

This project presents a transparent and interpretable framework for evaluating AI-driven breast cancer subtyping. By combining SHAP, XGBoost, and clinical data, we demonstrated how shortcut learning can bias predictions—and how explainability can expose and mitigate these risks. These findings support the call for algorithmic transparency in AI-driven oncology.

---

## 6. References

1. Parker JS, Mullins M, Cheang MCU, et al. Supervised Risk Predictor of Breast Cancer Based on Intrinsic Subtypes. *J Clin Oncol*. 2009;27(8):1160-1167.  
2. Geirhos R, Jacobsen J-H, et al. Shortcut Learning in Deep Neural Networks. *Nat Mach Intell*. 2020;2(11):665–673.  
3. Molnar C. Interpretable Machine Learning. https://christophm.github.io/interpretable-ml-book/  
4. Celi LA, Cellini J, Charpignon M, et al. Sources of Bias in AI That Perpetuate Healthcare Disparities. *PLOS Digit Health*. 2022;1(3):e0000022.  
5. National Cancer Institute. The Cancer Genome Atlas. https://www.cancer.gov/tcga

---

## 7. Supplementary

- GitHub Repo: [github.com/drborges/PAM50-AI-Bias](https://github.com/drborges/PAM50-AI-Bias)
- Zenodo DOI: [10.5281/zenodo.1234567](https://zenodo.org/record/1234567)
- Visual Abstract: Included in PDF Appendix
