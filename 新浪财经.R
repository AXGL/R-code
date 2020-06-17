library(rvest)
url <- 'http://vip.stock.finance.sina.com.cn/q/go.php/vInvestConsult/kind/xsjj/index.phtml?num=60'
content <- read_html(url)
trade <- html_table(content, header = TRUE)[[1]] 
write.csv(trade,file="D://trade.csv")



install.packages('magritter')
library(rvest)
library(magrittr)
content<-read_html(url)
trade<-html_table(content,header = TRUE)[[1]]
names(trade)<-trade[1,]
trade<-trade[-1,]
write.csv(trade,file="D://trade.csv")
