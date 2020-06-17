library('rvest')
web<-read_html('https://www.kanbilibili.com/rank/videos')
news<-web%>%html_nodes('.title')
title<-news%>%html_text()
rank<-web%>%html_nodes('.total .play')%>%html_text
up<-web%>%html_nodes(".up")%>%html_text
title1<-title[-1:-68]
title2<-title1[-100:-102]
title2
rank
data<-data.frame(title2,rank,up)
