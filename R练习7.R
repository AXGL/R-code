##MicEcodata?𲽷???
library(readxl)
dat <- read_excel("MacEcoData.xlsx")
names(dat)<-c('y',paste('x',1:7,sep = ''))
model.lm<-lm(y~.,data=dat)
summary(model.lm)
model.step<-step(model.lm)
summary(model.step)
# 3. do regression step by step, based on AIC
model.step <- step(model.lm)
summary(model.step)

#?Ƚ?ģ??AICֵ
fit1 <- lm(y~x1+x4+x5+x6+x7, data=dat)
fit2 <- lm(y~., data=dat)
AIC(fit1, fit2)
# full subset selection 
install.packages('leaps')
library(leaps)
subset.sel <- regsubsets(y~., data=dat, nbest=3)
subset.stat <- summary(subset.sel)
par(mfrow=c(2,2))
plot(subset.sel, scale="adjr2")
plot(subset.sel, scale="bic")
plot(subset.sel, scale="Cp")
cor(dat) 

##2.state.x77?Ļع?????
state.x77
states<-as.data.frame(state.x77[,c("Murder","Population","Illiteracy","Income","Frost")])
model.lm<-lm(Murder~Population+Illiteracy+Income+Frost,data=states)
class(model.lm)
print(model.lm)
summary(model.lm)
par(mfrow=c(2,2))
plot(model.lm)
library(car)
durbinWatsonTest(model.lm)#??????��??

ncvTest(model.lm)#????ͬ??????
spreadLevelPlot(model.lm)#????????????
crPlots(model.lm)#?ɷֲв?ͼ
par(mfrow=c(1,1))
influencePlot(model.lm,main="influence plot",sub="Circle size is proportional to Cook's distance")

dat.log<-log(states)
dat.log
kappa(dat.log)  #?ǰ???????ֵ?ԭ????Error in qr.default(if (d[1L] < d[2L]) t(z) else z) : ???Ӻ???????ʱ??????NA/NaN/Inf(arg1)
write.csv(states,file="D://states.csv")
#???????ع?????
install.packages('DAGG') ##package ??DAGG?? is not available (for R version 3.6.2)!
vif(model.lm)#?????취
sqrt(vif(model.lm)) > 2 # problem?


mode(model.lm)
names(model.lm)
coef_lm<-model.lm$coefficients
fit_lm<-model.lm$fitted.values
res_lm<-model.lm$residuals

mode(summary(model.lm))
names(summary(model.lm))
summary(model.lm)$r.squared
summary(model.lm)$adj.r.squared


#?𲽷???
model.step <- step(model.lm)
summary(model.step)
#?Ƚ?ģ??AICֵ
model.lm1<- lm(Murder ~ Population + Illiteracy + Income + Frost,
           data=states)
model.lm2<- lm(Murder ~ Population + Illiteracy, data=states)
AIC(model.lm1,model.lm2)
