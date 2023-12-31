clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab1.log, replace


/* This lab explores types of datasets (panel, etc.) and practices 
   some basic Stata data exploration commands */



* I. Question 1
clear
use bloodpressure
  
use "/Users/diaowenshu/Desktop/bloodpressure.dta"
  
describe
/* There are several variables: patient, sex, agegrp, when, and bp. */

count

summarize

summarize sex, detail

edit

tabulate sex 

histogram sex 

sort when 

/* It is a panel  data since the same patient is checked before and after. which is more than oone time */

/* 
Preliminary analysis 

- The numbers of males and females are the same. They are both 120. 
- The maximum blood pressure is 185. */

clear
use instagram_data

use "/Users/diaowenshu/Desktop/instagram_data.dta"

describe

summarize

summarize DATE, detail

tabulate DATE

summarize LIKES, detail

summarize LIKES if DAY0MONDAY6SUNDAY == 0
summarize LIKES if DAY0MONDAY6SUNDAY == 1
summarize LIKES if DAY0MONDAY6SUNDAY == 2
summarize LIKES if DAY0MONDAY6SUNDAY == 3
summarize LIKES if DAY0MONDAY6SUNDAY == 4
summarize LIKES if DAY0MONDAY6SUNDAY == 5
summarize LIKES if DAY0MONDAY6SUNDAY == 6

/* Thursday has the highest average LIKES*/

histogram COMMENTS

/* The histogram is skewed to the left */
log close
