/////////////////////////////////////////////////////////////////
///////////    TOPIC: Relationship Between Educational Exclusion
///////////    and Early Childbearing
///// Population: Adolescent girls aged 15–19 in Nigeria
//////////////////// Data: NDHS 2024
////////// AUTHOR: IDOWU OLUWASEGUN ADEBAYO /////////////////////
/////////////////////////////////////////////////////////////////
clear all
set more off
capture log close
cd "C:\Users\DELL\Desktop\My_Part_4_Analysis"
log using @me.log, replace
/////////////////Preparing the PR file ///////////////////////////
use "C:\Users\DELL\Desktop\My_Part_4_Analysis\NDHS 2024\NGPR8BDT\NGPR8BFL.dta", clear
count
////////////Checking the Unique Identifier ////////////
isid hv001 hv002 hvidx
describe hv001 hv002 hvidx
///// The school attendance variable
describe hv121
codebook hv121
tab hv121, missing
////// Keeping the variables needed to merge with the IR file ///////////////
keep hv001 hv002 hvidx hv121
//////// Renaming the PR identifiers to the one in the IR file //////////////
rename hv001 v001
rename hv002 v002
rename hvidx v003
///////////// Checking the identifiers again  ///////////////////
isid v001 v002 v003
////////// Save the school attendance extract ///////////////////
save "school_attendance_extract.dta", replace
/////////////// The Individual Recode file /////////////////////////////
use "C:\Users\DELL\Desktop\My_Part_4_Analysis\NDHS 2024\NGIR8BDT\NGIR8BFL.dta", clear
count
// Checking the identifiers are unique
isid v001 v002 v003
////// Checking other needed variables for my analysis /////////////////////
codebook v012
codebook v025
codebook v024
codebook v130
codebook v190
codebook v201
codebook v213
codebook v005
codebook v021
codebook v022
codebook v511
codebook v525
///////////The Merging Process ////////////////////////
merge 1:1 v001 v002 v003 using "school_attendance_extract.dta"
tab _merge
keep if _merge == 3
drop _merge
count
// Confirming that the individual identifiers are still unique
isid v001 v002 v003
// Restricting to only adolescent girls aged 15–19 years
keep if v012 >= 15 & v012 <= 19
count
tab v012, missing
///////////// Creating the variable for school attendance ////////////
gen current_school_attendance = .
replace current_school_attendance = 0 if hv121 == 0
replace current_school_attendance = 1 if hv121 == 2
label define attend 0 "Not currently attending" 1 "Currently attending", replace
label values current_school_attendance attend
label variable current_school_attendance "Current school attendance during current school year"
tab current_school_attendance, missing
////////////// Creating the variable for educational exclusion //////////////////////
gen educational_exclusion = .
replace educational_exclusion = 0 if current_school_attendance == 1
replace educational_exclusion = 1 if current_school_attendance == 0
label define exclusion 0 "Not educationally excluded" 1 "Educationally excluded", replace
label values educational_exclusion exclusion
label variable educational_exclusion "Educational exclusion based on current school attendance"
tab educational_exclusion, missing
////////////// Creating the variable for ever given birth //////////////
gen ever_birth = .
replace ever_birth = 1 if v201 > 0 & v201 < .
replace ever_birth = 0 if v201 == 0
label define birth 0 "No birth" 1 "Ever given birth", replace
label values ever_birth birth
label variable ever_birth "Ever given birth to a live child"
tab ever_birth, missing
///////////// Creating variable for currently pregnant ////////////////
gen currently_pregnant = .
replace currently_pregnant = 1 if v213 == 1
replace currently_pregnant = 0 if v213 == 0
label define preg 0 "Not currently pregnant" 1 "Currently pregnant", replace
label values currently_pregnant preg
label variable currently_pregnant "Currently pregnant at time of survey"
tab currently_pregnant, missing
/////////////// Creating the variable for early child bearing ///////////
gen early_childbearing = .
replace early_childbearing = 1 if ever_birth == 1 | currently_pregnant == 1
replace early_childbearing = 0 if ever_birth == 0 & currently_pregnant == 0
label define earlycb 0 "No early childbearing" 1 "Early childbearing", replace
label values early_childbearing earlycb
label variable early_childbearing "Early childbearing among adolescents aged 15–19"
tab early_childbearing, missing
tab ever_birth currently_pregnant, row
////////////// Declaring The Survey ///////////////////////
gen wt = v005 / 1000000
svyset v021 [pweight=wt], strata(v022) singleunit(centered)
/////// Check for missing values for the variables in concern //////////////////
tab educational_exclusion, missing
tab early_childbearing, missing
tab ever_birth, missing
tab currently_pregnant, missing
tab v012, missing
tab v190, missing
tab v024, missing
tab v130, missing
tab v025, missing
tab v511, missing
tab v525, missing
//////////////// Socio-Demographic Variables - Univariate Analysis /////////////
svy: tab v012, count percent format(%9.2f)
svy: tab v190, count percent format(%9.2f)
svy: tab v024, count percent format(%9.2f)
svy: tab v130, count percent format(%9.2f)
svy: tab v025, count percent format(%9.2f)
svy: proportion v012
svy: proportion v190
svy: proportion v024
svy: proportion v130
svy: proportion v025
///////////// Descriptive Analysis for my main variables /////////
svy: tab educational_exclusion, count percent format(%9.2f)
svy: tab ever_birth, count percent format(%9.2f)
svy: tab currently_pregnant, count percent format(%9.2f)
svy: tab early_childbearing, count percent format(%9.2f)
 /////////// OBJ1/RQ1: Prevalence of Educational Exclusion /////////////////////
svy: proportion educational_exclusion
/////////// OBJ2/RQ2 : Prevalence of Early Childbearing ////////////////////////
svy: proportion early_childbearing
svy: proportion early_childbearing, over(educational_exclusion)
///////////// The association between educational exclusion and early childbearing //////////////////
svy: tabulate educational_exclusion early_childbearing, row percent pearson
////////////// OBJ3/RQ3: Household Wealth and Early Childbearing /////////////////////
//////////////// Early childbearing prevalence within each wealth quintile //////////////
svy: tab v190 early_childbearing, row percent ci
svy: logistic early_childbearing i.v190, or
////////////// OBJ3/RQ3: GEOPOLITICAL Region and Early Childbearing /////////////////////
////////// Early childbearing prevalence by geopolitical region //////////////////
svy: tab v024 early_childbearing, row percent ci
svy: logistic early_childbearing i.v024, or
////////////// OBJ3/RQ3: Religion and Early Childbearing /////////////////////
/////////////// Early childbearing prevalence by religion /////////////////////
svy: tab v130 early_childbearing, row percent ci
svy: logistic early_childbearing i.v130, or
////////////// OBJ3/RQ3: Place of Residence and Early Childbearing /////////////////////
///////////////// Early childbearing prevalence by place of residence //////////////////
svy: tab v025 early_childbearing, row percent ci
svy: logistic early_childbearing i.v025, or
////////////// OBJ4/RQ4: Unadjusted Association Between Educational Exclusion and Early Childbearing /////////////////////
svy: logistic early_childbearing i.educational_exclusion, or
//////////////////////// OBJ4 / RQ4: Primary Adjusted Model ////////////////////
svy: logistic early_childbearing i.educational_exclusion i.v190 i.v024 i.v130 i.v025, or
/////////////// OBJ5/RQ5: Interaction Between Educational Exclusion and Residence /////////////////////////
svy: logistic early_childbearing i.educational_exclusion##i.v025 i.v190 i.v024 i.v130, or
testparm i.educational_exclusion#i.v025
////////////To Check the Predicted Probabilities //////////////
margins educational_exclusion#v025
/////////////// OBJ5/RQ5: Interaction Between Educational Exclusion and Household Wealth /////////////////////////
svy: logistic early_childbearing i.educational_exclusion##i.v190 i.v025 i.v024 i.v130, or
testparm i.educational_exclusion#i.v190
margins educational_exclusion#v190
///////// Creating the variable for child marriage /////////////
////// v511 is age at first union /////////////
gen child_marriage = .
replace child_marriage = 1 if v511 < 18 & v511 <.
replace child_marriage = 0 if v511 >= 18 & v511 <.
replace child_marriage = 0 if v501 == 0
label define childmar_lbl 0 "No child marriage" 1 "Child marriage (<18)", replace
label values child_marriage childmar_lbl
label variable child_marriage "Entered first cohabiting union before age 18"
tab child_marriage, missing
tab v511 child_marriage, missing
/////////// Prevalence of Child Marriage ///////////////////////
svy: proportion child_marriage
////////// Child marriage By Education ///////////////
svy: tab educational_exclusion child_marriage, row percent ci pearson
///////////// To tests whether educational exclusion is associated with child marriage. //////////////
svy: logistic child_marriage i.educational_exclusion, or
////////////  socio-demographic confounders for the multivariable analysis for child marriage ///////////////
svy: logistic child_marriage i.educational_exclusion c.v012 i.v130 i.v024, or
//////////////// Baselin Model For Comparison with the mediator model ////////////
svy: logistic early_childbearing i.educational_exclusion c.v012 i.v130 i.v024, or
//////////// This is to check whether child marriage is associated with early childbearing after controlling for educational exclusion and the specified confounders. Whether the educational exclusion coefficient changes after introducing child marriage.
svy: logistic early_childbearing i.educational_exclusion i.child_marriage c.v012 i.v130 i.v024, or
/////////// Store child marriage mediation model //////////////
eststo clear
////////// The baseline model without mediator ///////////////
svy: logistic early_childbearing i.educational_exclusion c.v012 i.v130 i.v024, or
eststo childmar_base
///////////// Outcome model with child marriage
svy: logistic early_childbearing i.educational_exclusion i.child_marriage c.v012 i.v130 i.v024, or
eststo childmar_mediator
estimates table childmar_base childmar_mediator, b(%9.3f) se(%9.3f) p(%9.4f) stats(N)
///////// Creating the variable for Early Sexual Debut /////////////////
///////////// v525 = age at first sexual intercourse. //////////////////
gen early_sexual_debut = .
replace early_sexual_debut = 1 if v525 >= 1 & v525 < 15
replace early_sexual_debut = 0 if v525 == 0
replace early_sexual_debut = 0 if v525 >= 15 & v525 < .
label define earlysex_lbl 0 "No early sexual debut" 1 "Early sexual debut (<15)", replace
label values early_sexual_debut earlysex_lbl
label variable early_sexual_debut "First sexual intercourse before age 15"
tab early_sexual_debut, missing
tab v525 early_sexual_debut, missing
////////////// Prevalence of Early Sexual Debut /////////////
svy: proportion early_sexual_debut
//////////// Examine the relationship between educational exclusion and early sexual debut /////////////////
svy: tab educational_exclusion early_sexual_debut, row percent ci pearson
svy: logistic early_sexual_debut i.educational_exclusion, or
//////////// Together with the sociodemographic confounders ////////////////////////
svy: logistic early_sexual_debut i.educational_exclusion c.v012 i.v130 i.v024, or
/////////// Baseline model before adding early sexual debut as the mediator. /////////////////
svy: logistic early_childbearing i.educational_exclusion c.v012 i.v130 i.v024, or
/////////////// To check whether early sexual debut is associated with early childbearing after controlling for educational exclusion and confounders. Whether the educational-exclusion association changes after inclusion of the mediator. /////////////////////
svy: logistic early_childbearing i.educational_exclusion i.early_sexual_debut c.v012 i.v130 i.v024, or
eststo clear
////// For the baseline outcome model
svy: logistic early_childbearing i.educational_exclusion c.v012 i.v130 i.v024, or
eststo sex_base
/////////////// Outcome model with early sexual debut
svy: logistic early_childbearing i.educational_exclusion i.early_sexual_debut c.v012 i.v130 i.v024, or
eststo sex_mediator
estimates table sex_base sex_mediator, b(%9.3f) se(%9.3f) p(%9.4f) stats(N)
//////////// The two mediators are included here. //////////////////
svy: logistic early_childbearing i.educational_exclusion i.child_marriage i.early_sexual_debut c.v012 i.v130 i.v024, or
eststo clear
////////// Model 1: Exposure + confounders only
svy: logistic early_childbearing i.educational_exclusion c.v012 i.v130 i.v024, or
eststo med_model1
//////////// Model 2: Exposure + child marriage + confounders
svy: logistic early_childbearing i.educational_exclusion i.child_marriage c.v012 i.v130 i.v024, or
eststo med_model2
////////////// Model 3: Exposure + early sexual debut + confounders
svy: logistic early_childbearing i.educational_exclusion i.early_sexual_debut c.v012 i.v130 i.v024, or
eststo med_model3
/////////// Model 4: Exposure + the two mediators + confounders
svy: logistic early_childbearing i.educational_exclusion i.child_marriage i.early_sexual_debut c.v012 i.v130 i.v024, or
eststo med_model4
//////////// Comparison across all four models. //////////////////
estimates table med_model1 med_model2 med_model3 med_model4, b(%9.3f) se(%9.3f) p(%9.4f) stats(N)
// Rerunning the combined mediator model
svy: logistic early_childbearing i.educational_exclusion i.child_marriage i.early_sexual_debut c.v012 i.v130 i.v024, or
testparm i.child_marriage
testparm i.early_sexual_debut
svy: logistic early_childbearing i.educational_exclusion i.v190 i.v024 i.v130 i.v025, or
save "NDHS2024_early_childbearing_analysis.dta", replace
log close
///////////////////////// END OF DO-FILE /////////////////////////
