clear 
set more off
cd "H:\econ 326\"
capture log close
log using ps2.log, replace

/* Topic 4 */
use "H:\econ 326\burkinafaso.dta", clear

/* 1. Linear Probability Model */
/* a */
reg hivpositive wealth_index catholic secondary_educ age_at_first_sex rural, robust
summarize wealth_index catholic secondary_educ age_at_first_sex rural

/* 
b. Being catholic is 5.33 percentage points less likely to test positive on HIV on
average than being non-catholic, holding other variables constant.

c. Living in rural areas is 3.90 percentage points less likely to test positive on 
HIV on average than living in other areas, holding other variables constant.

d. Null hypothesis: living in a rural area has no effect on HIV status
p-value is greater than 0.05, it is not statistically significant, which means we fail 
to reject the null hypothesis. It is possible that living in rural areas has relationship 
with HIV status.

e. hivpositive = 0.1177 + 0.0114 * wealth_index - 0.0533 * catholic + 0.0782 * secondary_educ
- 0.0026 * age_at_first_sex - 0.0390 * rural
= 0.1177 + 0.0114 * 2 - 0.0533 * 1 + 0.0782 * 0.0715 - 0.0026 * 15 - 0.0390 * 0.7196
= 0.0257269 = 2.57%
*/ 

/* 2. Probit Model */
/* a */
probit hivpositive wealth_index catholic secondary_educ age_at_first_sex rural

/* 
b. Being catholic has a negative relationship with the probility of testing positive
on HIV, holding other variables constant. 

c. Living in rural areas has a negative relationship with the probility of testing positive
on HIV, holding other variables constant.
(For b and c, we only know the sign of coefficient and whether it is statistically
significant. If we want to know the magnitude of the coefficient, we can generate a marginal 
effect of the independent variable on the dependent variable.)

d. Null hypothesis: living in a rural area has no effect on HIV status
p-value is greater than 0.05, it is not statistically significant, which means we fail 
to reject the null hypothesis. It is possible that living in rural areas has relationship 
with HIV status.
*/ 

/* e */
di normprob(_b[_cons]+2*_b[wealth_index]+1*_b[catholic]+.0715308*_b[secondary_educ]+15*_b[age_at_first_sex]+.7195994*_b[rural])
/* hivpositive = .02101161 = 2.10% */

/* f. No. because it is a binary variable, the probit model gives us more precise result. */
 
/* g */
mfx, at(catholic = 1, wealth_index = 2.901288, secondary_educ =.0715308, age_at_first_sex= 17.45207 , rural=1)

/* h. For Catholics living in an urban area, with all other predictor variables set to their mean values, one unit increase in wealth_index is associated with a 0.51 percentage point increase in the probability of testing positive in HIV. The rest of coefficients can be interpreted in the same way. 

The marginal effect is different from the ones in 1b/2b.

In 1b, it is a linear probability model, so the coefficient which is also marginal effect works for catholic variable all the time. 

In 2b, the coefficient only tells us the sign of relationship between two variables, it does not give us other information.

In 2h, we test the marginal effect when all the variables are assigned with specific values. It is the marginal effect under that condition. Since it is probit model, the slope changes when the values of variables change. 
*/

log close
