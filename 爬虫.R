library('rvest')
web<-read_html('https://www.thepaper.cn/')
news<-web%>%html_nodes('h2 a')
title<-news%>%html_text()
link<-news%>%html_attrs()
link1<-c(1:length(link))
for(i in 1: length(link))
{
  link1[i]<-link[[i]][1]
}
link2<-paste("https://www.thepaper.cn/",link1,sep="")
link2
news_content<-c(1:length(link2))
for(i in 1:length(link2))
{
  news_content[i]<-read_html(link2[i])%>%html_nodes('div.news_txt')%>%html_text()
}
news01<-data.frame(title,link2,news_content)
write.csv(news01,file="D://p.csv")
