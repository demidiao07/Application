clear 
set more off
cd "H:\econ 326\"
capture log close
log using ps1.log, replace

/* Topic 4 */
use "H:\econ 326\gender.dta", clear

/* 1 */
sum wage
ttest wage == 12

/* 
a. The null hypothesis is that the average hourly wage in the population is 
equal to $12/hour.

b. The t-statistic is 1.4239.

c. The p-alue is 0.1548. Since p-value is larger than 0.05, it is not 
statistically significant. We cannot reject the null hypothesis.

d. The 95% confidence interval for the hourly wage is between 11.84438 to 12.97852.
*/

/* 2 */
ttest wage, by(gender) unequal

/* 
a. The null hypothesis is that the difference in the average hourly wage between 
men and women is zero.

b. The t-statistic is 5.8418.

c. The p-alue is 0. Since p-value is less than 0.05, it is 
statistically significant. We can reject the null hypothesis: there is 
difference in the average hourly wage between men and women.
*/

/* 3 */
/* 
The last question does not provide evidence that there is gender discrimination 
in wages because we do not control other factors. It is possible for these
potential factors to affect the result. 
*/

/* Topic 5 */
scatter wage educ

/*
2.There is a positive relationship between wage and education. 
*/

regress wage educ
/* 3 */
/* 
a. Yi = b0 + b1 * x1 
Wage = -4.92 + 1.32 * educ

b. The value of sample b1 is 1.32, which means that a unit change in education
is associated with a 1.32 change in predicted wage. It matches because it proves 
the positive relationship between education and wage.

c. The value of sample b1 is statistically significant since the p-value is 0, 
which is less than 0.05.

d. The p-value is less than 0.05, so we can reject the null hypothesis. Hence,
education is related to wage. The policy may work.

e. The value of b0 is -4.92. It is a prediction of wage with a 0 education. It is
not practically meaningful because income cannot be negative.

f. Wage = -4.915226 + 1.323285 * 12 = 10.96
*/

/* 4 */
predict yhat
sum yhat
sum yhat if educ==12

/* 
a. We have seen the value in question 1 in topic 4, which is the actual average 
hourly wage. The line of best fit chooses values of the slope and intercept that 
minimize the sum of the squared residuals. That's why they are almost the same.
b. The mean is equal to the previous value in f in the third question. Both are 
the predicted values for wage when education is 12, so they are the same.
*/

/* 5 */
predict uhat, resid
sum uhat
regress uhat educ

/* 
a. The largest residual is 64.15. The large positive residual means that the 
actual wage is more than the predicted wage. The person does much better than we 
expect.
b. There is no relationship between residuals and dependent variables. It makes 
sense because we have to choose b1 so that x is unncorrelated with the residuals.
*/

/* Topic 6 */
use "nlsy.dta", clear
summarize 
/* 
1. The mean of the male is 0.538, which means that there are more males than females 
in the sample. White people are the most in the sample, and then are the black people.
The average age is 20 for people ranging from 16 to 23 years old. About 73% of them
are single, the rest has married already. The mean education time is 11.96 years. 
80% of them come from urban areas. The mean monly income is 889.57 dollars.
*/

rreg income educ married
/*
2. For the correlation between income and education, the coefficient is 26.20. A unit 
change in education is associated with a 26.20 average change in income, holding
married constant. Since p-value is 0, it is statistically significant.
For the correlation between income and married, the coefficient is 41.73. Married 
people earn 41.73 higher on average than unmarried people, holding education constant.
Since p-value is 0.026, which is less than 0.05, so it is statistically significant.
The intercept is 494.32. It means that the income is 494.32 for unmarried people who 
never takes education. It is not meaningful.
*/

/* 
3. 
Monthly income = 494.32 + 26.20 * educ + 41.73 * married
# 1: 494.32 + 26.20 * 10 + 41.73 * 0 = 756.32
# 1: 494.32 + 26.20 * 16 + 41.73 * 1 = 955.25
*/

rreg income white black hispanic
/* 
4. It is the situation of collinear, it happens when a set of variable adds to a 
fixed number. White, black, and hispanic together are the whole sample, they are 
dependent on each other. Since there is no independent variable, Stata will drop 
one variable automatically for us.
*/

rreg income black hispanic 
/*
5. income = 822.75 - 55.23 * black - 42.65 * hispanic
The first coefficient means that the average income for black people is 55.23 lower
than white people. P-value is 0.062, which is larger than 0.05, so it is not
statistically significant.
The second coefficient means that the average income for hispanic people is 42.65
lower than white people. P-value is 0.233, which is larger than 0.05, so it is not
statistically significant.
*/

rreg income white black
/* 
6. The p-value for black and hispanic correlation is 0.778, which is larger than 
0.05, so it is not statistically significant.
*/

/* 7 */
search esttab
estpost sum income educ married
esttab using "nlsy.dta", cells("mean(fmt(2)) sd(fmt(2)) min(fmt(1)) max(fmt(0))") ///
	nomtitle nonumber replace

eststo: reg income edu, robust
eststo: reg income edu married, robust
eststo: reg income edu married black hispanic, robust
eststo: reg income edu married black hispanic age, robust
esttab using "ps1Table.csv", ar2 label replace

/*
8. Omitting married decrease the magnitude of the estimate, so we underestimate 
the true impact of education to income, but the difference is not large. Omitting race/ethnicity does not generate much omitted variable bias. Omitting age
increases the magnitude of the estimate, so we overestimate the true impact of 
education to income. The difference is pretty large.

9. First of all, the sample is not much, so it cannot represent the true populion. We cannot totally rely on statistics to make a policy. Secondly, marriage is an important. 
It is possible that there is not much effect after we promote marriage. Thirdly, 
there may exist other potential factors influencing the income, so we have to do 
more research. My conclusion is that we should not promote marriage merely based one
one study.
*/

