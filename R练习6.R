library(readxl)
Dat<- read_excel("C:/Users/Administrator.SC-201809091908/Documents/MacEcoData.xlsx")
dat.log<-log(Dat)
names(Dat)
model.lm<-lm(M2~.,data = dat.log)
class(model.lm)
print(model.lm)
summary(model.lm)
kappa(dat.log)
par(mfrow=c(2,2))
plot(model.lm)
par(mfrow=c(1,1))
names(model.lm)
coefs.lm<-model.lm$coefficients
coefs.lm
fit.lm<-model.lm$fitted.values
fit.lm
res.lm<-model.lm$residuals
res.lm
mode(summary(model.lm))
names(summary(model.lm))
(R2<-summary(model.lm)$r.squared)
(sigma<-summary(model.lm)$sigma)
tt<-1:5
CPI.hat<-Dat$CPI[nrow(Dat)]*1.05^tt
ir.hat<-Dat$ir[nrow(Dat)]*1.00^tt
GY.hat<-Dat$ir[nrow(Dat)]*1.05^tt
NewData<-data.frame(CPI=CPI.hat,ir=ir.hat,GY=GY.hat)
M2.hat<-predict(model.lm,newdata = log(NewData),interval='prediction')
matplot(M2.hat,lty=c(1,2,2),xlab='ʱ??',ylab='M2??Ԥ??ֵ')

##
states <- as.data.frame(state.x77[,c("Murder", "Population",
                                     "Illiteracy", "Income", "Frost")])
cor(states)
library(car)
scatterplotMatrix(states, spread=FALSE, smoother.args=list(lty=2),
                  main="Scatter Plot Matrix")
fit <- lm(Murder ~ Population + Illiteracy + Income + Frost,
          data=states)
summary(fit)

##
w<- lm(weight ~ height+I(height^2), data=women)
summary(w)
women$weight
fitted(w)
residuals(w)
plot(women$height,women$weight,
     xlab="Height (in inches)",
     ylab="Weight (in pounds)")
lines(women$height,fitted(w))
##??????W=261.88-7.35xHeight+0.083xHeight^2


