install.packages('leafletCN')
library(XML)
library(leafletCN)
library(dplyr)
library(rvest)
url<-"C:/Users/Administrator.SC-201809091908/Documents/PM25.in _ 全国空气质量指数(AQI)排行榜.html"
data<-read_html(url,encoding = "UTF-8")
title<-data%>%html_nodes('th')%>%html_text()
content<-data%>%html_nodes('td:nth-child(2)')%>%html_text()
content<-content[2:371]
AQI<-data%>%html_nodes('td:nth-child(3)')%>%html_text
AQI
AQI<-as.numeric(AQI)
dataframe<-data.frame(content,AQI)
dataframe
#leafletCN是一个用于绘制中国地图的包
geojsonMap(dataframe, "city",
           popup =  paste0(content,":",AQI),
           palette = "Reds", legendTitle = "AQI")
dat = data.frame(name = regionNames("china"),
                 value = runif(34))


geojsonMap(dat,"china")
regionNames("北京")
demomap("台湾")
demomap("深圳")
demomap("北京")

