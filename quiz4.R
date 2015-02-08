# Solution by Ofir Shalev, February 2015
----------------------------------------
    
# Question 1
# ----------
# A case-control study of esophageal cancer was performed. Daily alcohol consumption was ascertained (H = high, L = low). The data was stratified by 2 age groups.
# 
# Low age group
# 
#           H    L
# Case	    8	5
# Control	52	164
# High age group
# 
#           H	L
# Case	    25	21
# Control	29	128

# Assuming a constant odds ratio across age-strata, test to see if the odds ratio is 1 and report a Pvalue
# 

# http://www.biostathandbook.com/cmh.html
# Use the Cochran–Mantel–Haenszel test when you have data from 2×2 tables that you've repeated at different times or locations. 
# It will tell you whether you have a consistent difference in proportions across the repeats.

dat <- array(c(8, 52, 5, 164,  25, 29,  21, 128),c(2, 2, 2))

# mantelhaen.test(dat, correct = FALSE)
mantelhaen.test(dat, correct = TRUE)


# Mantel-Haenszel chi-squared test with continuity correction
#
# data:  dat
# Mantel-Haenszel X-squared = 30.3539, df = 1, p-value = 3.6e-08
# alternative hypothesis: true common odds ratio is not equal to 1
# 95 percent confidence interval:
#     2.842789 9.501945
# sample estimates:
#     common odds ratio 
# 5.19731 


# The Pvalue is small (less than .05), suggesting that the common odds ratio is different than one

# Question 2
# ----------
# The Biostatistics and Epidemilogy departments are running a 10K road race. 
# There are three pairs of runners. In each case, a runner from Biostat was matched to a runner from Epi of the same age, gender and degree of running experience. 
# The difference in each pairs times was taken and a signed rank test performed.
#

# What is the smallest value that the two sided exact signed rank p-value could take?


# Answer
# ------

# The smallest value of the p test is when the delta of all 3 pairs is positive (or negative)

binom.test(3,3)

# data:  3 and 3
# number of successes = 3, number of trials = 3, p-value = 0.25
# alternative hypothesis: true probability of success is not equal to 0.5
# 95 percent confidence interval:
#     0.2924018 1.0000000
# sample estimates:
#     probability of success 
# 1 

# p-value = 0.25


# Question 3
# ----------
# 
# Two computer based methods for diagnostic imaging are being studied. 
# Ten images were processed with both methods, resulting in a + or − diagnosis for each method and image. 
# The data are as follows
#
#        + 	-
# + 	55 	41
# - 	12 	20
# 
# Where Method A is represeted with the two columns and Method B is represented on the rows. 
# What is the P-value for a of the hypothesis that the marginal probability of a positive diagnosis 
#     is the same for the two methods? (Use the large sample version.)
# 

# Answer
# ------

dat <- matrix(c(55,41,12,20),nrow=2,byrow=TRUE)
mcnemar.test(dat,correct = TRUE)

# McNemar's Chi-squared test with continuity correction
# 
# data:  dat
# McNemar's chi-squared = 14.7925, df = 1, p-value = 0.00012

# The P-value is highly significant, suggesting that the marginal probabilities do differ. 


# Question 4
# ----------
# Two computer based methods for diagnostic imaging are being studied. 
# Ten images were processed with both methods, resulting in a + or − diagnosis for each method and image. 
# The data are as follows
# 
#         + 	-
#     + 	55 	41
#     - 	12 	20
# 
# Where Method A is represeted with the two columns and Method B is represented on the rows. 
# What is the marginal odds ratio of a positive diagnosis comparing the two methods? 
# (Put the odds associated with Method B in the numerator.)
# 

dat <- matrix(c(55,41,12,20),nrow=2,byrow=TRUE)

s <- sum(dat)
p <- dat / s

p.one.plus <- sum( p[1,] )
p.two.plus <- sum( p[2,] )

p.plus.one <- sum( p[,1] )
p.plus.two <- sum( p[,2] )

marginal.odd.ratio <- ( p.one.plus * p.plus.two) / ( p.plus.one * p.two.plus )
# 2.731343



Question 5
----------
# A matched case control study was executed to study an airborn environmental toxicant's effect on lung cancer.
# The data are
# 
# Case and exposure status     count
# Case exposed, control exposed 	243
# Case exposed, control unexposed 	189
# Case unexposed, control exposed 	54
# Case unexposed, control unexposed 	153
# 
# What is the conditional odds ratio of odds of exposure for cases over odds of exposure for controls?

dat <- matrix(c(243,189,54,153),nrow=2,byrow=TRUE)

# > dat
#      [,1] [,2]
# [1,]  243  189
# [2,]   54  153

gamma <- (243*153)/(189*54)
# 3.6

54 / 189
# 0.29

189 / 54
# 3.5


# Question 6
# ----------
# A topical rash treatment was applied to a portion of a rash on n patients. 
# A quantitative measure of redness was calculated for the treated and untreated regions of the rash. 
# A sign of + was given when the treated area was less red (more improved) than the untreated area and
#     a − sign when it was not. It is desired to know whether the treatment improves the rash.
# 
# How many possible values can the P-value for the sign test take?

# Logic: should be a p value of every value of w positives and (n-w) negatives
# So:  (0 positives, n negatives), ( 1 p, n-1 n), (2 p, n-2 negatives),(n positives, 0 negatives)
# Logically: (n+1) values


# Question 7
# ----------
# 
# A topical rash treatment was applied to a portion of a rash on n patients. 
# A quantitative measure of redness was calculated for the treated and untreated regions of the rash. 
# A sign of + was given when the treated area was less red (more improved) than the untreated area and 
#     a − sign when it was not. It is desired to know whether the treatment improves the rash.
# 
# Consider a 5% one sided sign test for 5 subjects. 
# What would be the power of the test if the probability that the treatment works is 
# actually 80% instead of the 50% assumed under the null?
# 


