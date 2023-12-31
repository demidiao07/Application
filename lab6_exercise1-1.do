clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab6_exercise1.log, replace


* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix               ///
  int     year       1-4    ///
  long    serial     5-9    ///
  byte    month      10-11  ///
  double  cpsid      12-25  ///
  byte    asecflag   26-26  ///
  double  asecwth    27-37  ///
  byte    foodstmp   38-38  ///
  byte    pernum     39-40  ///
  double  cpsidp     41-54  ///
  double  asecwt     55-65  ///
  byte    age        66-67  ///
  byte    empstat    68-69  ///
  int     ahrsworkt  70-72  ///
  byte    health     73-73  ///
  using `"cps_00001.dat"'

replace asecwth   = asecwth   / 10000
replace asecwt    = asecwt    / 10000

format cpsid     %14.0f
format asecwth   %11.4f
format cpsidp    %14.0f
format asecwt    %11.4f

label var year      `"Survey year"'
label var serial    `"Household serial number"'
label var month     `"Month"'
label var cpsid     `"CPSID, household record"'
label var asecflag  `"Flag for ASEC"'
label var asecwth   `"Annual Social and Economic Supplement Household weight"'
label var foodstmp  `"Food stamp recipiency"'
label var pernum    `"Person number in sample unit"'
label var cpsidp    `"CPSID, person record"'
label var asecwt    `"Annual Social and Economic Supplement Weight"'
label var age       `"Age"'
label var empstat   `"Employment status"'
label var ahrsworkt `"Hours worked last week"'
label var health    `"Health status"'

label define month_lbl 01 `"January"'
label define month_lbl 02 `"February"', add
label define month_lbl 03 `"March"', add
label define month_lbl 04 `"April"', add
label define month_lbl 05 `"May"', add
label define month_lbl 06 `"June"', add
label define month_lbl 07 `"July"', add
label define month_lbl 08 `"August"', add
label define month_lbl 09 `"September"', add
label define month_lbl 10 `"October"', add
label define month_lbl 11 `"November"', add
label define month_lbl 12 `"December"', add
label values month month_lbl

label define asecflag_lbl 1 `"ASEC"'
label define asecflag_lbl 2 `"March Basic"', add
label values asecflag asecflag_lbl

label define foodstmp_lbl 0 `"NIU"'
label define foodstmp_lbl 1 `"No"', add
label define foodstmp_lbl 2 `"Yes"', add
label values foodstmp foodstmp_lbl

label define age_lbl 00 `"Under 1 year"'
label define age_lbl 01 `"1"', add
label define age_lbl 02 `"2"', add
label define age_lbl 03 `"3"', add
label define age_lbl 04 `"4"', add
label define age_lbl 05 `"5"', add
label define age_lbl 06 `"6"', add
label define age_lbl 07 `"7"', add
label define age_lbl 08 `"8"', add
label define age_lbl 09 `"9"', add
label define age_lbl 10 `"10"', add
label define age_lbl 11 `"11"', add
label define age_lbl 12 `"12"', add
label define age_lbl 13 `"13"', add
label define age_lbl 14 `"14"', add
label define age_lbl 15 `"15"', add
label define age_lbl 16 `"16"', add
label define age_lbl 17 `"17"', add
label define age_lbl 18 `"18"', add
label define age_lbl 19 `"19"', add
label define age_lbl 20 `"20"', add
label define age_lbl 21 `"21"', add
label define age_lbl 22 `"22"', add
label define age_lbl 23 `"23"', add
label define age_lbl 24 `"24"', add
label define age_lbl 25 `"25"', add
label define age_lbl 26 `"26"', add
label define age_lbl 27 `"27"', add
label define age_lbl 28 `"28"', add
label define age_lbl 29 `"29"', add
label define age_lbl 30 `"30"', add
label define age_lbl 31 `"31"', add
label define age_lbl 32 `"32"', add
label define age_lbl 33 `"33"', add
label define age_lbl 34 `"34"', add
label define age_lbl 35 `"35"', add
label define age_lbl 36 `"36"', add
label define age_lbl 37 `"37"', add
label define age_lbl 38 `"38"', add
label define age_lbl 39 `"39"', add
label define age_lbl 40 `"40"', add
label define age_lbl 41 `"41"', add
label define age_lbl 42 `"42"', add
label define age_lbl 43 `"43"', add
label define age_lbl 44 `"44"', add
label define age_lbl 45 `"45"', add
label define age_lbl 46 `"46"', add
label define age_lbl 47 `"47"', add
label define age_lbl 48 `"48"', add
label define age_lbl 49 `"49"', add
label define age_lbl 50 `"50"', add
label define age_lbl 51 `"51"', add
label define age_lbl 52 `"52"', add
label define age_lbl 53 `"53"', add
label define age_lbl 54 `"54"', add
label define age_lbl 55 `"55"', add
label define age_lbl 56 `"56"', add
label define age_lbl 57 `"57"', add
label define age_lbl 58 `"58"', add
label define age_lbl 59 `"59"', add
label define age_lbl 60 `"60"', add
label define age_lbl 61 `"61"', add
label define age_lbl 62 `"62"', add
label define age_lbl 63 `"63"', add
label define age_lbl 64 `"64"', add
label define age_lbl 65 `"65"', add
label define age_lbl 66 `"66"', add
label define age_lbl 67 `"67"', add
label define age_lbl 68 `"68"', add
label define age_lbl 69 `"69"', add
label define age_lbl 70 `"70"', add
label define age_lbl 71 `"71"', add
label define age_lbl 72 `"72"', add
label define age_lbl 73 `"73"', add
label define age_lbl 74 `"74"', add
label define age_lbl 75 `"75"', add
label define age_lbl 76 `"76"', add
label define age_lbl 77 `"77"', add
label define age_lbl 78 `"78"', add
label define age_lbl 79 `"79"', add
label define age_lbl 80 `"80"', add
label define age_lbl 81 `"81"', add
label define age_lbl 82 `"82"', add
label define age_lbl 83 `"83"', add
label define age_lbl 84 `"84"', add
label define age_lbl 85 `"85"', add
label define age_lbl 86 `"86"', add
label define age_lbl 87 `"87"', add
label define age_lbl 88 `"88"', add
label define age_lbl 89 `"89"', add
label define age_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_lbl 91 `"91"', add
label define age_lbl 92 `"92"', add
label define age_lbl 93 `"93"', add
label define age_lbl 94 `"94"', add
label define age_lbl 95 `"95"', add
label define age_lbl 96 `"96"', add
label define age_lbl 97 `"97"', add
label define age_lbl 98 `"98"', add
label define age_lbl 99 `"99+"', add
label values age age_lbl

label define empstat_lbl 00 `"NIU"'
label define empstat_lbl 01 `"Armed Forces"', add
label define empstat_lbl 10 `"At work"', add
label define empstat_lbl 12 `"Has job, not at work last week"', add
label define empstat_lbl 20 `"Unemployed"', add
label define empstat_lbl 21 `"Unemployed, experienced worker"', add
label define empstat_lbl 22 `"Unemployed, new worker"', add
label define empstat_lbl 30 `"Not in labor force"', add
label define empstat_lbl 31 `"NILF, housework"', add
label define empstat_lbl 32 `"NILF, unable to work"', add
label define empstat_lbl 33 `"NILF, school"', add
label define empstat_lbl 34 `"NILF, other"', add
label define empstat_lbl 35 `"NILF, unpaid, lt 15 hours"', add
label define empstat_lbl 36 `"NILF, retired"', add
label values empstat empstat_lbl

label define health_lbl 1 `"Excellent"'
label define health_lbl 2 `"Very good"', add
label define health_lbl 3 `"Good"', add
label define health_lbl 4 `"Fair"', add
label define health_lbl 5 `"Poor"', add
label values health health_lbl


/* Part I: Frequencies of FOODSTMP */
/* 
1. "NIU" means that not in universe, "yes" means that people have received the food stamps, and "no" means that people have not received the food stamps. 

2. Universe:
1980-1989: Households with a total income below $30,000.
1990-2022: All interviewed households.

3. 8,661 eceived food stamps in 2011.

4. 8661 / (8661 + 66527 + 21770) = 0.0893 = 8.93% 
8.93% of the population received food stamps in 2011.
*/

replace asecwt = round(asecwt) 
tabulate foodstmp [fweight=asecwt] 
replace asecwth = round(asecwth) 
tabulate foodstmp if pernum==1  [weight=asecwth] 
/* 
5. 12,855,335 households received food stamps in 2011. 

6. 10.71% of households received food stamps in 2011. 
*/


/* Part II: Relationships in the Data */
/*
7. Universe:
1962-1967 (ASEC): Persons age 14+ (pre-1968 samples do not include persons under age 14).
1968-1988: Persons age 14+.
1989+: Persons age 15+.

8. HEALTH indicates how respondents rated their current health on a five-point scale, as excellent, very good, good, fair, or poor.
*/

tab empstat  if health==5 [fweight=asecwt] 
tab empstat  if health==2 [fweight=asecwt] 
/*
9. 11.61% of people with 'poor' self-reported health are at work.

10. 51.62% of people with ‘very good’ self-reported health are at work.
*/

tab empstat  if health==5 & age>=15 [fweight=asecwt] 
tab empstat  if health==2 & empstat!=00  [weight=asecwt] 
/* 
11. 
a. 11.81% of people self-report ‘poor’ health and are at work.
b. 63.98% of people self-report ‘very good’ health and are at work.
*/

/* Part III: Relationships in the Data */
/* 
12. Universe:
1962-1988 (ASEC): Civilians age 14+, at work last week (pre-1968 samples do not include persons under age 14).
1989+: Civilians age 15+, at work last week.
*/

mean ahrsworkt if age>=15 & ahrsworkt <999 [weight=asecwt], over(health) 
/* 13. Excellent: 38.39725; Very good: 38.66233; Good: 37.77808; Fair: 35.67311; Poor: 32.41215. */

log close
