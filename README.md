# breast-cancer-ai-misclassification-

To investigate whether (AI) models used to classify molecular subtypes of breast cancer based on genomic expression data rely on shortcut features rather than true biological signals. It further explores which patient subgroups are most at risk of misclassification — particularly in hormone-sensitive tumors — using the TCGA-BRCA dataset.

# Auditing Shortcut Learning and Misclassification in AI-Based Breast Cancer Genomic Subtyping

This project investigates whether artificial intelligence (AI) models used to classify molecular subtypes of breast cancer based on genomic expression data rely on shortcut features (e.g., age, tumor size, batch ID) rather than true biological signals. It further explores which patient subgroups are most at risk of misclassification — particularly in hormone-sensitive tumors — using the TCGA-BRCA dataset.

---

## Project Objectives

- Train and validate machine learning models to classify breast cancer molecular subtypes using gene expression data.
- Apply feature attribution techniques (e.g., SHAP) to audit the model's reliance on non-genomic features.
- Analyze misclassification patterns across clinical and genomic subgroups.
- Propose a framework to detect shortcut learning and flag high-risk predictions before they impact clinical care.

---

## Repository Structure

breast-cancer-ai-misclassification/
│
├── README.md
├── LICENSE
├── .gitignore
│
├── data/
│   ├── raw/                     # Original data from TCGA/Xena RAWWW
│   ├── processed/               # Cleaned & merged data ready for modeling
│   ├── metadata/                # Variable dictionaries, subtype labels, cohort lists
│
├── notebooks/
│   ├── 01_data_cleaning.ipynb   # Data cleaning and merging script
│   ├── 02_eda.ipynb             # Exploratory data analysis
│   ├── 03_model_training.ipynb  # Model fitting and evaluation
│   ├── 04_shap_analysis.ipynb   # SHAP or feature attribution workflow
│   ├── 05_subgroup_analysis.ipynb # Stratified misclassification analysis
│
├── scripts/
│   ├── run_model.py             # CLI script to run model pipeline
│   ├── run_validation.py        # Script for cross-validation / bootstrap
│   ├── utils.py                 # Helper functions 
│
├── results/
│   ├── figures/                 # Confusion matrices, SHAP plots, histograms
│   ├── tables/                  # Model performance, FN/FP breakdowns
│   ├── outputs/                 # Exported predictions or risk scores
│
├── reports/
│   ├── capstone_summary.pdf     # Final written report
│   ├── slides_deck.pptx         # Presentation slides
│   ├── GCSRT_template.docx      # Formatted protocol/abstract 
│
└── environment.yml              # pip environment file 








