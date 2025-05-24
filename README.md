
Harvard Medical School (HMS) Post Graduate Medical Eduacation (PGME)
Global Clinical Scholars Research Training Program (GCSRT) 2025 Cohort
Author: Julian Borges, MD, MS

Capstone Project "Auditing Shortcut Learning and Misclassification in AI-Based Breast Cancer Genomic Subtyping"

This project investigates whether artificial intelligence (AI) models used to classify molecular subtypes of breast cancer based on genomic expression data rely on shortcut features (e.g., age, tumor size, batch ID) rather than true biological signals. It further explores which patient subgroups are most at risk of misclassification — particularly in hormone-sensitive tumors — using the TCGA-BRCA dataset.

# Project Objectives

1.Train and validate machine learning models to classify breast cancer molecular subtypes using gene expression data.

2.Apply feature attribution techniques (e.g., SHAP) to audit the model's reliance on non-genomic features.

3.Analyze misclassification patterns across clinical and genomic subgroups.

4.Propose a framework to detect shortcut learning and flag high-risk predictions before they impact clinical care.

# PAM50 Subtype Prediction — SHAP Explainability (Whats included)

This repository contains code and notebooks for exploring **hidden biases and shortcut learning** in AI models that classify **breast cancer subtypes (PAM50)** using clinical features.

## Contents:
- `PAM50_SHAP_Colab_Notebook.ipynb` — Google Colab version (upload and go)
- `requirements.txt` — Python package dependencies

## Dataset:
> File: `AI-BIAS cleaned_TCGA_PAM50_model_dataset.csv`  
> **Upload manually** into Colab run.

## How to Run:
1. Open the Colab notebook
2. Upload provided CSV when prompted (Ask)

## Summary:
###This pipeline:
- Audits shortcut learning in PAM50 subtype classifiers
- Uses XGBoost + SHAP to visualize feature reliance
- Validates pseudo-SHAP (Stata) vs real SHAP (Python)


## Author
Julian Borges, M.D. — Harvard Medical School GCSRT 2025  
Capstone Project: *"Auditing Shortcut Learning and Misclassification in AI-Based Breast Cancer Genomic Subtyping"*
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.15237131.svg)](https://doi.org/10.5281/zenodo.15237131)

---

