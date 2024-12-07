clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab8.log, replace

* ==============================================================================
* Experiment on Smoking Cessation
* See https://www.hindawi.com/journals/josc/2021/6612505/ for an experiment summary
* Participants were offered financial incentives in all treatment arms
* Arm 1 was given $ alone
* Arm 2 was given a deposit contract with a commitment device at the end
* Arm 3 was given a pre-commitment device
* ==============================================================================

use I2Q_Tables_Data.dta, clear

// generate treatment arm dummies

gen control = treatment == 0
gen treat1 = treatment == 1
gen treat2 = treatment == 2
gen treat3 = treatment == 3

** Next we want to try to answer the following question...
** Did they have clean urine at 6 months? 

/*
To test the joint hypothesis that the effect of each treatment was zero we will 
first run a linear probability model and then use an F-test.
*/

reg urine_6m_pass treat1 treat2 treat3
test treat1 treat2 treat3

/* 
Now suppose we add several controls: smoking quit attempts last year, etc. 
(b_smk_quit_times b_cig20perday quit_more_year b_fager_test_low b_fager_test_lowmod 
b_fager_test_mod a_age married female race_black_afam race_white race_other hispanic)

Try adding these to the LPM and then testing the joint effect of the three treatments
*/

reg urine_6m_pass treat1 treat2 treat3 b_smk_quit_times b_cig20perday quit_more_year b_fager_test_low b_fager_test_lowmod b_fager_test_mod a_age married female race_black_afam race_white race_other hispanic
test treat1 treat2 treat3

// How could the F-test change even if the treatment was randomly assigned? 

/* F-test becomes larger. The higher F-test, the better the model, which means that we are more likely to reject the null hypothesis. */

// What happened to the R2 when you added controls?

/* After adding controls, R2 becomes higher, more variability in urine_6m_pass is explained by the model. */

// Can you adjust the regression to find a higher Adjusted R-2?
reg urine_6m_pass treat1 treat2 treat3 b_smk_quit_times b_cig20perday quit_more_year b_fager_test_low b_fager_test_lowmod  a_age married female race_black_afam race_white race_other hispanic

/* The adjusted R2 is 0.0354, which is higher than before. */

log close
