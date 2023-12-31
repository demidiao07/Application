clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab7.log, replace

/* The main findings from this paper is that single women tend to be humble, prevent that they are not ambitious than married women and men, in order to get a positive feedback in the marriage market. */

use acting_wife_data_set, replace

local variables "salary travelmonth hours_desired tendtolead moreambitious competitive goodwriter"

foreach variable in `variables' {
reg `variable' public if male == 0 & maritalstatus ==0 , robust
}

/* These results match up to the values in the paper. */

gen single = maritalstatus == 0

gen single_public = maritalstatus == 0 & public == 1

local variables "salary travelmonth hours_desired tendtolead moreambitious competitive goodwriter"
foreach variable in `variables' {
reg `variable' public single single_public if male == 0 , robust
}

/* The results do not match values in the paper. */

gen single_women_public =  maritalstatus == 0 & male == 0 & public == 1

local variables "salary travelmonth hours_desired tendtolead moreambitious competitive goodwriter"
foreach variable in `variables' {
reg `variable' public single_women single_women_public, robust
}

/* "research degrees of freedom describe researchers' ability to look at many different aspects of their data in a search for statistical significance." Gelman states that researchers have enough degrees of freedom. If there is no main effect and no interaction, researchers can look for other interactions. */

gen single2 = maritalstatus == 0 & maritalstatus == 1

gen single2_public = single2 & public == 1

local variables "salary travelmonth hours_desired tendtolead moreambitious competitive goodwriter"
foreach variable in `variables' {
reg `variable' public single2 single2_public if male == 0 , robust
}

/* The result is different from the previous ones. */

/* What Andrew Gelman tells us is that if some variables do not work (statistically significant), it is possible for researchers to use other types of variables. In this case, if the correlation between single(maritalstatus=0) and public is not statistically significant, we can try an alternative coding like single(maritalstatus=0 & 1). The result will be different. */

log close
