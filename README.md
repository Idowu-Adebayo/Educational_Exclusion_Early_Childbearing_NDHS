**Educational Exclusion and Early Childbearing Among Adolescent Girls in Nigeria**

## Project Overview
This repository contains the data analysis scripts, visual outputs, and documentation for a quantitative study examining the relationship between educational exclusion and early childbearing among adolescent girls aged 15–19 years in Nigeria, utilizing national representative survey data from the **2024 Nigeria Demographic and Health Survey (NDHS)**.


## Abstract
**Educational exclusion and early childbearing** remain pressing concerns for adolescent girls in Nigeria. This study examined their relationship among girls aged 15–19 years using the 2023–2024 Nigeria Demographic and Health Survey (NDHS). It estimated the prevalence of educational exclusion and early childbearing, examined socio-demographic factors associated with early childbearing, assessed their association after adjustment, tested child marriage and early sexual debut as pathways, and examined whether the association varied by residence and wealth.

The study analysed **7,995 girls aged 15–19 years**. Educational exclusion was defined as not currently attending school, and early childbearing as having had a live birth or being currently pregnant. Survey weights, clustering and stratification were accounted for using **Stata 17**, with descriptive statistics, survey-adjusted cross-tabulations, logistic regression, nested pathway models and interaction analyses.

### Key Quantitative Findings
**Prevalence:** Weighted prevalence was **54.34%** for educational exclusion and **13.84%** for early childbearing. 
**Disparity:** Early childbearing occurred among **24.08%** of excluded girls versus **1.66%** of girls in school.
**Regression Results:** Educational exclusion was strongly associated with early childbearing, unadjusted ($OR = 18.77$, $95\% CI: 13.46–26.16$, $p < .001$) and adjusted for wealth, region, religion and residence ($AOR = 12.16$, $95\% CI: 8.73–16.95$, $p < .001$).
**Socio-Economic Factors:** Rural residence raised the odds of early childbearing ($AOR = 2.25$, $95\% CI: 1.72–2.94$, $p < .001$), while the richest category lowered them relative to the poorest ($AOR = 0.39$, $95\% CI: 0.24–0.63$, $p < .001$).
**Pathway Analysis:** Adding child marriage and early sexual debut attenuated the association from $AOR = 10.46$ to $2.88$, with **child marriage driving most of the reduction**.
**Effect Modification:** Neither residence ($p = .556$) nor wealth ($p = .081$) modified the relationship.


## Visual Outputs
Below are key analytical charts generated for this study:

### 1. Prevalence of Educational Exclusion
<img width="2148" height="1058" alt="Prevalence_educational_exclusion" src="https://github.com/user-attachments/assets/b9b78433-25ba-4248-ba43-4c22d6394515" />


### 2. Early Childbearing by Educational Exclusion Status
<img width="2140" height="989" alt="edu_exclu_by_childbearing" src="https://github.com/user-attachments/assets/690c24d1-9a64-40be-8e74-0c0f3d15b07c" />


## 🛠️ Repository Contents
`do-files/`: Contains the Stata script (`.do` file) for survey data setup (`svyset`), descriptive statistics, multivariate logistic regressions, nested pathway models, and interaction analyses.
**Visual Charts:** `Prevalence_educational_exclusion.png` and `edu_exclu_by_childbearing.png` (uploaded directly to the repository).

**Keywords:** Educational exclusion; early childbearing; adolescent girls; child marriage; school attendance; Nigeria; NDHS.
