library('rvest')
url <- 'http://www.imdb.com/search/title?count=100&release_date=2016,2016&title_type=feature'
webpage <- read_html(url)
webpage
#排名
rank_data_html <- html_nodes(webpage,'.text-primary')
rank_data <- html_text(rank_data_html)
head(rank_data)                       
rank_data<-as.numeric(rank_data)
head(rank_data)
#名字
title_data_html <- html_nodes(webpage,'.lister-item-header a')
title_data <- html_text(title_data_html)
head(title_data)
description_data_html <- html_nodes(webpage,'.ratings-bar+ .text-muted')
description_data <- html_text(description_data_html)
head(description_data)
description_data<-gsub("\n","",description_data)
head(description_data)
#时长
runtime_data_html <- html_nodes(webpage,'.text-muted .runtime')
runtime_data <- html_text(runtime_data_html)
head(runtime_data)
runtime_data<-gsub(" min","",runtime_data)
runtime_data<-as.numeric(runtime_data)
head(runtime_data)
#电影类型
genre_data_html <- html_nodes(webpage,'.genre')
genre_data <- html_text(genre_data_html)
head(genre_data)
genre_data<-gsub("\n","",genre_data)
genre_data<-gsub(" ","",genre_data)
genre_data<-gsub(",.*","",genre_data)
genre_data<-as.factor(genre_data)
head(genre_data)
#评分
rating_data_html <- html_nodes(webpage,'.ratings-imdb-rating strong')
rating_data <- html_text(rating_data_html)
head(rating_data)
rating_data<-as.numeric(rating_data)
head(rating_data)
#投票人数
votes_data_html <- html_nodes(webpage,'.sort-num_votes-visible span:nth-child(2)')
votes_data <- html_text(votes_data_html)
head(votes_data)
votes_data<-gsub(",","",votes_data)
votes_data<-as.numeric(votes_data)
head(votes_data)
#导演名字
directors_data_html <- html_nodes(webpage,'.text-muted+ p a:nth-child(1)')
directors_data <- html_text(directors_data_html)
head(directors_data)
directors_data<-as.factor(directors_data)
head(directors_data)
#演员名字
actors_data_html <- html_nodes(webpage,'.lister-item-content .ghost+ a')
actors_data <- html_text(actors_data_html)
head(actors_data)
actors_data<-as.factor(actors_data)
move<-data.frame(Rank=rank_data,Title=title_data,Description=description_data,Runtime=runtime_data,genre=genre_data,Rating=rating_data,Directors=directors_data,Actor=actors_data)
move
str(move)
library('ggplot2')
a<-qplot(data = move,runtime_data,fill = genre_data,bins = 30)+
  theme(panel.grid.major = element_blank(),#这一行是用来去除网格线
        panel.grid.minor = element_blank())
ggsave("a.png",width = 30,height = 40,units = "cm",dpi=300)
b<-ggplot(move,aes(x=Runtime,y=Rating))+
  geom_point(aes(size=votes_data,col=genre_data))+
  theme(panel.grid.major = element_blank(),#这一行是用来去除网格线
        panel.grid.minor = element_blank())
ggsave("b.png",width = 30,height = 40,units = "cm",dpi=300)
#cleveland点图
data<-data.frame(title_data,runtime_data)
data[1:25,]
c<-ggplot(data[1:25,],aes(x=runtime_data,y=reorder(title_data,runtime_data)))+geom_point(size=3)+
 theme_bw()+
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.major.y = element_line(colour =rating_data,linetype = "dashed"))
ggsave("c.png",width = 30,height = 40,units = "cm",dpi=300) 
move






t