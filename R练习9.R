data <- read.table('C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/BalanceSheet.txt',header=TRUE)
data2 <- read.csv('C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/BalanceSheet.csv')
data
data2
read.csv('C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/BalanceSheet.csv')
#获取苹果数据
library(quantmod)
getSymbols("AAPL",src="yahoo",from='2018-01-01',to='2019-12-30')
getSymbols("GOOG",src="yahoo",from='2018-01-01',to='2019-12-30')
#绘制K线
barChart(AAPL)
barChart(GOOG)
chartSeries(AAPL)
chartSeries(AAPL, up.col='red', dn.col='green',theme = "black" ,TA="addVo(); addMACD(); addSMA(n=10)")
candleChart(AAPL,multi.col=TRUE,theme="white")
#查看头尾部数据
head(AAPL)
tail(AAPL)
#时间序列数据预处理
install.packages("timeSeries")
install.packages('tseries')
library(timeSeries)
library( tseries)
library( RODBC)
library( quantmod)
stock.names<- c ('AAPL','GOOG')
getSymbols(stock.names,from='2018-01-01',to='2019-12-30')
start(AAPL)
end(AAPL)
class(AAPL)
dim(AAPL)
dim(GOOG)
assets<-merge.xts(AAPL,GOOG,all=FALSE)#merge.xts合并时间序列数据
cbind(AAPL,GOOG)#貌似和merge没区别
dim(assets)
#取子集
Cl(AAPL)
Op(AAPL)
AAPL['2018']
GOOG['2018-06::2019-01-30']
non.contiguous <- c('2018-01','2018-02','2018-12')
AAPL[non.contiguous]
GOOG[non.contiguous]
cbind(AAPL[non.contiguous],GOOG[non.contiguous])
#随机抽样
assets.ts <- as.timeSeries(assets)                 
class(assets.ts)
assets.samp <- sample(assets.ts, size=40)
dim(assets.samp)
print(assets.samp)
sort(assets.samp)#可以排序
#补齐缺失值
assets.ali <- align(assets.samp, by='1d', method='before', include.weekends=FALSE)
dim(assets.ali)
print(assets.ali)
#频率转换
assets.m <- to.monthly(assets)
print(assets.m)
to.weekly(assets)
to.yearly(assets)
#滚动预测  rollapply(data, width, FUN)
#其中data是输入序列， width指定滚动窗口的时间点数， FUN指定对滚动窗口的每一个位置的子集计算的函数
rollapply <- function(x, by, FUN, ...){
  ans <- applySeries(x, from=by$from, to=by$to, by=NULL, FUN=FUN, format=x@format,
                     zone=finCenter(x), FinCenter=finCenter(x), title=x@title, documentation=x@documentation, ...)
  attr(ans, 'by') <- data.frame(from=format(by$from), to=format(by$to))
  ans
}

rts <- diff(log(assets))
rts <- returns(assets, method='continuous', percentage=TRUE) #return percentage
rts <- as.timeSeries(na.omit(rts))
by <- periods(time(rts), period='1m', by='1d')
rts.roll <- rollapply(rts, by=by, FUN='colSums')
print(rts.roll)
barChart(rts.roll)
#截面数据预处理
library(readxl)
Data_Qvalue <- read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=1)
Data_Industry<-read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=2)
Data_Concent <-read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=3)
Data_Ownership <-read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=4)
Data_Finance <- read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=5)
Data_Banlance <-read_excel("C:/Users/Administrator.SC-201809091908/Desktop/R语言/CH-04/CH-04/FirmData.xlsx",sheet=6)
tail(Data_Industry)
tail(Data_Concent)
tail(Data_Ownership)
tail(Data_Finance)
tail(Data_Banlance)
tail(Data_Qvalue )
str(Data_Qvalue )
#改个编号
firmName <- function(name){
  name.rev <- paste('000000', as.character(name), sep='')
  name.rev <- substr(name.rev, start=nchar(name.rev)-5, stop=nchar(name.rev))
  name.c <- paste('c', name.rev, sep='')
  name.c
}

Data_Qvalue$Comcd <- firmName(Data_Qvalue$Stkcd)
Data_Industry$Comcd <- firmName(Data_Industry$Stkcd)
Data_Concent$Comcd <- firmName(Data_Concent$Stkcd)
Data_Ownership$Comcd <- firmName(Data_Ownership$Stkcd)
Data_Finance$Comcd <- firmName(Data_Finance$Stkcd)
Data_Banlance$Comcd <- firmName(Data_Banlance$Stkcd)
Data_Qvalue$Comcd
#删除金融行业，保留非金融
Data_Industry <- Data_Industry[!is.na(Data_Industry$Indcd),]
NonfinComcd <-as.character(levels(factor(Data_Industry[Data_Industry$Indcd != 1, 'Comcd'])))
NonfinComcd<-Data_Industry[Data_Industry$Indcd != 1, 'Comcd']
NonfinComcd<-as.matrix(NonfinComcd)
view(NonfinComcd)
as.vector(NonfinComcd)
Qvalue.Nonfin <- Data_Qvalue[(Data_Qvalue$Comcd %in% NonfinComcd),]
Industry.Nonfin <- Data_Industry[(Data_Industry$Comcd %in% NonfinComcd), ]
Concent.Nonfin <- Data_Concent[(Data_Concent$Comcd %in% NonfinComcd), ]
Ownership.Nonfin <- Data_Ownership[(Data_Ownership$Comcd %in% NonfinComcd), ]
Finance.Nonfin <- Data_Finance[(Data_Finance$Comcd %in% NonfinComcd), ]
Banlance.Nonfin <- Data_Banlance[(Data_Banlance$Comcd %in% NonfinComcd), ]
#行和列起名
names.Qvalue <- c('Comcd', 'Accper', 'QVal')
names.Industry <- c('Comcd', 'Indcd')
names.Concent <- c('Comcd', 'Reptdt', 'OwnCon1', 'OwnCon5', 'OwnCon10')
names.Ownership <- c('Comcd', 'Reptdt', 'Indicator', 'State')
names.Finance <- c('Comcd', 'Accper', 'ROA', 'ROE')
names.Banlance <- c('Comcd', 'Accper', 'CurrentAsset', 'TotalAsset', 'CurrentLib', 'TotalLib')
#选择行和列
Qvalue.tab <- Qvalue.Nonfin[substr(Qvalue.Nonfin$Accper, start=6, stop=7)=='12', names.Qvalue]
Industry.tab <- Industry.Nonfin[,names.Industry]
Concent.tab <- Concent.Nonfin[substr(Concent.Nonfin$Reptdt, start=6, stop=7)=='12', names.Concent]
Finance.tab <- Finance.Nonfin[substr(Finance.Nonfin$Accper, start=6, stop=7)=='12', names.Finance]
Banlance.tab <- Banlance.Nonfin[substr(Banlance.Nonfin$Accper, start=6, stop=7)=='12', names.Banlance]
Ownership.tab <- Ownership.Nonfin[Ownership.Nonfin$Indicator==1, names.Ownership]

#从这里开始已经出问题了GG
Ownership.tab$state <- 0
Ownership.tab$state[(Ownership.tab$State == 1100) | (Ownership.tab$State == 2100)] <- 1
#变量计算？不会
Qvalue.tab$Enddt <- as.numeric(substr(Qvalue.tab$Accper, 1, 4))
Concent.tab$Enddt <- as.numeric(substr(Concent.tab$Reptdt, 1, 4))
Ownership.tab$Enddt <- as.numeric(substr(Ownership.tab$Reptdt, 1, 4))
Finance.tab$Enddt <- as.numeric(substr(Finance.tab$Accper, 1, 4))
Banlance.tab$Enddt <- as.numeric(substr(Banlance.tab$Accper, 1, 4))
Concent.tab$OwnCon1<-as.numeric(Concent.tab$OwnCon1)
Concent.tab$OwnCon5<-as.numeric(Concent.tab$OwnCon5)
Concent.tab$EBD <- Concent.tab$OwnCon5/Concent.tab$OwnCon1
Banlance.tab$TotalAsset<-as.numeric(Banlance.tab$TotalAsset)
Banlance.tab$Size <- log(Banlance.tab$TotalAsset)
Banlance.tab$CurrentLib<-as.numeric(Banlance.tab$CurrentLib)
Banlance.tab$CurrentAsset<-as.numeric(Banlance.tab$CurrentAsset)
Banlance.tab$Currt <- Banlance.tab$CurrentAsset/Banlance.tab$CurrentLib
Banlance.tab$TotalLib<-as.numeric(Banlance.tab$TotalLib)
Banlance.tab$AssLibRatio <- Banlance.tab$TotalLib/Banlance.tab$TotalAsset



KeyField1 <- 'Comcd'         # key varialbes for matching
KeyField2 <- 'Enddt'         # key varialbes for matching

Qvalue.Finance <- merge(Qvalue.tab, Finance.tab, by=c(KeyField1, KeyField2))
Qvalue.Finance.Concent <- merge(Qvalue.Finance, Concent.tab, by=c(KeyField1, KeyField2))
Qvalue.Finance.Concent.Ownership <- merge(Qvalue.Finance.Concent, Ownership.tab, by=c(KeyField1, KeyField2))
Qvalue.Finance.Concent.Ownership.Banlance <- merge(Qvalue.Finance.Concent.Ownership, Banlance.tab, by=c(KeyField1, KeyField2))
Qvalue.Finance.Concent.Ownership.Banlance.Industry <- merge(Qvalue.Finance.Concent.Ownership.Banlance, Industry.tab,
                                                            by=c(KeyField1))

# (7) remove NA values
var.names <- c("Comcd", "Enddt", "QVal", "ROA", "ROE", "OwnCon1", "OwnCon10", "EBD","state","Size", 
               "CurrentAsset", "TotalAsset", "CurrentLib", "TotalLib", "Currt", "AssLibRatio", "Indcd")

Data <- Qvalue.Finance.Concent.Ownership.Banlance.Industry[,var.names]
Data <- na.omit(Data)

# (8) set dummy variables
Data$Year02 <- 0
Data$Year03 <- 0
Data$Year04 <- 0
Data$Year05 <- 0
Data$Year06 <- 0
Data$Year07 <- 0
Data$Year08 <- 0
Data$Year09 <- 0
Data$Year10 <- 0
Data$Year11 <- 0
Data$Year12 <- 0
Data$Year13 <- 0

Data[Data$Enddt == 2004, 'Year04'] <- 1
Data[Data$Enddt == 2005, 'Year05'] <- 1
Data[Data$Enddt == 2006, 'Year06'] <- 1
Data[Data$Enddt == 2007, 'Year07'] <- 1
Data[Data$Enddt == 2008, 'Year08'] <- 1
Data[Data$Enddt == 2009, 'Year09'] <- 1
Data[Data$Enddt == 2010, 'Year10'] <- 1
Data[Data$Enddt == 2011, 'Year11'] <- 1
Data[Data$Enddt == 2012, 'Year12'] <- 1
Data[Data$Enddt == 2013, 'Year13'] <- 1

dim(Data)
print(Data)
str(Data)







