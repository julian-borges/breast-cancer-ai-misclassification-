
Author: Julian Borges, MD
Harvard Medical School (HMS)
Global Clinical Scholars Research Training Program (GCSRT) 2025 Cohort

"Auditing Shortcut Learning and Misclassification in AI-Based Breast Cancer Genomic Subtyping"

This project investigates whether artificial intelligence (AI) models used to classify molecular subtypes of breast cancer based on genomic expression data rely on shortcut features (e.g., age, tumor size, batch ID) rather than true biological signals. It further explores which patient subgroups are most at risk of misclassification — particularly in hormone-sensitive tumors — using the TCGA-BRCA dataset.

# Project Objectives

1.Train and validate machine learning models to classify breast cancer molecular subtypes using gene expression data.
2.Apply feature attribution techniques (e.g., SHAP) to audit the model's reliance on non-genomic features.
3.Analyze misclassification patterns across clinical and genomic subgroups.
4.Propose a framework to detect shortcut learning and flag high-risk predictions before they impact clinical care.

# PAM50 Subtype Prediction — SHAP Explainability (Whats included)

This repository contains code and notebooks for exploring **hidden biases and shortcut learning** in AI models that classify **breast cancer subtypes (PAM50)** using clinical features.

## Contents:
- `PAM50_SHAP_Explainability_Notebook.ipynb` — Jupyter version (local run)
- `PAM50_SHAP_Colab_Notebook.ipynb` — Google Colab version (upload and go)
- `requirements.txt` — Python package dependencies

## Dataset:
> File: `capstone_step_6_model_data_for_shap_export.csv`  
> **Upload manually** into `/data/` or during Colab run.

## How to Run (2 Options):
### Local (Jupyter)
1. `conda create -n pam50_env python=3.12`
2. `pip install -r requirements.txt`
3. Launch Jupyter and run the notebook

### Google Colab
1. Open the Colab notebook
2. Upload your CSV when prompted

## Summary:
###This pipeline:
- Audits shortcut learning in PAM50 subtype classifiers
- Uses XGBoost + SHAP to visualize feature reliance
- Validates pseudo-SHAP (Stata) vs real SHAP (Python)

## Author
Julian Borges, M.D. — Harvard Medical School GCSRT 2025  
Capstone Project: *"Hidden Biases in AI-Powered Genomic Subtyping of Breast Cancer"*
---

