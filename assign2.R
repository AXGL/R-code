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
#��������ǿ��Խ���һ��ģ�͵Ĳ���
##�ȿ����ع�ϵ��
coef(log_mol)
##��Logistic�ع��У���Ӧ������Y=1�Ķ������Ʊȣ�log�����ع�ϵ���ĺ����ǵ�����Ԥ�����
#����ʱ��һ��λԤ������ı仯���������Ӧ�����������Ʊȵı仯����Logistic�ع��������Ҫ�Խ��ָ����

exp(coef(log_mol))

#������Ľ�����ǿ��Կ��������ũҵ�������˲��������1%�������ʵ����ƱȽ������0.91���෴��Catholic��Infant����1%�������ʵĵ����ƱȽ������1.02��1.34.
#��ô�������Զ��׼����ˣ��������Բ���ũҵ�ı������ӣ��ھ�У�����е÷ָߵ���Խ�࣬����ˮƽ����ߣ�������������ʵĽ��͡��෴��
#�ŷ������̵���Խ�ࡢӤ�׶�������Խ�ߣ�������Ҳ��Խ�ߡ�

#������Ȼ��Ԥ�����ϵ��δͨ�������Լ��飬���ǳ��԰������Բ��õ�Ԥ�����ȥ���������µ�ģ��
log_mol2<-glm(y~Agriculture+Examination,data = swiss,family = binomial)
summary(log_mol2)

##ͨ��AICֵ������ģ���Ŷ�
AIC(log_mol,log_mol2)
#���ǿ��Է��֣�ģ��1��AICֵ���ͣ��Ŷȸ���

#������ʹ���𲽻ع���������ģ��
log_mol3<-step(log_mol)
summary(log_mol3)
#���Կ����𲽻ع�����ģ����Ȼ��ģ��1���������ǿ����жϣ�����ģ��Ϊģ��1




#2���˿�����
library(readxl)
library(ggpubr)
library(ggplot2)
data<- read_excel("customer_analysis.xlsx")
knitr::kable(head(data))
summary(data)
#����ͳ��
data$Gender<-ifelse(data$Gender== "M", 1, 0)#���Ա����1��Ů�Ա���Ϊ0
data$Stay_In_Current_City_Years<-gsub("\\+","",data$Stay_In_Current_City_Years)#ȥ���Ӻ�
data$City_Category<-ifelse(data$City_Category=="A",1,
                           ifelse(data$City_Category=="B",2,3))#��A���б����1��B���б����2��C���б����3
data$Age<-ifelse(data$Age=="0-17",1,#ͬ��������ֳ�1-7���ȼ�
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
  scale_x_continuous(breaks = c(1,2,3,4,5,6,7),#����������̶�
                     labels = c("0-17","18-25","26-35","36-45","46-50","51-55","55+")) +
                     labs(title ="The age interval of the customer belongs to") + #���ñ���
                     theme(panel.grid.major = element_blank(),#
                           plot.title = element_text(hjust = 0.45,size = 10),#���ñ����С��λ��
                             panel.grid.minor = element_blank(),#ȥ��������
                             panel.background = element_blank(),#ȥ������
                             axis.text.x = element_text(size = 7))#�ı�̶����ִ�С

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

##  ��Ů����������
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
  


## ABC����֮�������
p9<-ggplot(data, aes(x=factor(City_Category), y=Purchase)) + 
  geom_boxplot(fill="orange")+
  scale_x_discrete(breaks = c(1,2,3),
                     labels = c("A","B","C"))+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Differences in consumption between cities")+xlab("City")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)


##�����֮�����
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


##���ж���ʱ����ɵĲ���
p11<-ggplot(data, aes(x=factor(Stay_In_Current_City_Years), y=Purchase)) + 
  geom_boxplot(fill="#F0E442")+
  theme(panel.grid.minor = element_blank(),
        plot.title = element_text(hjust = 0.45,size = 10),
        panel.background = element_blank())+
  labs(title ="Consumption difference of different ages")+xlab("Stay time")+
  stat_summary(fun = "mean",geom = "point",fill="white",shape=23,size=3)


##�������ǲ������Ĳ���
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



#��ģ����
#�������ڷ���������ֱ������������ʾ�����׼ˮƽΪC����
data$City_Categor_A<-ifelse(data$City_Category==1,1,0)
data$City_Categor_B<-ifelse(data$City_Category==2,1,0)
summary(data)
#ͬ��������Ҳ��ΪС�д������ȼ��������������ʾ����׼ˮƽΪ50�����ϵ���Ⱥ
data$Age1<-ifelse(data$Age<=2,1,0)
data$Age2<-ifelse(data$Age>2&data$Age<=5,1,0)

lm<-lm(Purchase~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status,data)
summary(lm)


#��Ԥ�������ֹһ��ʱ���ع�ϵ���ĺ���Ϊ��һ��Ԥ���������һ����λ������Ԥ�������
#�ֲ���ʱ���������Ҫ���ӵ����������籾����,gender�Ļع�ϵ��Ϊ25073����ΪgenderΪ0-1���Ա��������Իع�ģ��ϵ�����Խ�һ������Ϊ�Ա���ȡ���ࡰ1��ʱ���������ֵƽ�����Ա���ȡ���ࡰ0��ʱ�߶��١������Ա���gender��Ӧ��ϵ��Ϊ25073��˵�������ձ��Ů�Զ໨25073Ԫ
##


#���ģ��
confint(lm)
##������ϣ�������������е�ʱ��ı�1%�����Ѿ���95%����������[-5727.798, 2236.937]�б仯
##��׼����
par(mfrow=c(2,2))
plot(lm)
#������̬Q-Qͼû������45��ֱ���ϣ�˵��Υ����̬�Եļ��裬������ǲ�ȡ��y��������������һ��
lm<-lm(log(Purchase)~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status,data)
par(mfrow=c(2,2))
plot(lm)
##���Կ�������ģ���Ѿ�����������̬����


#ģ��ѡ���Ԥ��
##�����Ƿ�������������Ķ�Ԫ���Իع�
###����������Ϊ����Gender��Marital_Status�й�ϵ,�Ұ������Ա����ĳ˻���Ϊ�±�������ģ�ͣ�����AICԭ���ģ�ͽ��б���ѡ��
lm1<-lm(log(Purchase)~Gender+Age1+Age2+City_Categor_A+City_Categor_B+Stay_In_Current_City_Years+Marital_Status+Gender*Marital_Status,data)
lm<-step(lm1)
lm2<-lm(log(Purchase)~Gender + Age1 + Age2 + City_Categor_A + City_Categor_B,data)
summary(lm2)
AIC(lm1,lm2)
#���Կ���ģ��2����
###��һ������ģ�Ͳ�ͬ����������ģ�͵�ϵ������������ǡ������ʡ����ڿ��������Ա�������������£�ĳ���Ա���ÿ�仯1����λ���������������,
###���磬���Ա�Ů���������϶���0.36���ٷֱ�

#ģ��Ԥ��

#Ԥ��1
#�����Ա��У�����20�꣬ס��A�У���ô��������ˮƽ��Σ�
Gender<-1
Age1<-1
Age2<-0
City_Categor_A<-1
City_Categor_B<-0
newdata1<-cbind.data.frame(Gender,Age1,Age2,City_Categor_A,City_Categor_B)
newdata1
exp(predict(lm,newdata1))
##����Ԥ������Ϊ67785.54


##Ԥ��2
#����һ��Ů�ԣ�����40�꣬ס��B�У�����ˮƽ���
Gender<-0
Age1<-0
Age2<-1
City_Categor_A<-0
City_Categor_B<-1
newdata2<-cbind.data.frame(Gender,Age1,Age2,City_Categor_A,City_Categor_B)
newdata2
exp(predict(lm,newdata2))


#����һЩ�뷨
data<- read_excel("customer_analysis.xlsx")
lm<-lm(Purchase~Gender+Age+City_Category+Stay_In_Current_City_Years+Marital_Status,data)
summary(lm)