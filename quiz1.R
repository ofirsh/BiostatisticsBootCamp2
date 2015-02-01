# Solution by Ofir Shalev, January 2015
---------------------------------------

# Question 1
# ----------
# In a random sample of 100 patients at a clinic, you would like to test whether the mean RDI is x or more using a one sided 5% type 1 error rate. 
# The sample mean RDI had a mean of 12 and a standard deviation of 4. 
# What value of x (testing H0:μ=x versus Ha:μ>x) would you reject for?

# Answer 1
----------
standard.deviation <- 4
mean <- 12
n <- 100
alpha <- 0.05
criticalValue <- qnorm(1-alpha)
x.reject <- mean  - (((criticalValue * standard.deviation)) / sqrt(n))


# Question 2
# ----------
# A pharmaceutical company is interested in testing a potential blood pressure lowering medication. 
# Their first examination considers only subjects that received the medication at baseline then two weeks later. The data are as follows (SBP in mmHg)

# Baseline    Week 2
# 140	138
# 138	136
# 150	148
# 148	146
# 135	133
# Test the hypothesis that there was a mean reduction in blood pressure. 
# Compare the difference between a paired and unpaired test for a two sided 5% level test.

# Answer 2
# ----------
# When comparing groups, first determine whether observations are paired or not
# When dealing a single set of paired data, one strategy is to take the difference between the paired observation 
#   and do a one-sample t test of H0 : μd = 0 versus Ha : μd != 0 (or one of the other two alternatives)

baseline <- c(140,138,150,148,135)
week2 <- c(138,136,148,146,133)

diff <- baseline - week2
n <- length(diff)
m <- mean(diff) # 2
s <- sd(diff) # 0
# testStat <- sqrt(n) * mean(m) / s  # can't calculate, as sd is zero and can't divide by zero

# on the limit s -> 0, testStat is growing to infinity, which means that we reject the null hypothesis that both are the same

# Hence, can't reject the paired 

# The extension to two independent groups should come as no surprise

sd.baseline <- sd(baseline) # 6.496153
sd.week2 <- sd(week2) # 6.496153

sd.pooled <- sd.baseline*sqrt( 1/length(baseline) + 1/length(week2) )

z <- ( mean(week2) - mean(baseline) ) / (  sd.pooled ) #  -0.4867924

pnormal(z)  # 31%, can't reject the null hypothese

sx.div.nx = (sd.baseline ^ 2) / length(sd.baseline)
sy.div.ny = (sd.week2 ^ 2) / length(sd.week2)

df <- ( sx.div.nx + sy.div.ny ) ^ 2 /  (  ( (sx.div.nx^2) / (length(sx.div.nx) - 1) )  +  ( (sy.div.ny^2) / (length(sy.div.ny) - 1) ) ) # 0

# Reject for the paired; fail to reject for the unpaired


# Question 3
# ----------

# Brain volumes for 9 men yielded a 90 % confidence interval of 1,077 cc to 1,123 cc. Would you reject in a two sided 5% hypothesis test of H0:μ=1,078?

# Options:
# You would reject the null hypothesis.
# It can not be ascertained from the information given.
# You would fail to reject the null hypothesis.

# Answer 3
# --------

# 90% confidence interval means that taking a random sample of 9 men, 90% of the average brain volumes will fall within the range of 1,077 to 1,123
# It also means that we can't reject a two sided 5% hypothesis test of H0:μ=1,078, as it is within the range of the null hypothesis
# So the answer is that "You would fail to reject the null hypothesis."


# Question 4
# ----------
# In an effort to improve efficiency, hospital administrators are evaluating a new triage system for their emergency room. In an validation study of the system, 5 patients were tracked in a mock (simulated) ER under the new and old triage system. Their waiting times in natural log of hours were:
#     
#     Subject    1	2	3	4	5
#         New	0.929	-1.745	1.677	0.701	0.128
#         Old	2.233	-2.513	1.204	1.938	2.533
# 
# Give a Pvalue for the test of the hypothesis that the new system resulted in lower waiting times for a one sided t test.
# 
# 0.1405
# 0.2597
# 0.5194
# 0.281

# Answer
# ------

new.log <- c(0.929,-1.745,1.677,0.701,0.128)
old.log <- c(2.233,-2.513,1.204,1.938,2.533)

new.hos <- exp(new.log)
old.hos <- exp(old.log)

delta <- new.hos - old.hos

t.test(x=new.log,y=old.log,alternative = c("less"), paired = TRUE)
# data:  new.log and old.log
# t = -1.2452, df = 4, p-value = 0.1405
# alternative hypothesis: true difference in means is less than 0
# 95 percent confidence interval:
#     -Inf 0.5276511

# The answer is p-value = 0.1405


# Question 5
# ----------
# Refer to the previous question. Give a 95% T confidence interval for the ratio of the waiting times (recall that the measurements were natural logged).
# 
# Here's the data and setting again. 

t.test(x=new.log,y=old.log,alternative = c("two.sided"), paired = TRUE,conf.level = 0.95)

# data:  new.log and old.log
# t = -1.2452, df = 4, p-value = 0.281
# alternative hypothesis: true difference in means is not equal to 0
# 95 percent confidence interval:
#     -2.3932482  0.9112482
# sample estimates:

exp(-2.3932482) # 0.09133254
exp(0.9112482) # 2.487425


# Question 6
# ----------
# Suppose that 18 obese subjects were randomized, 9 each, to a new diet pill and a placebo. Subjects’ 
#     body mass indices (BMIs) were measured at a baseline and again after having received the treatment
#     or placebo for four weeks. 
# The average difference from follow-up to the baseline (followup - baseline) was −3 kg/m2 for 
# the treated group and 1 kg/m2 for the placebo group. 
# The corresponding standard deviations of the differences was 1.5 kg/m2 for the treatment group 
#     and 1.8 kg/m2 for the placebo group. 
# Does the change in BMI over the two year period appear to differ between the treated and placebo 
#     groups? Assuming normality of the underlying data and a common population variance, 
#     give a pvalue for a two sided t test.
# 
# Around 0.01
# Around 0.0001
# Around 0.00005
# Around 0.1
# Around 0.001
# 
# Answer
# -----
#

treated.delta.mean <- -3.0
placebo.delta.mean <- 1

treated.sd <- 1.5
placebo.sd <- 1.8

nx <- 9
ny <- 9

Sx.nx <- (treated.sd ^ 2) / nx
Sy.ny <- (placebo.sd ^ 2) / ny

# ...follows a standard normal distribution for large nx and ny . It follows an
# approximate Students T distribution if the Xi and Yi are normally distributed
test.stat <- ( treated.delta.mean - placebo.delta.mean ) / ( sqrt( Sx.nx + Sy.ny )  ) # -5.121475

# The approximate degrees of freedom are:

df <- ( ( Sx.nx + Sy.ny ) ^ 2 ) / ( Sx.nx^2/(nx - 1) + Sy.ny^2/(ny - 1)  ) # 15.4961

p <- pt( q = test.stat, df = df, lower.tail = TRUE )

two.sided.t <- 2 * p   # 0.00011


# Question 7
# ----------
# Consider a one sided α level single group Z test of H0:μ=μ0 versus Ha:μ>μ0 with the data X¯ for 
# the sample mean and s for the sample standard deviation with n measurements. 
# What are the collection of points for which you would fail to reject the hypothesis?
# 
# (−∞,X+Z1−αs/n√]
# [X+Z1−αs/n√,∞)
# (−∞,X−Z1−αs/n√]
# [X−Z1−αs/n√,∞)
# The confidence interval X¯±Z1−α/2s/n√
# 
# Answer
# ------
#

# (−∞,X+Z1−αs/n‾‾√]



# Question 8
# -----------
# Researchers would like to conduct a study of n healthy adults to detect a four year mean brain 
#   volume loss of .01 mm3. 
# Assume that the standard deviation of four year volume loss in this population is .04 mm3. 
# What would be the value of n needded for 90% power of type one error rate of 5% one sided test 
#   versus a null hypothesis of no volume loss?

# Around 140
# Around 20
# Around 100
# Around 50

# Answer
# ------


# Calculating power
# Assume that n is large and that we know sigma

mu <- 0.01 
sd <- 0.04
alpha <- 0.05
power <- 0.9

z.alpha <-  qnorm(1-alpha)
z.power <- qnorm(1-power)

n <- ( ( sd / mu ) * ( z.alpha - z.power ) )^2
# [1] 137.0216

# lets compare with the power test ...
power.t.test(n = NULL, delta = miu, sd = sd, sig.level = alpha, power = power, type = c("one.sample"), alternative = c("one.sided") )

# n = 138.3856

# result
# ------
# One-sample t test power calculation 
# 
# n = 138.3856
# delta = 0.01
# sd = 0.04
# sig.level = 0.05
# power = 0.9
# alternative = one.sided



# Question 9
# ----------
# The Daily Planet ran a recent story about Kryptonite poisoning in the water supply after a recent event in Metropolis. 
# Their usual field reporter, Clark Kent, called in sick and so Lois Lane reported the stories. 
# Researchers plan to sample 288 individuals from Metropolis and control city Gotham and will compare mean blood Kryptonite levels (in Lex Luthors per milliliter, LL/ml). 
# The expect to find a mean difference in LL/ml of around 2. Assoming a two sided Z test of the relevant hypothesis at 5%, what would be the power. 
# Assume that the standard deviation is 12 for both groups.

# Answer
# ------


n <- 288
delta <- 2
alpha <- 0.05
sd <- 12

power.t.test(n=288,delta=2,sd=12,sig.level=0.05,type=c("two.sample"),alternative = c("two.sided")) 

# Two-sample t test power calculation 
# 
# n = 288
# delta = 2
# sd = 12
# sig.level = 0.05
# power = 0.5146336
# alternative = two.sided

# answer: 51%

z.1.minus.alpha <- qnorm(1-alpha)
z.stat <- z.1.minus.alpha - mu * sqrt(n) / sd
pnorm(q = z.stat,lower.tail = FALSE)
# [1] 0.881709


# Question 10
# ------------
# As you increase the type one error rate, α, what happens to power?
# 
# The power goes down
# It is impossible to say
# Power stays the same
# The power goes up

# As you increase the type one error rate, alpha is increasing, beta is decreasing and power is increasing

# The power goes up


# Question 11
# -----------
# Consider a setting with iid data from a N(μ,σ2) distribution testing H0:μ=0 verus Ha:μ>0. 
# The null hypothesis is rejected if n‾‾√X¯/σ>1.645. What happens to the type I error rate as n goes to infinity?
# 
# It is 5% regardless of the size of n
# It limits to 5%, but can be a different value for small sample sizes
# It is 10% regardless of the size of n
# It limits to 10%, but can be a different value for small sample sizes

# Answer
# ------

# It limits to 5%, but can be a different value for small sample sizes


# Question 13
# ------------
# Consider a one sample Z test of $H_0 : \mu = \mu_0$ versus $H_a : \mu > \mu_0$. 
# All else equal, which scenarios will be closer to rejecting the null hypothesis?
# X¯ is small, μ0 is large, σ is large
# X¯ is small, μ0 is large, σ is small
# X¯ is large, μ0 is large, σ is large
# X¯ is large, μ0 is large, σ is small
# X¯ is large, μ0 is small, σ is small
# X¯ is small, μ0 is small, σ is small
# X¯ is small, μ0 is small, σ is large
# X¯ is large, μ0 is small, σ is large
# 
# Logic:
#     
# z = sqrt(n)(x-u)/sigma
# 
# Rejecting the null hypothesis requires large z, which means:
#     Sigma should be small
#     x-u should be large and positive, so x should be large and u should be small
# 
# X¯ is large, μ0 is small, σ is small
