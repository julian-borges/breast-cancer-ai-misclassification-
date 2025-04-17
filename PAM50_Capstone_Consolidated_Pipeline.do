
* Harvard Medical School GCSRT 2025
* Auditing Shortcut Learning and Misclassification in AI-Based Breast Cancer Genomic Subtyping
* Author: Julian Borges, M.D. — Harvard Medical School GCSRT 2025
* Capstone Project: "Hidden Biases in AI-Powered Genomic Subtyping of Breast Cancer

*-------------------------------------------------------------
* Step 1: Data Cleaning and Preparation
*-------------------------------------------------------------

* Load data
use "your_datafile.dta", clear

* Inspect variables
describe
summarize

* Explore key variables
summarize age_at_initia_o days_to_date_t os_time_na~2012, detail
tabulate pam50call_rna~q
tabulate gender_nat~2012
tabulate er_status_~2012
tabulate her2_final~2012
tabulate pr_status_~2012
tabulate vital_stat~2012

* Check for missing values
misstable summarize

*-------------------------------------------------------------
* Step 2: Imputation Strategy
*-------------------------------------------------------------

* Set up multiple imputation framework
mi set mlong

* Register variables for imputation
mi register imputed age_at_initia_o days_to_date_t

* Impute missing values using linear regression
mi impute regress age_at_initia_o = days_to_date_t os_time_na~2012, add(10) force
mi impute regress days_to_date_t = age_at_initia_o os_time_na~2012, add(10) force

* Describe MI structure
mi describe

*-------------------------------------------------------------
* Step 3: Variable Selection and Model Planning
*-------------------------------------------------------------

* Prepare variables for modeling
tabulate pam50call_rna~q, generate(pam50_numeric)

* Consider clinical predictors
summarize age_at_initia_o
tabulate er_status_~2012
tabulate pr_status_~2012
tabulate her2_final~2012

* Assess potential shortcut features and data distributions
graph box age_at_initia_o, over(pam50call_rna~q)


*-------------------------------------------------------------
* Step 4: Feature Engineering
*-------------------------------------------------------------

**************************************************
* Feature Engineering and Preparation
**************************************************

* Combine Stage III and IV into a single group (Stage III)
capture replace tumor_stage_grouped = 3 if tumor_stage_grouped == 4

* Label tumor stage group (safe if already defined)
capture label define stagegrp 1 "I" 2 "II" 3 "III"
label values tumor_stage_grouped stagegrp

* Encode categorical variables for modeling (safe and idempotent)
capture drop er_status_num
encode er_status_nature2012, gen(er_status_num)

capture drop pr_status_num
encode pr_status_nature2012, gen(pr_status_num)

capture drop her2_status_num
encode her2_final_status_nature2012, gen(her2_status_num)

capture drop gender_num
encode gender_nature2012, gen(gender_num)


*-------------------------------------------------------------
* Step 5: Feature Simplification & Model Refit
*-------------------------------------------------------------

* 1. Drop gender from model due to imbalance
capture drop gender_num

* 2. Create binary variables from ER/PR/HER2 status
gen er_binary = .
replace er_binary = 1 if er_status_nature2012 == "Positive"
replace er_binary = 0 if er_status_nature2012 == "Negative"
label variable er_binary "ER Status (1=Positive, 0=Negative)"

gen pr_binary = .
replace pr_binary = 1 if pr_status_nature2012 == "Positive"
replace pr_binary = 0 if pr_status_nature2012 == "Negative"
label variable pr_binary "PR Status (1=Positive, 0=Negative)"

gen her2_binary = .
replace her2_binary = 1 if her2_final_status_nature2012 == "Positive"
replace her2_binary = 0 if her2_final_status_nature2012 == "Negative"
label variable her2_binary "HER2 Status (1=Positive, 0=Negative)"

* 3. Run simplified multinomial logistic regression
mlogit pam50_numeric age_at_initia_o er_binary pr_binary her2_binary tumor_stage_grouped if _mi_m == 0

*-------------------------------------------------------------
* Step 6.2: Surrogate Decision Tree
*-------------------------------------------------------------

* Generate a simplified outcome variable for tree modeling
gen subtype_simple = .
replace subtype_simple = 1 if pam50_numeric == 1 // Basal
replace subtype_simple = 2 if pam50_numeric == 2 // Her2
replace subtype_simple = 3 if pam50_numeric == 3 // LumA
replace subtype_simple = 4 if pam50_numeric == 4 // LumB
replace subtype_simple = 5 if pam50_numeric == 5 // Normal
label define subtype_lbl 1 "Basal" 2 "Her2" 3 "LumA" 4 "LumB" 5 "Normal"
label values subtype_simple subtype_lbl

* Run CART tree model
rpart subtype_simple age_at_initia_o er_binary pr_binary her2_binary tumor_stage_grouped if _mi_m == 0, ///
    cp(0.01) maxdepth(4) minsplit(10)

*-------------------------------------------------------------
* Step 6.1: Export Model Results to File
*-------------------------------------------------------------


* Store model output from previous step
estimates store final_model

* Export coefficients
esttab final_model using "model_coefficients.rtf", replace rtf se star(* 0.05 ** 0.01 *** 0.001) label

* Export to CSV for further processing
esttab final_model using "model_coefficients.csv", replace se label

*-------------------------------------------------------------
* Step 6.3: Subgroup and Stratified Performance
*-------------------------------------------------------------

* Create age groups
gen age_group = .
replace age_group = 1 if age_at_initia_o < 40
replace age_group = 2 if inrange(age_at_initia_o, 40, 60)
replace age_group = 3 if age_at_initia_o > 60
label define agegrp 1 "<40" 2 "40-60" 3 ">60"
label values age_group agegrp

* Cross tab for ER by PAM50 subtype
tab pam50_numeric er_binary, row

* Cross tab for PR by PAM50 subtype
tab pam50_numeric pr_binary, row

* Age group by PAM50
tab pam50_numeric age_group, row


