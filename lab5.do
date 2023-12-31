clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab5.log, replace

/* Question 1:  “Do Men Lie About How Tall They Are?” */
import delimited "profiles.csv", varnames(1)
destring height, replace force
summarize height
ttest height == 68.29523 
/* P-value here is larger than 0.05, so it is not statistically significant. The mean height reported on OK Cupid is not statistically significantly different from this average. */

generate male = sex == "m"
regress height male 
/* P-value equals to 0, which is less than 0.05, so it is statistically significant. Therefore, there is a difference between male and female height. */

gen jewish = strpos(religion, "judaism")
gen kosher = strpos(diet, "kosher")
reg height kosher
reg height kosher jewish 
/* The first coefficient is 0.0243, which means that people who keep kosher are 0.0243 on average higher than people who do not keep kosher. The second coefficient is 0.0735, which means that people who keep kosher are 0.0735 on average higher than people who do not keep kosher, controlling the jewish factor. */

/* Question 2:  “Who Smokes?” */
drop if income<0
gen non_smoke = strpos(smoke, "no")
gen eversmoke = non_smoke == 0
reg income eversmoke
/* The coefficient is 15254.9, which means that people who smoke has 15254.9 higher income than people who have not smoked before on average. */

predict yhat
probit eversmoke income
/* The relationship between income and eversmoke is positive, we cannot tell the magnitude. */

predict yhat_probit
scatter yhat yhat_probit income
/* The scatter table shows that income does not affect the probability for people to smoke */

/* Question 3 */
gen single = strpos(status, "single")
reg income single
/* The coefficient is -484.35, which means that people who are single has 484.35 lower income than people who are not single on average. */