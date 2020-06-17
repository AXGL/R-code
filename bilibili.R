setwd("D:/R/BILIBILI scrape")
library(curl)
library(xml2) # 获取到B站视频弹幕的api地址，由唯一的cid来辨别，每个视频的cid可以在网页源代码获取
api = "http://api.bilibili.com/x/v1/dm/list.so?oid=183362119"
ret = curl_fetch_memory(api)
doc = read_xml(ret$content, encoding = "UTF-8")
nodes = xml_find_all(doc, ".//d")
danmu = xml_text(nodes)
length(danmu)



#从柯南B站的网页源代码里提取出jason格式的剧集列表，保存为1.json文件。
#library(jsonlite) #如果能用jsonlite，优先使用
#dat = fromJSON("1.json")
#dat

## json读取成功案例，列表转化为数据框的方式
library(RJSONIO) #不能使用jsonlite，用RJSONIO。
isValidJSON("1.json") # 判断是否为json的正确格式
a <- fromJSON("1.json",nullValue = NA, simplify = FALSE) #把json转化为R数据对象
library(plyr)
library(dplyr)
a.1<-do.call("rbind",lapply(lapply(a,t),  #lapply(a,t)把一个列表转置（这里如果不转置则行数不一致），再转化为data.frame, 再用rbind合并数据框
                            data.frame,stringsAsFactors=FALSE)) # stringsASfactors=false可以保持字符串不变
head(a.1)
a<-as.data.frame(select(a.1,cid,titleFormat,longTitle)) #选择需要的部分
a<-apply(a,2,as.character) #在写入文件时最好把格式统一为字符串，否则有些数据类型无法读入
write.csv(a,"a.csv",row.names = FALSE)


# 批量下载文件成功！
cid<-a[,1]
library(stringr)
progress_bar<-txtProgressBar(min=0,max=979,style =3)
for (i in 1:length(cid)) {
  api = str_c("http://api.bilibili.com/x/v1/dm/list.so?oid=",cid[i])
  ret = curl_fetch_memory(api)
  doc = read_xml(ret$content, encoding = "UTF-8")
  nodes = xml_find_all(doc, ".//d")
  danmu = xml_text(nodes)
  print(danmu)
  note <-file(paste("message",cid[i],".txt",sep='')) #关键是这句实现了批量保存
  write(danmu,note)
  setTxtProgressBar(progress_bar,i)
  Sys.sleep(0.2)
}

files <- list.files(pattern = ".*txt$", full.names = TRUE)%>%  #读取工作路径下所有txt文件名
str_replace_all("./","")
dat<- lapply(files,function(x){
  read.table(x,sep="\t")})  #文本数据读入错误，加入seq=\t后解决
dat1<-do.call("rbind",dat) 
dat2<-as.vector(dat1)
dat2<-str_replace_all(dat2,"n","")

library(jiebaR)
library(wordcloud2)
mixseg<-worker()
fc<-segment(dat2,mixseg) # 分词
t <-readLines("stop word.txt")

stopwords<-c(NULL)# 用于筛选一些不需要的字符，stop word.txt里面保存了需要被筛选掉的字符
for(i in 1:length(t))
{
  stopwords[i]<-t[i]
}
fc1 <- filter_segment(fc,stopwords)

sort(table(fc),decreasing=T)[1:50] #查看词频前50，发现基本都是单字的词
#在不做筛选的情况下jc2的词频统计结果都是常见的单个字，并无多少参考意义，因此我们对jc2进行筛选。
#筛选字符串长度介于2-6的词并进行前50的词频统计：  
fc3<-fc1[nchar(fc1)>1 & nchar(fc1)<7]
sort(table(fc3),decreasing=T)[1:50]

#筛选字符串长度介于3-7的词并进行前300的词频统计：
fc4<-fc1[nchar(fc1)>1 & nchar(fc1)<8]
wordf<-sort(table(fc4),decreasing=T)[1:300]
wordfp<-as_tibble(wordf)

# 筛选字符串介于5-10之间的词并进行前50词频统计
fc5<-fc1[nchar(fc1)>4 & nchar(fc1)<11]
sort(table(fc5),decreasing=T)[1:50]
# 做个词云
wordcloud2(wordf, size = 1,color = "random-light",backgroundColor = 'grey',fontFamily = "微软雅黑", shape = 'pentagon')

# 对角色进行词频计算
table(fc)[c("哀酱","小哀","灰原哀")]
table(fc)[c("小兰","毛利兰")]
table(fc)[c("基德","怪盗")]
table(fc)[c("柯南","死神")]

# 对筛选字符串长度介于3-7的词并进行前300的词频统计绘图
library(ggplot2)
wordfp %>%
  filter(n > 3500) %>%
  mutate(fc4 = reorder(fc4, n)) %>%
  ggplot(aes(fc4, n)) +
  geom_col(fill="steelblue") +
  xlab(NULL) +
  coord_flip()
