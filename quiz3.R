# Solution by Ofir Shalev, February 2015
----------------------------------------
# 
# Question 1
# ----------
# At a party a friend brags that they can tell the difference between cheap and expensive wine. 
# You ask him to taste eight glasses wine for which you have randomized as 4 expensive and 4 cheap. 
# Calculate a P-vlaue for the relevant exact hypothesis test using R's fisher.test function.
# 
#                     Actually Expensive    Actually Cheap
# Guess Expensive	            4	            2
# Guess Cheap	                1	            6
# 

dat <- matrix(c(4, 2, 1, 6), 2)

fisher.test(dat, alternative = "two.sided")

Fisher's Exact Test for Count Data

data:  dat
p-value = 0.1026
alternative hypothesis: true odds ratio is not equal to 1
95 percent confidence interval:
   0.5364938 682.2665965
sample estimates:
odds ratio 
  9.470989 

# p-value = 0.1026


# Question 2
# ----------
# A drug treatment (T = treatment, P = Placebo) has been randomized to 5 patients in each arm. 
# Consider testing an increase in side effects (S = side effects, N = none). The data are
# 
#     T    P
# S	3	1
# N	2	4
# Calculate Fishers exact P-value for a one sided test of the relevant hypothesis.
# 
# Around 0.05
# Around 0.50
# Around 0.25
# Less than 0.01
# Around 0.10

# sorting the matrix so treatment and Placebo will be in the rows, and Side and None will be in columns
dat <- matrix(c(3, 2, 1, 4), 2)

fisher.test(dat, alternative = "greater")

# Fisher's Exact Test for Count Data
# 
# data:  dat
# p-value = 0.2619
# alternative hypothesis: true odds ratio is greater than 1
# 95 percent confidence interval:
#  0.3152217       Inf
# sample estimates:
# odds ratio 
#   4.918388 


# just testing if the original matrix will work the same ...
dat <- matrix(c(3, 1, 2, 4), 2)
fisher.test(dat, alternative = "greater")

# Fisher's Exact Test for Count Data
# 
# data:  dat
# p-value = 0.2619

# Question 3
# ----------
# In a review of the author Jane Austen's work, scholars found the following relative frequencies of the words an'',that'' and “this''
# 
#  an      that	    this
# 0.53	    0.35	0.12
#
# An new story claimed to be Austen's was discovered with the word "an” 140 times, the word “that” 100 times and the word “this” 50 times. 
# Are these counts consistent with Austen's traditional frequencies? Give a chi-squared P-value for the relevant test.
# 
# Around 0.05
# Around 0.50
# Around 0.25
# Greater than 0.75

n <- 140 + 100 + 50

observed <- c( 140 , 100 , 50)
expected <- c( 0.53 * n, 0.35 * n, 0.12 * n )

chi.square <- sum ( ((observed - expected)^2) / expected )
# [1] 7.882393
pchisq(chi.square,1, lower.tail = FALSE)
# [1] 0.004991838
pchisq(chi.square,2, lower.tail = FALSE)
# [1] 0.1850047

dat <- matrix(c( 0.53 * n, 0.35 * n, 0.12 * n,   140,100,50), nrow = 3, byrow = FALSE)
#         [,1] [,2]
# [1,]    153.7  140
# [2,]    101.5  100
# [3,]    34.8   50

# H0 : The probabilities of each word are the same for every book
# Ha : At least two are different

dat.ex <- cbind(dat,dat[,1]+dat[,2])
dat.ex <- rbind(dat.ex,colSums(dat.ex))
m <- dat.ex
#      [,1] [,2]  [,3]
# [1,] 153.7  140 293.7
# [2,] 101.5  100 201.5
# [3,]  34.8   50  84.8
# [4,] 290.0  290 580.0


Observed.11 <- m[ 1 , 1]
Expected.11 <- m[ 4 , 1] * ( m[ 1 , 3]  / m [ 4 , 3 ] )

Observed.12 <- m[ 1 , 2]
Expected.12 <- m[ 4 , 2] * ( m[ 1 , 3]  / m [ 4 , 3 ] )

Observed.21 <- m[ 2 , 1]
Expected.21 <- m[ 4 , 1] * ( m[ 2 , 3]  / m [ 4 , 3 ] )

Observed.22 <- m[ 2 , 2]
Expected.22 <- m[ 4 , 2] * ( m[ 2 , 3]  / m [ 4 , 3 ] )

Observed.31 <- m[ 3 , 1]
Expected.31 <- m[ 4 , 1] * ( m[ 3 , 3]  / m [ 4 , 3 ] )

Observed.32 <- m[ 3 , 2]
Expected.32 <- m[ 4 , 2] * ( m[ 3 , 3]  / m [ 4 , 3 ] )

chi.square <-  ((Observed.11 - Expected.11)^2)/Expected.11 +
    ((Observed.12 - Expected.12)^2)/Expected.12 +
    ((Observed.21 - Expected.21)^2)/Expected.21 +
    ((Observed.22 - Expected.22)^2)/Expected.22 +
    ((Observed.31 - Expected.31)^2)/Expected.31 +
    ((Observed.32 - Expected.32)^2)/Expected.32

# > chi.square
# [1] 3.374748

pchisq(chi.square,2, lower.tail = FALSE)
# [1] 0.1850047

chisq.test(dat)

# Pearson's Chi-squared test
# 
# data:  dat
# X-squared = 3.3747, df = 2, p-value = 0.185


# Question 4
# ----------
# Two drugs, A and B , are being investigated in a randomized trial with the data are given below. 
# Investigators would like to know if the Drug A and Drug B are equivalent in the terms of the distribution of side effects.
# 
#         None Nausea	Nauesea and Vomiting	Total
# Drug A	80	    15	            5	        100
# Drug B	60	    30	            10	        100
# What are the expected cell counts under the null hypothesis?
# 
# 70, 22.5, 7.5 for each row
# 80, 15 and 5 for row 1 (Drug A) and 60, 30 and 10 for row 2 (Drug B)
# 140, 45 and 15 for each row
# 33.3, 33.3 and 33.3 for each row

dat <- matrix(c( 80,15,5,100, 60,30,10,100  ), nrow = 2, byrow = TRUE)
dat.ex <- rbind(dat,colSums(dat))

#       [,1] [,2] [,3] [,4]
# [1,]   80   15    5  100
# [2,]   60   30   10  100
# [3,]  140   45   15  200

#         (140/200)*100   (45/200)*100    (15/200)*100
#         (140/200)*100   ...             ....

(140/200)*100    
# 70
(45/200)*100
# 22.5
(15/200)*100
# 7.5

# Question 5
# ----------
# 100 people who took a pain medication for chronic pain were asked if they still had pain one hour after receiving the dose. 
# They received the dose on two separate weeks. 
# The results are given below with the result of the first week's dose on the rows and the second week's on the columns.
# 
#         Yes    No
# Yes	    43	    4
# No	    8	    45
# Does it appear that the self report impact of the medication is independent from one week to the next? (Test using the relevant chi-squared test.)
# 
# No, the do not appear to be independent; we would fail to reject a chi squared test of independence.
# No, they do not appear independent; we would reject a chi squared test of independence.
# Yes, they do appear to be independent; we would fail to reject a chi squared test of independence.
# Yes, they do appear to be independent; we would reject a chi squared test of independence.

# Answer
# ------
# 
# H0: the self report impact of the medication is independent from one week to the next
# Ha: not independent
 
# # under null hypothesis
# P(Week1 == YES & week2 == YES) = P(Week1 == YES)*P(Week2 == YES)

dat <- matrix(c( 43,4,8,45), nrow = 2, byrow = TRUE)

#       [,1] [,2]
# [1,]   43    4
# [2,]    8   45

dat.ex <- cbind(dat,dat[,1]+dat[,2])
dat.ex <- rbind(dat.ex,colSums(dat.ex))
# 
#       [,1] [,2] [,3]
# [1,]   43    4   47
# [2,]    8   45   53
# [3,]   51   49  100

Observed.11 <- 43
Expected.11 <- 100 * ( 51/100 ) * (47 / 100)

Observed.12 <- 4
Expected.12 <- 100 * ( 49/100 ) * (47 / 100)

Observed.21 <- 8
Expected.21 <- 100 * ( 51/100 ) * (53 / 100)

Observed.22 <- 45
Expected.22 <- 100 * ( 49/100 ) * (53 / 100)

chi.square <-  ((Observed.11 - Expected.11)^2)/Expected.11 +
    ((Observed.12 - Expected.12)^2)/Expected.12 +
    ((Observed.21 - Expected.21)^2)/Expected.21 +
    ((Observed.22 - Expected.22)^2)/Expected.22 

pchisq(chi.square,1, lower.tail = FALSE)
# [1] 2.397876e-14

# Just to validate ...
chisq.test(dat)
#  p-value = 1.112e-13

# No, they do not appear independent; we would reject a chi squared test of independence.

# Question 6
# -----------
# A researcher is studying migration patterns. 
# She collected the location of the current and previous homes for subjects who moved across regions (Northeast, Souteast and West). 
# She recorded the following:
#     
#       NE    SE	W
# NE	-	  267  255
# SE	135	   _   139
# W	    240	  234	-
#     
# Here the row is current home region and the column is the region the person moved to.
# 
# Here the diagonals are not included since she only studied subjects who moved between regions. 
# She would like to know if the probability of moving from region a to b is the same as the probability of moving from region b to a for all regions a and b.
# 
# What can be said about the expected cell counts?
# 
# The expected cell counts would be the average of a cell and its symmetrically opposite cell.
# The expected cell counts would be the same as that of a goodness of fit test.
# The expected cell counts would be the same as that of a test of independence.
# The expected cell counts could not be determined.


# Answer
# -----
# The expected cell counts would be the same as that of a test of independence.

# Transform to the following matrix
# 
#         Way     Opposite
# NE-SE   267         135
# W-NE    240         255   
# W-SE    234         139

E.NE.SE <- ((267+240+234)/(267+240+234+135+255+139)) * (267+135)
# [1] 234.5528
E.SE.NE <- ((135+255+139)/(267+240+234+135+255+139)) * (267+135)
# [1] 167.4472

(267+135)/2


# Question 7
# ----------
# Standard decks of playing cards have 13 cards of each suit (diamonds, clubs, hearts, spades) for a total of 52 cards. 
# Someone gives you a 52 card deck. You draw a card, record its suit, replace the card, shuffle the deck and repeat that process 200 times, obtaining the following table
# 
# Diamonds    Clubs	Hearts	Spades
#     46	     54	     49	      51
# Does the distribution of suits appear to be standard?
# 
# We would fail to reject a chi-squared GOF test; we can not rule out that the deck is standard
# We would reject a chi-squared GOF test; we can rule out that the deck is standard
# We would reject a chi-squared GOF test; we can not rule out that the deck is standard
# We would fail to reject a chi-squared GOF test; we can rule out that the deck is standard

# H0 (Null hypothesis): the distribution of suits appear to be standard
# Ha: the distribution of suits is NOT standard

chi.square <- ((46-50)^2)/50 + ((54-50)^2)/50 + ((49-50)^2)/50 + ((51-50)^2)/50 
# [1] 0.68

pchisq(chi.square,1, lower.tail = FALSE)
# [1] 0.4095867

# since the value is bigger than 0.05 (95% confidence), we can't reject the null hypothesis, 
#   hence the distribution appears standard

#  "we can not rule out that the deck is standard" is true


# Question 8
# ----------
# Consider the table below comparing the self reported job stress levels of three occupations. 
# 100 people from each of three occupations were surveyed.
# 
# Job           High	Low
# Exec	        65	    35
# Prof	        70	    30
# Lion Tamer	15	    85

# Researchers are interested in whether or not the perception of job stress differs by occupation. 
# Using the relevant chi-sqared test. 
# What can be said about the researcher's hypothesis?
# 
# We reject; the stress levels do not appear to be different between jobs
# We fail to reject; the stress levels do appear to be different between jobs
# We reject; the stress levels appear to differ between jobs
# We fail to reject; the stress levels do not appear to be different between jobs

dat <- matrix(c( 65,35,70,30,15,85), nrow = 3, byrow = TRUE)

chisq.test(dat)

# Pearson's Chi-squared test
# 
# data:  dat
# X-squared = 74, df = 2, p-value < 2.2e-16

# We reject; the stress levels appear to differ between jobs