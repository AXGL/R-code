install.packages('quantmod')
library(quantmod)
#万科
setSymbolLookup(WK=list(name='000002.sz',src='yahoo'))
getSymbols("WK")
chartSeries(WK)
#贵州茅台
setSymbolLookup(GZMT=list(name='600519.ss',src='yahoo'))
getSymbols("GZMT")
Op(GZMT)
chartSeries(GZMT)
#长江实业
setSymbolLookup(CJSY=list(name="00001.hk",src="yahoo"))
getSymbols("CJSY")
chartSeries(CJSY, up.col='red', dn.col='green', TA="addVo(); addMACD(); addSMA(n=10)")
#上证指数
getSymbols("^SSEC")
chartSeries(SSEC, up.col='red', dn.col='green', TA="addVo(); addMACD(); addSMA(n=10)")
#Apple
getSymbols("AAPL",src="yahoo")
barChart(AAPL)
chartSeries(AAPL)
candleChart(AAPL,multi.col=TRUE,theme="white")
#如何操作股票数据
getSymbols("GS") #Goldman OHLC from yahoo
is.OHLC(GS) # 判断是否OHLC数据
has.Vo(GS) # how about volume?
Op(GS) # 开盘价
seriesHi(GS) # where and what was the high point
OpCl(GS) # 计算开盘价到收盘价的变化率
OpOp(GS) #one period open to open change
HiCl(GS) #the percent change from high to close
Lag(Cl(GS)) # 求序列滞后一期的结果
Lag(Cl(GS),c(1,3,5)) #One, three, and five period lags
Next(OpCl(GS)) # 求序列超前一期的结果
# Open to close one-day, two-day and three-day lags
Delt(Op(GS),Cl(GS),k=1:3) #计算多个序列的简单收益率
GS['2007'] #returns all Goldman's 2007 OHLC
GS['2008'] #now just 2008
GS['2008-01'] #now just January of 2008
GS['2007-06::2008-01-12'] #Jun of 07 through Jan 12 of 08
GS['::'] # everything in GS
GS['2008::'] # everything in GS, from 2008 onward
non.contiguous <- c('2007-01','2007-02','2007-12')
GS[non.contiguous]
last(GS) #returns the last obs.
last(GS,8) #returns the last 8 obs.
# let's try something a bit cooler.
last(GS, '3 weeks')
last(GS, '-3 weeks') # all except the last 3 weeks
last(GS, '3 months')
last(first(GS, '2 weeks'), '3 days')

periodicity(GS)
unclass(periodicity(GS))
to.weekly(GS)
to.monthly(GS)
periodicity(to.monthly(GS))
ndays(GS); nweeks(GS); nyears(GS)
# Let's try some non-OHLC to start
getFX("USD/EUR")
periodicity(USDEUR)
to.weekly(USDEUR)
periodicity(to.weekly(USDEUR))

endpoints(GS,on="months")
# find the maximum closing price each week
apply.weekly(GS,FUN=function(x) { max(Cl(x)) } )
# the same thing - only more general
period.apply(GS,endpoints(GS,on='weeks'),
                 + FUN=function(x) { max(Cl(x)) } )
# same thing - only 50x faster!
as.numeric(period.max(Cl(GS),endpoints(GS,on='weeks')))
