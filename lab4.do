clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab4.log, replace

/* Quesion 1 */
import excel using "national_M2021_dl.xlsx", clear firstrow
sort OCC_TITLE
replace OCC_TITLE =subinstr(OCC_TITLE,"  "," ",.)
replace OCC_TITLE =subinstr(OCC_TITLE,char(10),"",.)
replace OCC_TITLE =trim(OCC_TITLE)
replace OCC_TITLE =upper(OCC_TITLE)
save CleanedWages, replace

/* Quesion 2 */
import excel using cftb0308.xlsx, clear cellrange(A3) firstrow
destring Totalfatalinjuriesnumber, replace force
keep Occupation1 Totalfatalinjuriesnumber 
drop if missing(Occupation1)
drop if missing(Totalfatalinjuriesnumber)
rename Occupation1 OCC_TITLE

/* Quesion 3 */
replace OCC_TITLE =subinstr(OCC_TITLE,"  "," ",.)
replace OCC_TITLE =subinstr(OCC_TITLE,char(10),"",.)
replace OCC_TITLE =trim(OCC_TITLE)
replace OCC_TITLE =upper(OCC_TITLE)
save Risk, replace

/* Quesion 4 */
collapse (mean) Totalfatalinjuriesnumber, by( OCC_TITLE)
merge 1:m OCC_TITLE using CleanedWages
save datasetLAB4, replace

/* Quesion 5 */
tab_merge
browse
/* My merge of data went well. Before merging, there are two set of data and 
they are separate. After merging, it is possible to see risk and income dataset 
at the same time and tell the relationship. */

/* Quesion 6 */
destring TOT_EMP H_MEAN, replace force

/* Quesion 7*/
reg H_MEAN Totalfatalinjuriesnumber
/* The p-value is larger than 0.05, so there is no relationship between hourly
wage and injuries. */

/* Quesion 8*/
reg H_MEAN Totalfatalinjuriesnumber TOT_EMP
/* The coeffcient of hourly wage on injuries become less negative after 
controlling total employment. The bias equals to first coeffcient minus 
second coeffcient, which is negative. We overestimate the relationship. 
*/
reg H_MEAN TOT_EMP
reg Totalfatalinjuriesnumber TOT_EMP
/* The coeffcient of hourly wage on total employment is negative; the 
coeffcient of injuries on total employment is positive. It follows the 
OVB formulas.
*/
