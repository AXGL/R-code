setwd("D:/R/R-exercise/real_regression_case")

library(readxl)
library(ggplot2)
library(jiebaR)


#options(scipen = 200)
jobinfo = read_excel("jobinfo(1).xlsx")
str(jobinfo)
head(jobinfo)


## (1) �����������ƽ��н�ʵı��� ##

jobinfo$���н�� = as.numeric(jobinfo$���н��)
jobinfo$���н�� = as.numeric(jobinfo$���н��)
jobinfo$ƽ��н�� = (jobinfo$���н�� + jobinfo$���н��)/2




## (2) ����disctrict�������������»���Ϊ������ͷǱ���������ˮƽ ##
loc = which(jobinfo$���� %in% c("����", "�Ϻ�", "����"))
loc_other = which(!jobinfo$���� %in% c("����", "�Ϻ�", "����")) # %in%����ʲô�ڣ�
jobinfo$����[loc] = 1
jobinfo$����[loc_other] = 0
jobinfo$���� = as.numeric(jobinfo$����)


## (3) ����˾��ģת��Ϊ�����ͱ��������ڻ�ͼ ##
jobinfo$��˾��ģ = factor(jobinfo$��˾��ģ, levels = c("����50��", "50-150��", "150-500��", "500-1000��", "1000-5000��", "5000-10000��", "10000������"))
levels(jobinfo$��˾��ģ)[c(2, 3)] = c("50-500��", "50-500��")
# ��50-150�˺�150-500�˺ϲ�Ϊһ��ˮƽ��50-500��



## (4) ��ѧ��ת��Ϊ�����ͱ��������ڻ�ͼ ##
jobinfo$ѧ�� = factor(jobinfo$ѧ��, levels = c("��ר", "����", "��ר", "��", "����", "˶ʿ", "��ʿ"))

## (5) ƥ�������˾Ҫ���ͳ����� ##
# ���Ƚ���software���ݿ����ڴ�Ÿ�����˾�����ƥ����
software = as.data.frame(matrix(0, nrow = length(jobinfo$����), ncol = 12))  # �Ƚ���һ��0��������Ϊ�۲���������Ϊͳ������ĸ�������ת��Ϊdata frame��ʽ
colnames(software) = c("R", "SPSS", "Excel", "Python", "MATLAB", "Java", "SQL", "SAS", "Stata", "EViews", "Spark", "Hadoop")  # ��software��data frame��������Ϊ�������

 mixseg = worker()  # ����ȱʡֵ�����÷ִ�����

# ��ÿ�������۲���зִʣ����洢��software���棬ѭ������Ϊ�ܹ۲������ܹ۲�����ͨ��length(jobinfo$����)��ȡ
for (j in 1:length(jobinfo$����)){
  
  subdata = as.character(jobinfo$����[j])  # ȡ��ÿ���۲⣬������subdata����
  fenci = mixseg[subdata]  # ��ȡ���Ĺ۲���зִʣ������ڷִʱ���

# ���ø���������б���������RΪ����R.indentify��ʾr��R�Ƿ���fenci���������
  R.identify = ("R" %in% fenci) | ("r" %in% fenci)
  SPSS.identify = ("spss" %in% fenci) | ("Spss" %in% fenci) | ("SPSS" %in% fenci)
  Excel.identify = ("excel" %in% fenci) | ("EXCEL" %in% fenci) | ("Excel" %in% fenci)
  Python.identify = ("Python" %in% fenci) | ("python" %in% fenci) | ("PYTHON" %in% fenci)
  MATLAB.identify = ("matlab" %in% fenci) | ("Matlab" %in% fenci) | ("MATLAB" %in% fenci)
  Java.identify = ("java" %in% fenci) | ("JAVA" %in% fenci) | ("Java" %in% fenci)
  SQL.identify = ("SQL" %in% fenci) | ("Sql" %in% fenci) | ("sql" %in% fenci)
  SAS.identify = ("SAS" %in% fenci) | ("Sas" %in% fenci) | ("sas" %in% fenci)
  Stata.identify = ("STATA" %in% fenci) | ("Stata" %in% fenci) | ("stata" %in% fenci)
  EViews.identify = ("EViews" %in% fenci) | ("EVIEWS" %in% fenci) | ("Eviews" %in% fenci) | ("eviews" %in% fenci) 
  Spark.identify = ("Spark" %in% fenci) | ("SPARK" %in% fenci) | ("spark" %in% fenci)
  Hadoop.identify = ("HADOOP" %in% fenci) | ("Hadoop" %in% fenci) | ("hadoop" %in% fenci)
  
# �жϸ����������������Ƿ���ĳ���Ҫ����RΪ������j��������������R.identifyΪTRUEʱ��software�ĵ�j�е�R����Ϊ1����֮Ϊ0��
# 1��ʾ��Ҫ��0��ʾ��Ҫ��
  if (R.identify) software$R[j] = 1
  if (SPSS.identify) software$SPSS[j] = 1
  if (Excel.identify) software$Excel[j] = 1
  if (Python.identify) software$Python[j] = 1
  if (MATLAB.identify) software$MATLAB[j] = 1
  if (Java.identify) software$Java[j] = 1
  if (SQL.identify) software$SQL[j] = 1
  if (SAS.identify) software$SAS[j] = 1
  if (Stata.identify) software$Stata[j] = 1
  if (EViews.identify) software$EViews[j] = 1
  if (Spark.identify) software$Spark[j] = 1
  if (Hadoop.identify) software$Hadoop[j] = 1
}
# ��ƽ��н�ʺ�software���������ݿ�ϲ�
jobinfo.new = cbind(jobinfo$ƽ��н��, software)
colnames(jobinfo.new) = c("ƽ��н��", colnames(software))

## (6) ������Ҫ�ı��� ##
# ����
jobinfo.new$���� = jobinfo$����
# ��˾���
jobinfo.new$��˾��� = jobinfo$��˾���
# ��˾��ģ
jobinfo.new$��˾��ģ = jobinfo$��˾��ģ
# ѧ��
jobinfo.new$ѧ�� = jobinfo$ѧ��
# Ҫ����
jobinfo.new$����Ҫ�� = jobinfo$����
# ��ҵ���
jobinfo.new$��ҵ��� = jobinfo$��ҵ���

## (7) ����۲⣺��˾����У���Ӫ����������ҵ��λ������۲���٣�û�жԱȼ�ֵ������ɾ�� ##
table(jobinfo.new$��˾���)
##  
##    ��ҵ��˾ ��Ӫ������       ����       ����   ��Ӫ��˾   ���й�˾ 
##          90         20        291        762       4917        406 
##    ��ҵ��λ       ���� 
##          15        869
jobinfo.new = jobinfo.new[-which(jobinfo.new$��˾��� %in% c("��Ӫ������", "��ҵ��λ")), ]

## (8) �ظ����� ##
colnames(jobinfo.new) = c("aveSalary", colnames(jobinfo.new[2:13]), "area", "compVar", "compScale", "academic", "exp", "induCate")

## (9) ��������Ԥ��������ݼ� ##
write.csv(jobinfo.new, file = "���ݷ�����λ��Ƹ.csv", row.names = FALSE)


### 2.���ݼ���������ļ��� ###


# install.packages(plyr)
library(plyr)

dat0 = read.csv("���ݷ�����λ��Ƹ.csv", header = T)  # ������ϴ���������
dat0 = na.omit(dat0)
n = dim(dat0)[1]  # n��������
summary(dat0)  # �鿴����


### 3.���������Է��� ###
## (1) �����ֱ��ͼ ##
hist(dat0$aveSalary, xlab = "ƽ��н�ʣ�Ԫ/�£�", ylab = "Ƶ��", main = "", col = "dodgerblue", xlim = c(1500, 11000),
     breaks = seq(0, 500000, by = 1500))


summary(dat0$aveSalary)
##     Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##     1500    5250    7000    8980   12000   50000

## (2) ƽ��н�� ~ ����Ҫ�� ##
dat0$exp_level = cut(dat0$exp, breaks = c(-0.01, 3.99, 6, max(dat0$exp)))
dat0$exp_level = factor(dat0$exp_level,levels = levels(dat0$exp_level), labels = c("���飺0-3��", "���飺4-6��", "���飺>6��"))

# Ϊ��ͼ�۲����ƣ���ʱ�����±���������������Ҫ�󻮷�Ϊ(-0.01, 3.99], (3.99, 6], >6��������������Ҫ��0~3, 4~6, 6~10 ��������
boxplot(aveSalary ~ exp_level, data = dat0, col = "dodgerblue", ylab = "ƽ��н�ʣ�Ԫ/�£�", ylim = c(0, 45000))


summary(lm(aveSalary ~ exp_level, data = dat0))


dat0 = dat0[, -which(colnames(dat0) == "exp_level")]  # ɾȥ��ʱ��exp_level����

## (3) ƽ��н�� ~ ѧ�� ##
summary(lm(aveSalary ~ academic, data = dat0))  # Ĭ�ϻ�׼��Ϊ�����ơ�

dat0$academic = factor(dat0$academic, levels = c("��", "��ר", "����", "��ר", "����", "˶ʿ", "��ʿ"))  
dat0$compVar = factor(dat0$compVar, levels = c("��Ӫ��˾", "��ҵ��˾", "����", "����", "���й�˾", "����"))
# �ı�ˮƽ˳�򣬻�׼����Ϊ���ޡ�������Ӫ��˾��
boxplot(aveSalary ~ academic, data = dat0, col = "dodgerblue", ylab = "ƽ��н�ʣ�Ԫ/�£�", ylim = c(0, 45000))


summary(lm(aveSalary ~ academic, data = dat0))


### 4.����ֱ�ӽ����ع�ģ�� ###

names(data0)
dat0 = dat0[,-which(colnames(dat0) == "induCate")] 
lm1 = lm(aveSalary ~., data = dat0)
summary(lm1)  # �ع���չʾ


### 5.�ع���ϼ����� ###


par(mfrow = c(2, 2))  # ��2*2��ͼ
plot(lm1, which = c(1:4))  # ģ�����ͼ�����ڷ���̬���쳣�������Ƚ������̬�ԣ��������ȡ����


library(car)
vif(lm1)  # ����VIF��>5�������Խϴ󣨶������Ա����ع��R^2>80%��


# ��������ģ�ͣ�ȥ������̬Ӱ�죩 ##
lm2 = lm(log(aveSalary) ~., data = dat0)
summary(lm2)  # �ع���չʾ



par(mfrow = c(2, 2))  # ��2*2��ͼ
plot(lm2, which = c(1:4))  # ģ�����ͼ


# ɾ������쳣�㣬�������ģ����Ϲ���
 cook = cooks.distance(lm2)
 cook = sort(cook, decreasing = T)
 cook_point = names(cook)[1]
 cook_delete = which(rownames(dat0) %in% cook_point)
 dat0 = dat0[-cook_delete, ]

# ���
 lm3 = lm(log(aveSalary) ~., data = dat0)
 par(mfrow = c(2, 2))   #��2*2��ͼ
 plot(lm3, which = c(1:4))   #ģ�����ͼ


### 6.����ģ�ͽ��ͼ�Ԥ�� ###

## (1) ����ģ�ͣ��н�����Ķ�������ģ�� ##
lm4=lm(log(aveSalary)~. + compScale*area,data=dat0)  # �����빫˾��ģ֮��Ľ�������
summary(step(lm4))  # ����ѡ��step AIC


## (2) Ԥ�� ##
# Ԥ��1������r��python�����Ʊ�ҵ���޹������飬��˾λ���Ϻ�����ģ87�ˣ����й�˾

# ����һ����Ϊnew.data1��data frame
new.data1 = matrix(c(1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, "���й�˾", "50-500��", "����", 0), 1, 17) 
new.data1 = as.data.frame(new.data1)
colnames(new.data1) = names(dat0)[-1]  # ��data frame����
for(i in 1:13){
  new.data1[, i] = as.numeric(as.character(new.data1[, i]))
}
new.data1$exp = as.numeric(as.character(new.data1$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data1))  # Ԥ��ֵ


# Ԥ��2������r��java��sas��python����ʿ��ҵ��7�깤�����飬��˾λ�ڱ�������С�͹�˾����ģ150-500�ˣ�����ҵ��˾

# ����һ����Ϊnew.data2��data frame
new.data2 = matrix(c(1, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 1, "���й�˾", "50-500��", "��ʿ", 7), 1, 17)
new.data2 = as.data.frame(new.data2)
colnames(new.data2) = names(dat0)[-1]  # ��data frame����
for(i in 1:13){
  new.data2[, i] = as.numeric(as.character(new.data2[, i]))
}
new.data2$exp = as.numeric(as.character(new.data2$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data2))  # Ԥ��ֵ


# Ԥ��3��û��ѧ����΢���Ĺ��������顢�����κ�ͳ�����

# ����һ����Ϊnew.data3��data frame
new.data3 = matrix(c(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, "����", "����50��", "��", 0), 1, 17)
new.data3 = as.data.frame(new.data3)
colnames(new.data3) = names(dat0)[-1]  #��data frame����
for(i in 1:13){
  new.data3[, i] = as.numeric(as.character(new.data3[, i]))
}
new.data3$exp = as.numeric(as.character(new.data3$exp))  # ��factor���͸�Ϊ��ֵ��
exp(predict(lm4, new.data3))  # Ԥ��ֵ






