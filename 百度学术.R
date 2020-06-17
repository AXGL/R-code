library('rvest')
library('stringr')
library('xml2')
data<-function(i){
  web<-read_html(str_c("http://xueshu.baidu.com/s?wd=%E9%9B%87%E4%B8%BB&ie=utf-8&tn=SE_baiduxueshu_c1gjeupa&sc_from=&sc_as_para=sc_lib%3A&rsv_sug2=0"),encoding = "UTF-8")
  title<-web%>%html_nodes(".c_font a")%>%html_text
  author<-web%>%html_nodes(".sc_info")%>%html_text
  title<-str_replace_all(title," ","")
  author1<-str_replace_all(author,"\r","")
  author2<-str_replace_all(author1," ","")
  author3<-str_replace_all(author2,"\n","")
  author4<-str_split_fixed(author3,"-",2)
  author5<-author4[,1]
  author6<-author4[,2]
  author7<-str_split_fixed(author6,"-",2)
  author8<-author7[,1]
  baidu<-data.frame(title,author5,author8)
  return(baidu)
}
baidu<-NULL
for(i in 1:20){
  baidu<-rbind(baidu,data(i))
}
baidu
write.csv(baidu,file="D://baidu.csv")
