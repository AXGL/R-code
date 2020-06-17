library(tidyverse)
knitr::kable(swiss)
a<-mean(swiss$Fertility)
swiss$y[swiss$Fertility>a]<-1
swiss$y[swiss$Fertility<=a]<-0
swiss$y<-factor(swiss$y,
                 levels=c(0,1),
                 labels=c("No","Yes"))
table(swiss$y)

log_mol<-glm(y~Agriculture+Examination+Education+Catholic+Infant.Mortality,
             data = swiss,family = binomial())
summary(log_mol)
#在这里，我们可以解释一下模型的参数
##先看看回归系数
coef(log_mol)
##在Logistic回归中，响应变量是Y=1的对数优势比（log）。回归系数的含义是当其他预测变量
#不变时，一单位预测变量的变化可引起的响应变量对数优势比的变化。在Logistic回归里，我们需要对结果指数化

exp(coef(log_mol))

#从下面的结果我们可以看到，如果农业里面男人参与度增加1%，生育率的优势比将会乘以0.91。相反，Catholic和Infant增加1%，生育率的的优势比将会乘上1.02和1.34.
#那么结论是显而易见的了，随着男性参与农业的比例增加，在军校考试中得分高的人越多，教育水平的提高，都会带来生育率的降低。相反，
#信奉天主教的人越多、婴幼儿死亡率越高，生育率也就越高。

#上面仍然有预测变量系数未通过显著性检验，我们尝试把显著性不好的预测变量去掉，构建新的模型
log_mol2<-glm(y~Agriculture+Examination,data = swiss,family = binomial)
summary(log_mol2)

##通过AIC值来检验模型优度
AIC(log_mol,log_mol2)
#我们可以发现，模型1的AIC值更低，优度更好

#我们再使用逐步回归来获得最佳模型
log_mol3<-step(log_mol)
summary(log_mol3)
#可以看到逐步回归后最佳模型仍然是模型1，所以我们可以判断，最优模型为模型1




#2、顾客消费
library(readxl)
library(ggpubr)
library(ggplot2)
data<- read_excel("customer_analysis.xlsx")
knitr::kable(head(data))
summary(data)
#描述统计
data$Gender<-ifelse(data$Gender== "M", 1, 0)#男性编码成1，女性编码为0
data$Stay_In_Current_City_Years<-gsub("\\+","",data$Stay_In_Current_City_Years)#去掉加号
data$City_Category<-ifelse(data$City_Category=="A",1,
                           ifelse(data$City_Category=="B",2,3))#把A城市编码成1，B城市编码成2，C城市编码成3
data$Age<-ifelse(data$Age=="0-17",1,#同理，年龄分成1-7个等级
                 ifelse(data$Age=="18-25",2,
                        ifelse(data$Age=="26-35",3,
                               ifelse(data$Age=="36-45",4,
                                      ifelse(data$Age=="46-50",5,
                                             ifelse(data$Age=="51-55",6,7))))))
summary(data)
data<-as.data.frame(data)
data$Stay_In_Current_City_Years<-as.numeric(data$Stay_In_Current_City_Years)
data$Gender<-as.numeric(data$Gender)
data$Age<-as.numeric(data$Age)
data$City_Category<-as.numeric(data$City_Category)    
data$Marital_Status<-as.numeric(data$Marital_Status)
data$Purchase<-as.numeric(data$Purchase)
class(data)


p <- ggplot(data,aes(x=Age))
p1<-p + geom_bar(fill= "steelblue")+
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7),#设置坐标轴刻度
                     labels = c("0-17","18-25","26-35","36-45","46-50","51-55","55+")) +
                     labs(title ="The age interval of the customer belongs to") + #设置标题
                     theme(panel.grid.major = element_blank(),#
                           plot.title = element_text(hjust = 0.45,size = 10),#设置标题大小和位置
                             panel.grid.minor = element_blank(),#去掉网格线
                             panel.background = element_blank(),#去掉背景
                             axis.text.x = element_text(size = 7))#改变刻度文字大小

p2<-ggplot(data,aes(x= Gender))+
  geom_bar(fill="#E69F00")+
  scale_x_continuous(breaks = c(1,0),
                     labels = c("male","female"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="The gender of the customer")

p3<-ggplot(data,aes(x= City_Category))+
  geom_bar(fill="#009E73")+
  scale_x_continuous(breaks = c(1,2,3),
                     labels = c("A","B","C"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="The category of the city where the customer comes from")

p4<-ggplot(data,aes(x= Stay_In_Current_City_Years))+
  geom_bar(fill="#D55E00")+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="The length of years that the customer stays in the current city")


p5<-ggplot(data,aes(x= Marital_Status))+
  geom_bar(fill="black")+
  scale_x_continuous(breaks = c(0,1),
                     labels = c("single","married"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="The category of the city where the customer comes from")
  
p6<-ggplot(data, mapping = aes(x=Customer_ID, y = Purchase)) + 
    geom_point(colour="red")+
  scale_y_continuous(breaks = c(22517.25, 50987.00,103540.75,817592.00),
                     labels = c("2W","5W","10W","80W"))+
    theme(panel.grid.minor = element_blank(),
          plot.title = element_text(hjust = 0.45,size = 10),
          panel.background = element_blank())+
  labs(title ="The amount of dollars that the customer spent ")
p7<-ggpubr::ggarrange(p1, p2, p3, p4,p5,p6, nrow = 2, ncol = 3)  
p7

##  男女性消费区别
p8<-ggplot(data, aes(x=factor(Gender), y=Purchase)) + 
  geom_boxplot(fill="skyblue")+
  scale_x_discrete(breaks = c(0,1),
                    labels = c("FeMale","male"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Differences in consumption between Gender")+
  xlab("Gender")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)
  


## ABC三城之间的消费
p9<-ggplot(data, aes(x=factor(City_Category), y=Purchase)) + 
  geom_boxplot(fill="orange")+
  scale_x_discrete(breaks = c(1,2,3),
                     labels = c("A","B","C"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Differences in consumption between cities")+xlab("City")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)


##年龄段之间差异
p10<-ggplot(data, aes(x=factor(Age), y=Purchase)) + 
  geom_boxplot(fill="green")+
  scale_x_discrete(breaks = c(1,2,3,4,5,6,7),
                   labels = c("0-17","18-25","26-35","36-45","46-50","51-55","55+"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank(),
        axis.text.x = element_text(size = 7))+
  labs(title ="Consumption difference of different ages")+xlab("Age")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)


##城市逗留时间造成的差异
p11<-ggplot(data, aes(x=factor(Stay_In_Current_City_Years), y=Purchase)) + 
  geom_boxplot(fill="#F0E442")+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Consumption difference of different ages")+xlab("Stay time")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)


##单身还是不单身的差异
p12<-ggplot(data, aes(x=factor(Marital_Status), y=Purchase)) + 
  geom_boxplot(fill="#0072B2")+
  scale_x_discrete(breaks = c(0,1),
                   labels = c("single","married"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Differences between married and single")+xlab("married or single")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)

p13<-ggpubr::ggarrange(p8, p9, p10, p11,p12, nrow = 2, ncol = 3)  
p13



#建模分析
#城市属于分类变量，分别用虚拟变量表示，其基准水平为C城市
data$City_Categor_A<-ifelse(data$City_Category==1,1,0)
data$City_Categor_B<-ifelse(data$City_Category==2,1,0)
summary(data)
#同理，年龄也分为小中大三个等级，用虚拟变量表示，基准水平为50岁以上的人群
data$Age1<-ifelse(data$Age<=2,1,0)
data$Age2<-ifelse(data$Age>2&data$Age<=5,1,0)

lm<-lm(Purchase~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status,data)
summary(lm)


#当预测变量不止一个时，回归系数的含义为：一个预测变量增加一个单位，其他预测变量保
#持不变时，因变量将要增加的数量。例如本例中,gender的回归系数为25073，因为gender为0-1定性变量，线性回归模型系数可以进一步解释为自变量取分类“1”时，因变量的值平均比自变量取分类“0”时高多少。比如自变量gender对应的系数为25073，说明男性普遍比女性多花25073元
##


#诊断模型
confint(lm)
##结果如上，例如在这个城市的时间改变1%，消费就在95%的置信区间[-5727.798, 2236.937]中变化
##标准方法
par(mfrow=c(2,2))
plot(lm)
#左上正态Q-Q图没有落在45度直线上，说明违反正态性的假设，因此我们采取对y做对数再来复查一次
lm<-lm(log(Purchase)~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status,data)
par(mfrow=c(2,2))
plot(lm)
##可以看到现在模型已经基本符合正态性了


#模型选择和预测
##关于是否有显著交互项的多元线性回归
###在这里我认为可能Gender和Marital_Status有关系,我把两个自变量的乘积作为新变量引入模型，并用AIC原则对模型进行变量选择
lm1<-lm(log(Purchase)~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status+Gender*Marital_Status,data)
lm<-step(lm1)
lm2<-lm(log(Purchase)~Gender + Age1 + Age2 + City_Categor_A + City_Categor_B,data)
summary(lm2)
AIC(lm1,lm2)
#可以看到模型2更好
###与一般线性模型不同，对数线性模型的系数含义代表的是“增长率”：在控制其他自变量不变的条件下，某个自变量每变化1个单位，因变量的增长率,
###例如，男性比女性在消费上多了0.36个百分比

#模型预测

#预测1
#假设性别男，年龄20岁，住在A市，那么他的消费水平如何？
Gender<-1
Age1<-1
Age2<-0
City_Categor_A<-1
City_Categor_B<-0
newdata1<-cbind.data.frame(Gender,Age1,Age2,City_Categor_A,City_Categor_B)
newdata1
exp(predict(lm,newdata1))
##最后的预测消费为67785.54


##预测2
#假设一名女性，年龄40岁，住在B市，消费水平如何
Gender<-0
Age1<-0
Age2<-1
City_Categor_A<-0
City_Categor_B<-1
newdata2<-cbind.data.frame(Gender,Age1,Age2,City_Categor_A,City_Categor_B)
newdata2
exp(predict(lm,newdata2))


#补充一些想法
data<- read_excel("customer_analysis.xlsx")
lm<-lm(Purchase~Gender+Age+City_Category+Stay_In_Current_City_Years+Marital_Status,data)
summary(lm)
