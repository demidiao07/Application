clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab6_exercise2.log, replace


* NOTE: You need to set the Stata working directory to the path
* where the data file is located.

set more off

clear
quietly infix                   ///
  int     year         1-4      ///
  long    serial       5-9      ///
  byte    month        10-11    ///
  double  cpsid        12-25    ///
  byte    asecflag     26-26    ///
  double  asecwth      27-37    ///
  byte    pernum       38-39    ///
  double  cpsidp       40-53    ///
  double  asecwt       54-64    ///
  byte    age          65-66    ///
  byte    sex          67-67    ///
  byte    marst        68-68    ///
  byte    diffhear     69-69    ///
  byte    diffeye      70-70    ///
  byte    health       71-71    ///
  byte    pernum_sp    72-73    ///
  double  cpsidp_sp    74-87    ///
  double  asecwt_sp    88-98    ///
  byte    age_sp       99-100   ///
  byte    sex_sp       101-101  ///
  byte    marst_sp     102-102  ///
  byte    diffhear_sp  103-103  ///
  byte    diffeye_sp   104-104  ///
  byte    health_mom   105-105  ///
  byte    health_mom2  106-106  ///
  byte    health_pop   107-107  ///
  byte    health_pop2  108-108  ///
  byte    health_sp    109-109  ///
  using `"cps_00002.dat"'

replace asecwth     = asecwth     / 10000
replace asecwt      = asecwt      / 10000
replace asecwt_sp   = asecwt_sp   / 10000

format cpsid       %14.0f
format asecwth     %11.4f
format cpsidp      %14.0f
format asecwt      %11.4f
format cpsidp_sp   %14.0f
format asecwt_sp   %11.4f

label var year        `"Survey year"'
label var serial      `"Household serial number"'
label var month       `"Month"'
label var cpsid       `"CPSID, household record"'
label var asecflag    `"Flag for ASEC"'
label var asecwth     `"Annual Social and Economic Supplement Household weight"'
label var pernum      `"Person number in sample unit"'
label var cpsidp      `"CPSID, person record"'
label var asecwt      `"Annual Social and Economic Supplement Weight"'
label var age         `"Age"'
label var sex         `"Sex"'
label var marst       `"Marital status"'
label var diffhear    `"Hearing difficulty"'
label var diffeye     `"Vision difficulty"'
label var health      `"Health status"'
label var pernum_sp   `"Person number in sample unit [of Person number of spouse (from programming)]"'
label var cpsidp_sp   `"CPSID, person record [of Person number of spouse (from programming)]"'
label var asecwt_sp   `"Annual Social and Economic Supplement Weight [of Person number of spouse (from p"'
label var age_sp      `"Age [of Person number of spouse (from programming)]"'
label var sex_sp      `"Sex [of Person number of spouse (from programming)]"'
label var marst_sp    `"Marital status [of Person number of spouse (from programming)]"'
label var diffhear_sp `"Hearing difficulty [of Person number of spouse (from programming)]"'
label var diffeye_sp  `"Vision difficulty [of Person number of spouse (from programming)]"'
label var health_mom  `"Health status [of Person number of first mother (from programming)]"'
label var health_mom2 `"Health status [of Person number of second mother (from programming)]"'
label var health_pop  `"Health status [of Person number of first father (from programming)]"'
label var health_pop2 `"Health status [of Person number of second father (from programming)]"'
label var health_sp   `"Health status [of Person number of spouse (from programming)]"'

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

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label define sex_lbl 9 `"NIU"', add
label values sex sex_lbl

label define marst_lbl 1 `"Married, spouse present"'
label define marst_lbl 2 `"Married, spouse absent"', add
label define marst_lbl 3 `"Separated"', add
label define marst_lbl 4 `"Divorced"', add
label define marst_lbl 5 `"Widowed"', add
label define marst_lbl 6 `"Never married/single"', add
label define marst_lbl 7 `"Widowed or Divorced"', add
label define marst_lbl 9 `"NIU"', add
label values marst marst_lbl

label define diffhear_lbl 0 `"NIU"'
label define diffhear_lbl 1 `"No hearing difficulty"', add
label define diffhear_lbl 2 `"Has hearing difficulty"', add
label values diffhear diffhear_lbl

label define diffeye_lbl 0 `"NIU"'
label define diffeye_lbl 1 `"No vision difficulty"', add
label define diffeye_lbl 2 `"Has vision difficulty"', add
label values diffeye diffeye_lbl

label define health_lbl 1 `"Excellent"'
label define health_lbl 2 `"Very good"', add
label define health_lbl 3 `"Good"', add
label define health_lbl 4 `"Fair"', add
label define health_lbl 5 `"Poor"', add
label values health health_lbl

label define age_sp_lbl 00 `"Under 1 year"'
label define age_sp_lbl 01 `"1"', add
label define age_sp_lbl 02 `"2"', add
label define age_sp_lbl 03 `"3"', add
label define age_sp_lbl 04 `"4"', add
label define age_sp_lbl 05 `"5"', add
label define age_sp_lbl 06 `"6"', add
label define age_sp_lbl 07 `"7"', add
label define age_sp_lbl 08 `"8"', add
label define age_sp_lbl 09 `"9"', add
label define age_sp_lbl 10 `"10"', add
label define age_sp_lbl 11 `"11"', add
label define age_sp_lbl 12 `"12"', add
label define age_sp_lbl 13 `"13"', add
label define age_sp_lbl 14 `"14"', add
label define age_sp_lbl 15 `"15"', add
label define age_sp_lbl 16 `"16"', add
label define age_sp_lbl 17 `"17"', add
label define age_sp_lbl 18 `"18"', add
label define age_sp_lbl 19 `"19"', add
label define age_sp_lbl 20 `"20"', add
label define age_sp_lbl 21 `"21"', add
label define age_sp_lbl 22 `"22"', add
label define age_sp_lbl 23 `"23"', add
label define age_sp_lbl 24 `"24"', add
label define age_sp_lbl 25 `"25"', add
label define age_sp_lbl 26 `"26"', add
label define age_sp_lbl 27 `"27"', add
label define age_sp_lbl 28 `"28"', add
label define age_sp_lbl 29 `"29"', add
label define age_sp_lbl 30 `"30"', add
label define age_sp_lbl 31 `"31"', add
label define age_sp_lbl 32 `"32"', add
label define age_sp_lbl 33 `"33"', add
label define age_sp_lbl 34 `"34"', add
label define age_sp_lbl 35 `"35"', add
label define age_sp_lbl 36 `"36"', add
label define age_sp_lbl 37 `"37"', add
label define age_sp_lbl 38 `"38"', add
label define age_sp_lbl 39 `"39"', add
label define age_sp_lbl 40 `"40"', add
label define age_sp_lbl 41 `"41"', add
label define age_sp_lbl 42 `"42"', add
label define age_sp_lbl 43 `"43"', add
label define age_sp_lbl 44 `"44"', add
label define age_sp_lbl 45 `"45"', add
label define age_sp_lbl 46 `"46"', add
label define age_sp_lbl 47 `"47"', add
label define age_sp_lbl 48 `"48"', add
label define age_sp_lbl 49 `"49"', add
label define age_sp_lbl 50 `"50"', add
label define age_sp_lbl 51 `"51"', add
label define age_sp_lbl 52 `"52"', add
label define age_sp_lbl 53 `"53"', add
label define age_sp_lbl 54 `"54"', add
label define age_sp_lbl 55 `"55"', add
label define age_sp_lbl 56 `"56"', add
label define age_sp_lbl 57 `"57"', add
label define age_sp_lbl 58 `"58"', add
label define age_sp_lbl 59 `"59"', add
label define age_sp_lbl 60 `"60"', add
label define age_sp_lbl 61 `"61"', add
label define age_sp_lbl 62 `"62"', add
label define age_sp_lbl 63 `"63"', add
label define age_sp_lbl 64 `"64"', add
label define age_sp_lbl 65 `"65"', add
label define age_sp_lbl 66 `"66"', add
label define age_sp_lbl 67 `"67"', add
label define age_sp_lbl 68 `"68"', add
label define age_sp_lbl 69 `"69"', add
label define age_sp_lbl 70 `"70"', add
label define age_sp_lbl 71 `"71"', add
label define age_sp_lbl 72 `"72"', add
label define age_sp_lbl 73 `"73"', add
label define age_sp_lbl 74 `"74"', add
label define age_sp_lbl 75 `"75"', add
label define age_sp_lbl 76 `"76"', add
label define age_sp_lbl 77 `"77"', add
label define age_sp_lbl 78 `"78"', add
label define age_sp_lbl 79 `"79"', add
label define age_sp_lbl 80 `"80"', add
label define age_sp_lbl 81 `"81"', add
label define age_sp_lbl 82 `"82"', add
label define age_sp_lbl 83 `"83"', add
label define age_sp_lbl 84 `"84"', add
label define age_sp_lbl 85 `"85"', add
label define age_sp_lbl 86 `"86"', add
label define age_sp_lbl 87 `"87"', add
label define age_sp_lbl 88 `"88"', add
label define age_sp_lbl 89 `"89"', add
label define age_sp_lbl 90 `"90 (90+, 1988-2002)"', add
label define age_sp_lbl 91 `"91"', add
label define age_sp_lbl 92 `"92"', add
label define age_sp_lbl 93 `"93"', add
label define age_sp_lbl 94 `"94"', add
label define age_sp_lbl 95 `"95"', add
label define age_sp_lbl 96 `"96"', add
label define age_sp_lbl 97 `"97"', add
label define age_sp_lbl 98 `"98"', add
label define age_sp_lbl 99 `"99+"', add
label values age_sp age_sp_lbl

label define sex_sp_lbl 1 `"Male"'
label define sex_sp_lbl 2 `"Female"', add
label define sex_sp_lbl 9 `"NIU"', add
label values sex_sp sex_sp_lbl

label define marst_sp_lbl 1 `"Married, spouse present"'
label define marst_sp_lbl 2 `"Married, spouse absent"', add
label define marst_sp_lbl 3 `"Separated"', add
label define marst_sp_lbl 4 `"Divorced"', add
label define marst_sp_lbl 5 `"Widowed"', add
label define marst_sp_lbl 6 `"Never married/single"', add
label define marst_sp_lbl 7 `"Widowed or Divorced"', add
label define marst_sp_lbl 9 `"NIU"', add
label values marst_sp marst_sp_lbl

label define diffhear_sp_lbl 0 `"NIU"'
label define diffhear_sp_lbl 1 `"No hearing difficulty"', add
label define diffhear_sp_lbl 2 `"Has hearing difficulty"', add
label values diffhear_sp diffhear_sp_lbl

label define diffeye_sp_lbl 0 `"NIU"'
label define diffeye_sp_lbl 1 `"No vision difficulty"', add
label define diffeye_sp_lbl 2 `"Has vision difficulty"', add
label values diffeye_sp diffeye_sp_lbl

label define health_mom_lbl 1 `"Excellent"'
label define health_mom_lbl 2 `"Very good"', add
label define health_mom_lbl 3 `"Good"', add
label define health_mom_lbl 4 `"Fair"', add
label define health_mom_lbl 5 `"Poor"', add
label values health_mom health_mom_lbl

label define health_mom2_lbl 1 `"Excellent"'
label define health_mom2_lbl 2 `"Very good"', add
label define health_mom2_lbl 3 `"Good"', add
label define health_mom2_lbl 4 `"Fair"', add
label define health_mom2_lbl 5 `"Poor"', add
label values health_mom2 health_mom2_lbl

label define health_pop_lbl 1 `"Excellent"'
label define health_pop_lbl 2 `"Very good"', add
label define health_pop_lbl 3 `"Good"', add
label define health_pop_lbl 4 `"Fair"', add
label define health_pop_lbl 5 `"Poor"', add
label values health_pop health_pop_lbl

label define health_pop2_lbl 1 `"Excellent"'
label define health_pop2_lbl 2 `"Very good"', add
label define health_pop2_lbl 3 `"Good"', add
label define health_pop2_lbl 4 `"Fair"', add
label define health_pop2_lbl 5 `"Poor"', add
label values health_pop2 health_pop2_lbl

label define health_sp_lbl 1 `"Excellent"'
label define health_sp_lbl 2 `"Very good"', add
label define health_sp_lbl 3 `"Good"', add
label define health_sp_lbl 4 `"Fair"', add
label define health_sp_lbl 5 `"Poor"', add
label values health_sp health_sp_lbl

/* Part I: Creating New Variables */
/* 
1. AGE: Age; SEX: Sex; MARST: Marital status; HEALTH: Health status; DIFFHEAR: Hearing difficulty; DIFFEYE: Vision difficulty 

2. 1 for "Married, spouse present"; 2 for "Married, spouse absent"

3. 1: "Married, spouse present", 
2: "Married, spouse absent", 
3: "Separated", "Divorced", "Widowed", "Never married/single", "Widowed or Divorced", and "NIU".
*/

gen age_dif = age - age_sp if sex==1&(marst==1|marst==2) 
mean age_dif [pweight=asecwt] 
mean age_dif if age<=30 [pweight=asecwt] 
mean age_dif if age>=50 [pweight=asecwt] 

/* 
5. The mean age difference between married men and their spouses is 2.266375.
a. For men aged 30 and under, the difference is -.1605179.
b. For 50 and over, the difference is 3.230359.
*/

/* Part II: Relationships in the Data */
/* 6. DIFFEYE:
Universe: Civilians age 15+
DIFFHEAR:
Universe: Civilians age 15+
NIU is 0.
*/

replace asecwt = round(asecwt) 
tab diffhear  if diffhear>0 [weight=asecwt] 
tab diffeye  if diffeye>0 [weight=asecwt] 

/* 7. 3.09 percent of the population (in the universe) is deaf or has a serious hearing 
difficulty.
1.67 percent of the population (in the universe) is blind or has 
serious sight difficulties. */

tab marst if diffhear==2 [weight=asecwt] 
/* 8. 49.65 percent of the deaf population is married with a spouse present. */

gen couple_deaf = 1 if diffhear==2&diffhear_sp==2 
replace couple_deaf = 0 if diffhear==2&diffhear_sp!=2 
tab couple_deaf [fw= asecwt] 

/* 9. 7.66 percent of the deaf population is married to a spouse who is also deaf. */

/* Part III: Relationships in the Data  */
tab health health_mom [weight=asecwt], row 
tab health health_pop [weight=asecwt], row 

/*
10. The age is from under 1 year to 99+. Both mom and pop have the same health index as children.

11. Yes, the healtier the parents, the healthier their children.

12. The relationship between age and health condition.

13. The sampling issue seldom happens in this context since parents and children are often together unless some children lose parent at a young age.
*/

log close
