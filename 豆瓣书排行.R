library(rvest)
library(stringr)
data<-function(i){
  web<-read_html(str_c("https://book.douban.com/top250?icn=index-book250-all"),encoding = "UTF-8")
  p<-web%>%html_nodes(".pl2 a")%>%html_text
  q<-web%>%html_nodes("p.pl")%>%html_text
  r<-web%>%html_nodes(".inq")%>%html_text
  q<-str_replace_all(q," ","")
  q<-str_replace_all(q,"\n","")
  name<-p
  rate<-r
  q1<-str_split_fixed(q,"/",2)
  author<-q1[,1]
  q2<-str_split_fixed(q1[,2],"/",2)
  a<-str_detect(q2[,1],"出版")
  b<-str_detect(q2[,1],"书店")
  interpre<-q2[,1]
  interpre[a|b]<-"NA"
  q3<-str_split_fixed(q2[,2],"/",2)
  publisher<-q3[,1]
  publisher[a]<-q2[a,1]
  publisher[b]<-q2[b,1]
  q4<-str_split_fixed(q3[,2],"/",2)
  publish_time<-q4[,1]
  publish_time[a]<-q3[a,1]
  publish_time[b]<-q3[b,1]
  publish_time<-str_replace(publish_time,"年","-")
  publish_time <- str_replace(publish_time,"月","-")
  q5 <-str_split_fixed(q4[,2],"/",2)
  price <- q5[,1]
  price[a] <-q4[a,1]
  price[b] <-q4[b,1]
  book <-data.frame(name,rate,author,interpre,publisher,publish_time,price)
  return(book)
}
book_inf<-NULL
for(i in 1:5){
  book_inf<-rbind(book_inf,data(i))
}
book_inf
write.csv(book_inf,file="D://book_inf.csv")
















