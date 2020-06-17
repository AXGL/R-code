install.packages('AER')
library(AER)
library(ggplot2)
data("Affairs")
summary(Affairs)
table(Affairs$affairs)
boxplot(Affairs$age,main="出轨年龄分布")
##(出轨还是30多岁的中年人多啊)
Affairs$ynaffair[Affairs$affairs>5]<-1
Affairs$ynaffair[Affairs$affairs<=5]<-0
Affairs$ynaffair<-factor(Affairs$ynaffair,levels = c(0,1),labels =c("时间管理不合格的人","时间管理专家"))
table(Affairs$ynaffair)
fit.full<-glm(ynaffair~gender+age+yearsmarried+children+religiousness+education+occupation+rating,
               data=Affairs,family=binomial())
summary(fit.full)
##(这里从P值可以看到gender，age,childrenyes,education，occupation都不太显著，那去掉试试)
fit.reduced<-glm(ynaffair~yearsmarried+religiousness+rating,data=Affairs,family = binomial())
summary(fit.reduced)
##(好了这样剩下的三个变量P值都比较显著了)
anova(fit.reduced,fit.full,test ="Chisq")
#(卡方分析，最后P=0.318不显著，那就是前后模型拟合效果并没有太大差距)
coef(fit.reduced)
exp(coef(fit.reduced))
#（yearsmarried越高，religiousness和rating越低，affairs就越多！值得深思,果然还是在一起久了就不香了)
  #(Y=1.036935x1+0.618179x2+0.6059446x3)
testdata<-data.frame(rating=c(1,2,3,4,5),age=mean(Affairs$age),
                     yearsmarried=mean(Affairs$yearsmarried),
                     religiousness=mean(Affairs$religiousness))
testdata
testdata$prob<-predict(fit.reduced,newdata = testdata,type = "response")
testdata
#既然上面已经得到出轨的分布情况了，那就要检验一下家里出现隔壁老王的可能性了,婚姻评价越高越不容易出轨
testdata<-data.frame(rating=mean(Affairs$rating),age=seq(17,57,10),
                     yearsmarried=mean(Affairs$yearsmarried),
                     religiousness=mean(Affairs$religiousness))
testdata
testdata$prob<-predict(fit.reduced,newdata = testdata,type = "response")
testdata
#看来无法用年龄区分时间管理专家和寂寞空虚的人
testdata<-data.frame(rating=mean(Affairs$rating),age=mean(Affairs$age),
                     yearsmarried=seq(0,30,5),
                     religiousness=mean(Affairs$religiousness))
testdata$prob<-predict(fit.reduced,newdata = testdata,type = "response")
testdata                    
#婚龄越大，越容易出轨
testdata <- data.frame(rating=c(3, 5), age=c(30,20),
                       yearsmarried=c(5,0),
                       religiousness=c(0,5))
testdata
testdata$prob <- predict(fit.reduced, newdata=testdata, type="response")
testdata
#论一个漂亮的女大学毕业生和一个宗教信仰老头结婚的出轨预测，果然，年轻没有宗教信仰婚姻评价低的容易出轨，以后找对象注意了

