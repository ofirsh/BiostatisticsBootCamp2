# Solution by Ofir Shalev, February 2015
----------------------------------------

# Question 1
# ----------
# 
# What is the delta method asymptotic standard error of sqrt(phat) where phat is X/n where 
# X∼Binomial(n,p)?

# Answer 1 (pseudo code)
# ----------------------

# pseudo algorithm, just to show the method - not running code!

# SE.theta = sqrt( p*(1-p) / n  )
# Asymptotic standard error of f(theta) can be estimated with f'(theta) * SE.theta (lecture 6, page 4)
# f(x) = sqrt(x)
# f'(x) = 0.5 * (1 / sqrt(x) )
# standard error: sqrt( (1-p)/(4*n) )

# Question 2
# ----------
# 
# 
# You are a bookie taking $1 bets on the NFL Ravens game. 
# The odds you give betters determines their payout. 
# If you give 4 to 1 odds against the Ravens winning, then if a person bets on the Ravens winning and they win, 
# you owe them their original dollar, plus an additional $4 (a total of $5). 
# If a person bets on the Ravens losing and they lose, then you owe them their original dollar back, 
#     plus $0.25 (a total of $1.25).
# 
# Suppose you collect a > 0 one dollar bets on the Ravens winning and b > 0 one dollar bets on the Ravens losing. 
# What should you set the odds so that, regardless of the outcome of the game, you neither win nor lose money? 
# Note, in this case, the betters place their bets and learn the odds later. 
# Note also, the odds are something that you set in this case, not a direct measure of probability or randomness.



# Question 3
# ----------
# 
# 

# In a randomly sampled survey of self-reported stress levels from two occupations, the following data were obtained
# High Stress     Low Stress
# Professor 	    70
# Lion Tamer 	15
# 
# What is the P-value for a Z score test of equality of the proportions of high stress?
# (Note the notation 1e-5, for example, is 1×10−5).
# 
# 4e-15
# 1e-14
# 1e-5
# 1e-3


p1 <- 0.7
n1 <- 100
p2 <- 0.15
n2 <- 100

RR <- p1 / p2

RR.log <- log(RR) 
# [1] 1.540445



Standard.Error.Log.RR <- sqrt( ((1-p1)/(p1*n1)) + ((1-p2)/(p2*n2))   )
# [1] 0.2468854

2 * pnorm(0, mean = RR.log, sd = Standard.Error.Log.RR, lower.tail = TRUE  )

z.1.minus.half.alpha <- RR.log / Standard.Error.Log.RR
# [1] 6.239516

alpha <- 1 * pnorm(-z.1.minus.half.alpha)

RR <- exp(RR.log)
# [1] 4.666667 

Standard.Error.RR <- exp(Standard.Error.Log.RR)
# 1.280032

2 * pnorm(1, mean = RR, sd = Standard.Error.RR, lower.tail = TRUE  )

# so the mean of the ratio is 4.666667, with sd of 1.280032 - Professors will be higer than the 2nd group
#   as long as the (ratio - sd * w*z > 0)

z <- RR / Standard.Error.RR
# [1] 3.645741

p.inside <- 1 - 2 * pnorm( q = -z, lower.tail = TRUE  )

alpha <- 1 - p.inside
# [1] 0.0001333111

# Question 4
# ----------
# 
# 
# Consider the following data recording case status relative to an environmental exposure
# Case 	Control
# Exposed 	45 	21
# Unexposed 	15 	52
# 
# What would be the estimated asymptotic standard error for the log relative risk for this data? 
# Consider case status as the outcome. That is, we're interested in evaluating the ratio of the proportion of 
# cases comparing exposed to unexposed groups.
# 
# Around 0.05
# Around 1.25
# Around 0.25
# Around 1.05

n1 <- 45+21
p1 <- 45/n1

n2 <- 15+52
p2 <- 15/n2

RR <- p1 / p2

RR.log <- log(RR) 

Standard.Error.Log.RR <- sqrt( ((1-p1)/(p1*n1)) + ((1-p2)/(p2*n2))   )
# 0.2425119

Standard.Error.RR <- exp(Standard.Error.Log.RR) 
# [1] 1.274446

# Question 5
# ----------
# 
# If x1∼Binomial(n1,p1) and x2∼Binomial(n2,p2) and independent Beta(2,2) priors are placed on p1 and p2, 
# what is the posterior mean for p1−p2?



# Question 6
# ----------
# 
# Researchers conducted a blind taste test of Coke versus Pepsi. 
# Each of four people was asked which of two blinded drinks given in random order that they preferred. 
# The data was such that 3 of the 4 people chose Coke. 
# Assuming that this sample is representative, report a P-value for a test of the hypothesis that 
#     Coke is preferred to Pepsi using a **two sided** exact test.
# 
# Around 0.6
# Around 0.5
# Around 0.4
# Around 0.3
