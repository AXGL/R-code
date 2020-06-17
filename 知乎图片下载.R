install.packages("downloader")
library(rvest)
library(downloader)
library(stringr)
library(dplyr)
web<-read_html('https://www.zhihu.com/question/304706190')
png<-web%>%html_nodes("figure")%>%html_nodes("img")%>%html_attr("src")
png
pat<-"https"
link<-grep(pat,png,value = TRUE)
head(link,10)
dir.create("D:R/case/")
for(i in 1:length(png))
{
  download(link[i],paste("D:R/case/picture",i,".jpg",sep =""),mode="wb")
  
}
link
