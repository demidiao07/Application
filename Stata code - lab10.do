clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab10.log, replace


doedit
do preliminaries.do

/* Creating a Log File to Turn In */
log using wenshu_diao_log.txt, text

/* Cleaning the DATA */
tab gq
tab gq, nol
drop if gq==2
replace year=year-1
generate survey=year+1
desc uhrsworkly wkswork1
keep if wkswork1>0  &  uhrsworkly>0
summ uhrsworkly 
drop if uhrsworkly>168
summ uhrsworkly
keep if incwage>0
drop if incwage==9999999
replace incwage=50000*1.5 if survey>=1968 & survey<=1981 & incwage==50000
replace incwage=75000*1.5 if survey>=1982 & survey<=1984 & incwage==75000
replace incwage=99999*1.5 if survey>=1985 & survey<=1987 & incwage==99999
replace incwage=199998*1.5 if survey>=1988 & survey<=1995 & incwage==199998

/* Creating Variables */
generate cpi=.
replace cpi =56.9 if year==1976
replace cpi =60.6 if year==1977
replace cpi =65.2 if year==1978
replace cpi =72.6 if year==1979
replace cpi =82.4 if year==1980
replace cpi =90.9 if year==1981
replace cpi =96.5 if year==1982
replace cpi =99.6 if year==1983
replace cpi =103.9 if year==1984
replace cpi =107.6 if year==1985
replace cpi =109.6 if year==1986
replace cpi =113.6 if year==1987
replace cpi =118.3 if year==1988
replace cpi =124 if year==1989
replace cpi =130.7 if year==1990
generate deflator=82.4/cpi
replace incwage=incwage*deflator
generate wage=incwage/(wkswork1* uhrsworkly)
drop if wage<1.5 | wage>40
generate miami=(metarea==5000)

/* Let’s Create a Dummy for George’s Sample */
g borjas_sample =1
tab sex
tab sex, nol
replace borjas_sample =0 if sex==2
tab hispan
tab hispan,nol
replace borjas_sample =0 if hispan>0
drop if age <25 | age >59
drop if educ >= 72
save working_data, replace

/* Borjas Results */
use working_data,clear
keep if borjas_sample==1 
collapse (mean) wage, by(miami year)
sort year
line wage year if miami==0 || line wage year if miami==1
/* Two lines have different shapes, so there is a change in wages, the results match Borjas’ findings. */

/* Critique of Borjas */
use working_data, clear
keep if borjas_sample==1 
generate white= (race==100)
collapse (mean) white, by(miami year)
sort year
line white year if miami==0 || line white year if miami==1
/* The results match the critique. We can tell there is a difference in two wages between white and non-white people. */

/* Your Own Sample */
g borjas_sample =2
tab sex
tab sex, nol
replace borjas_sample =0 if sex==2
tab hispan
tab hispan,nol
replace borjas_sample =0 if hispan>0
drop if educ >= 72
save working_data, replace
keep if borjas_sample==2
collapse (mean) wage, by(miami year)
sort year
line wage year if miami==0 || line wage year if miami==1

/* Difference in Differences */
ssc install outreg2 
generate after=(year>=1980)
generate miami_after = miami * after
regress wage miami after miami_after

use working_data, replace
keep if borjas_sample==1 
generate after=(year>=1980)
generate miami_after = miami * after
regress wage miami after miami_after

log close
