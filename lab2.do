clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab2.log, replace
import excel "H:\econ 326\mumuadu_data.xls", sheet("Sheet1") clear firstrow

/* some codes in the power point */

tabulate age
tabulate cogscore
tab village, sort
tab village ambiguity, row
summarize age
summarize age, detail
correlate cogscore age
correlate cogscore age, covariance
table village, content(median age mean quantmaizec sd cogscore)
tabstat age quantmaizec cogscore, by(village) stat(mean)
histogram quantmaizec, width(100)
histogram quantmaizec, bin(20)
kdensity quantmaizec
scatter revenuetot quantmaizec
graph save revenueOutput
graph export revenueOutput.png, replace
tab maize_b1
tab maize_b1, nolabel
label list
gen ones = 1 //creates a column of ones
gen labor_per_hectare = labortot / landsize
gen age30 = age==30    /* Will be 1 for age 30, 0 for all other obs. */
gen ageOver40 = age>40  /* Will be 1 for all ages over 40, 0 otherwise */
gen female_Bunso = female==1 & village=="Bunso"
gen female_or_elderly = female==1 | age>=60
gen age_grp = 1
replace age_grp = 2 if age>25
replace age_grp = 3 if age>50
replace age_grp = 4 if age>75
egen mean_quantmaize = mean(quantmaizec)
egen sd_quantmaize = sd(quantmaizec)
egen mean_quantmaize = mean(quantmaizec) if quantmaizec>0
bysort ageOver40: egen mean_byAge40_quantmaize = mean(quantmaizec)
bysort village: egen mean_by_village_quantmaize = mean(quantmaizec)
sort village
sort age
gsort -age landsize
gsort -landsize
gsort -landsize, mfirst
sort village age
gsort village -landsize
label variable wealthy "Total revenue (revenuetot) over 1000"
label variable elderly "Age (age) over 60"
drop if landsize==.
regress principal0 treatment 

/* When farmers are offered the experimental loans, they will borrow 5.53
dollars on average

It is not statistically signifiant because the p-value is 0.786, which is 
larger than 0.05. */
regress principal0 treatment maize age

/* For the variables of maize and age, p-value of maize is 0.109, and the 
p-value of age is 0.314. Both of them are greater than 0.05, so they are not
statistically significant. */

/* As we can see in the table, the p-value of treatment is still larger than
0.05, which is not statistically signifiant. We already done the random 
sampling experiment, that's why they have small impact on the treatment.*/