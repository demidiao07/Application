clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab9.log, replace

/* The supplies of labor in a city may respond to relative wages, so the omitted variable bia is supplies of labor. The instrumental variable is earlier immigrant settlement patterns. It is valid for me since it has relevance and exogeneity at the same time. */


use peri_iv_data.dta, clear
ssc install reghdfe
ssc install ivreghdfe  
ssc install ivreg2
ssc install ranktest
ssc install ftools

reg gsp_worker us_pop foreign_pop, vce(cluster statefip)

/* One unit increase in foreign_pop is associated with 1.09% increase in gsp_worker.
It is causual since we have already cluster the standard error, which can guarantee the internal validity.
We can consider variables in one state as a draw, since the situation in one state for everyone there.
*/

reghdfe gsp_worker us_pop foreign_pop, a(year statefip) vce(cluster statefip)

/* The coefficient on foreign_pop deceases. There is a positive relationship between year and gsp_worker, after controlling, the positive bias be eliminated, the coefficient will decrease. */

ivreghdfe gsp_worker us_pop (foreign_pop= foreign_imputed), a(year statefip) first cluster( statefip)

/* One unit incease in foreign_imputed is associated with 0.69 increase in foreign_pop.
The coefficient of IV is 0.0072563, and the OLS one is 0.0067732. OLS estimates rely on all of the natural variation that exists across the entire sample, IV estimates are derived only from the variation attributable to the (exogenous) instrument.
Since the IV estimate is unaffected by the measurement error in the treatment variable, IV is higher than OLS. Most immigrants have lower education level than residants, so controlling foreign_pop leads to a higher coefficient. */

log close
