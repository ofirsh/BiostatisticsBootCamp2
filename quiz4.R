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



What is the smallest value that the two sided exact signed rank p-value could take?