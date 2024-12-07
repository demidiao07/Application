clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab11.log, replace


/* Synthetic Controls Part 1 */
ssc install synth
sysuse synth_smoking
tsset state year
synth cigsale beer(1984(1)1988) lnincome retprice age15to24 cigsale(1988) cigsale(1980) cigsale(1975), trunit(3) trperiod(1989) fig
synth cigsale beer(1984(1)1988) lnincome retprice age15to24 cigsale(1987) cigsale(1982) cigsale(1975), trunit(3) trperiod(1989) fig

/* Synthetic Controls Part 2 */
use collegedata_forassignment.dta, clear
set matsize 600
synth c150_4 c150_4(2002(1)2004)  satmt75(2005), trunit(201645) trperiod(2007) fig unitnames(inst)

/* 
1. Because it is more accurate, we can get better synthetic controls.
2. During her office time, from 2007 to 2020, the graduation rate increased. 
3. Princeton University, Brown university, Rhode Island School
*/
set matsize 600
synth c150_4 c150_4(2001(1)2005)  satmt75(2004), trunit(201645) trperiod(2007) fig unitnames(inst)

log close
