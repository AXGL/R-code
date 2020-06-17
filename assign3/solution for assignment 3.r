
######################################################################################
#assignment 3
#question 1

#define a loss function
setwd("D:/R/R-exercise/markdown-template")
f_exp <- function(r, p, Cs, Cp){
  n <- length(Cs)
  tt <- 1:n
  loss <- p - sum(Cs/((1+r)^tt)) - Cp/(1+r)^n
  loss
}


Cs <- rep(100*0.0268/2, 20)
Cp <- 100
p <- 100
(res <- uniroot(f_exp, c(0,1), p=p, Cs=Cs, Cp=Cp) )         # find the semianual YTM
semi.ytm <- res$root
(annual.ytm <- 2*semi.ytm )



#############

# (1) define duration function
jq <- function(y,cupon,period,p0){
  c2<-0
  tc2<-0
  for(n in 1:period){
    t=n
    if(n<period) c<-cupon else if(n==period) c<-cupon+p0
    c1=c/(1+y)^n
    tc1<-t*c1
    c2<-c2+c1
    tc2<-tc2+tc1
    if(n==period) {
      d<-tc2/(c2*2)            # duration
      md<-d/(1+y)              # adjusted duration
    }
  }
  list(d=d,md=md)
}

# (2) do calculation
(jq.res<-jq(0.0268/2,100*0.0268/2,20,100))


# 5. calculate convexity
# (1) define a function
td <- function(y, cupon, period, p0){
  c2<-0
  tc2<-0
  for(n in 1:period){
    t=n
    if(n<period) c<-cupon else if(n==period) c<-cupon+p0
    c1=c/(1+y)^n
    tc1<-t*(t+1)*c1
    c2<-c2+c1
    tc2<-tc2+tc1
    if(n==period){
      covex<-tc2/(c2*((1+y)^2))
      yearlycovex<-covex/4
    }
  }
  list(covex=covex,yearlycovex=yearlycovex)
}

# (2) do calculation
(td.res <- td(0.0268/2,100*0.0268/2,20,100))

# (3) calculate the impact of convexity
delta.r <- -0.005
(effects <- 0.5*td.res$yearlycovex*delta.r^2)



######################################################################################
#question 2


library(readxl)
library(xts)
library(forecast)
library(dplyr)
library(tseries)

#import the data

stock.data <- read_excel("IDX_Idxtrd1.xlsx",1)%>%as.data.frame()
str(stock.data)
SSEC <- subset(stock.data, Indexcd =="000001",c("Idxtrd01","Idxtrd05","Idxtrd08"))
head(SSEC)
str(SSEC)
SSEC$date <- as.Date(SSEC[,1])
SSEC$close <- as.numeric(as.character(SSEC[,2]))
SSEC$return <- as.numeric(as.character(SSEC[,3]))
SSEC.data <- zoo(cbind(SSEC$close,SSEC$return), SSEC$date)
names(SSEC.data) <- c("close", "return")
head(SSEC.data)
plot(SSEC.data$return)



SSEC.data <- xts(cbind(SSEC$close,SSEC$return), SSEC$date)
names(SSEC.data) <- c("close", "return")
head(SSEC.data)
plot(SSEC.data$return)
summary(SSEC.data)

#analyze return data of SSEC

adf.test(SSEC.data$return)
par(mfrow=c(2,1))
acf(SSEC.data$return)
pacf(SSEC.data$return)
auto.arima(SSEC.data$return)
Box.test(SSEC.data$return, lag=10)
par(mfrow=c(1,1))
qqnorm(SSEC.data$return)
qqline(SSEC.data$return)


#analyze close data of SSEC

adf.test(SSEC.data$close)
par(mfrow=c(2,1))
acf(SSEC.data$close)
pacf(SSEC.data$close)
auto.arima(SSEC.data$close)
Box.test(SSEC.data$close, lag=10)

#analyze differentiated close data of SSEC

SSEC.close.d1 <- diff(SSEC.data$close)[-1]
adf.test(SSEC.close.d1)
par(mfrow=c(2,1))
acf(SSEC.close.d1)
pacf(SSEC.close.d1)
auto.arima(SSEC.close.d1)
Box.test(SSEC.close.d1, lag=10)


#analyze the return of weekly close data of SSEC

SSEC.wd <- to.weekly(SSEC.data$close, OHLC=FALSE)
head(SSEC.wd)
SSEC.wd$return <- diff(log(SSEC.wd))
SSEC.wd <- SSEC.wd[-1]
plot(SSEC.wd$return)
summary(SSEC.wd) 
adf.test(SSEC.wd$return)
par(mfrow=c(2,1))
acf(SSEC.wd$return)
pacf(SSEC.wd$return)
auto.arima(SSEC.wd$return)
Box.test(SSEC.wd$return, lag=10)





