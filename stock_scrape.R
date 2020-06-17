library(rvest)
url<-'http://fund.eastmoney.com/fund.html#os_0;isall_0;ft_;pt_1'
web<-read_html(url,encoding = "gb2312")
table<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('td.xh')%>%html_text
table
table2<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('td.bzdm')%>%html_text
table3<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('td.tol')%>%html_text
table3
table4<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.tol+ .black')%>%html_text
table4
table5<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.black:nth-child(7)')%>%html_text
table5
table6<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.black+ .dwjz')%>%html_text
table7<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.ljjz~ .ljjz')%>%html_text
table8<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.rzzz')%>%html_text
table8
table9<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.bg')%>%html_text
table10<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.sgzt')%>%html_text
table11<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.shzt')%>%html_text
table12<-web%>%html_nodes('table')%>%html_nodes('tbody')%>%html_nodes('tr')%>%html_nodes('.rate_f')%>%html_text
finance<-data.frame(table,table2,table3,table4,table5,table6,table7,table8,table9,table10,table11,table12)
finance
write.csv(finance,file = "D://finance.csv")###网页若是动态无法翻页抓取
length(table)

library(XML)
u<-'http://fund.eastmoney.com/fund.html#os_0;isall_0;ft_;pt_1'
table_1<-readHTMLTable(u)
