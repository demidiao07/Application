clear 
set more off
cd "H:\econ 326\"
capture log close
log using lab3.log, replace

/*
"clear" tells Stata to erase the previous dataset.
"set more off" tells Stata not to pause or display the more message.
"cd" changes the current working directory, and sets our directory to 
"econ 326" in Home Drive.
"capture log close" closes a log if any is open and do nothing if no log 
is open.
"log using replace" allows you to make a full record of your Stata session.
*/

clear 
ssc install sdist
sdist, histplot

/* 
In the population, we do the random sampling for 200 times, and calculate
the mean. Hence, we get 200 numbers of the mean of x, then we put the numbers 
into a histogram, which is plot 1.

Plot 2 only contains one variable, which is the true population mean. 

We have 200 samples, which is pretty large, so when we plot the histogram, the 
central value of distribution equals to the true population mean according to 
central limit theorem. 
*/

sdist, samples(50) obs(10) histplot

/*
When the sample number is 50, the plot looks not less normally distributed
than before. Also, the sample mean value is 0.495, and the true population mean 
is 0.424. The difference between sample mean and population mean is higher 
than the one with 200 samples.
*/

sdist, samples(682) obs(10) histplot

/*
When the sample number is 682, the plot looks very normally distributed. The 
sample mean value is 0.508, and the true population mean 
is 0.538. The difference between sample mean and population mean is not much.
The three results prove CLT together: the distribution of sample means 
approximates a normal distribution as the sample size gets larger, regardless 
of the population's distribution.
*/

clear 
ssc install bcuse
bcuse caschool

reg testscr str

/*
The coefficient tells us on average, test score will decrease 2.28 associated 
with a one-unit change in student-teacher ratio. It is statistically 
significant since its p-value is 0.
*/

reg testscr str avginc

/* 
The coefficient tells us on average, test score will decrease 0.65 associated
with a one-unit change in student-teacher ratio, holding average income 
constant. The coefficient value increase. It is not statistically significant 
now since its p-value is 0.068, which is larger than 0.05. Hence, we can tell 
that student-teacher ratio has influence on test score after controlling 
average income.
*/

reg testscr avginc
predict newvar1, resid
reg str avginc
predict newvar2, resid
reg newvar1 newvar2

/* 
According to the Frisch-Waugh Theorem, there is no difference between two
regression models.
*/

search esttab
eststo: reg testscr str
eststo: reg testscr str avginc
esttab using "regtable.csv", ar2 label replace