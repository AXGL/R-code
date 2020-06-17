#判断环境，并载入包，若未安装tidyverse，会自动进行安装。
if (!requireNamespace("tidyverse", quietly = TRUE)) {
  install.packages('tidyverse')
}
library(tidyverse)
dat <-
  data.frame(id = 1:26,
             height = c(seq(100, 550, 20),
                        seq(650, 700, 20))) %>%
  mutate(
    label = case_when(
      id <= 13 ~ paste0(height, "例 ", LETTERS[id], "国"),
      id <= 21 ~ paste0(height, "例\n", LETTERS[id], "国"),
      T ~ paste0(LETTERS[id], "国\n", height, "例")
    )
  )
dat

library(tidyverse)
require(nCov2019)
library(gganimate)
x <- get_nCov2019()
x
x[]
a<-x[]
is.list(a)
a
a[1]
a[3]
height<-unlist(a[3])%>%as.numeric()#UNlist和as.XXx可以把列表转化为某一类型的向量，然后再拼成dataframe
#height<-subset(height,height<50000)
height

label<-unlist(a[1])%>%as.character()
#label<-subset(label,label!="湖北")
label<-paste0(height, "例 ", label)

dat<-cbind.data.frame(height,label)#用as.data.frame没有成功，使用cbind.data.frame成功了
dat
#按降序排列数据框
dat<-dat[order(dat$height, decreasing= F),] 
dat$id<-1:34
#调整数据框列顺序
dat<-dat%>%select(id,height,label)
dat[34,]$height <- dat[34,]$height/30

dat$label[28:34] <-str_replace_all(dat$label[28:34],"例 ","例\n")
#绘制直方图
p1 <-
  ggplot(data = dat, aes(x = id, y = height, label = label)) +
  geom_col(aes(fill = id), width = 1.1, size = 0) +
  geom_col(
    aes(y = 40),
    fill = "white",
    width = 1,
    alpha = 0.2,
    size = 0
  ) +
  geom_col(
    aes(y = 20),
    fill = "white",
    width = 1,
    alpha = 0.2,
    size = 0
  )+
  theme(legend.position="none")
p1
#绘制南丁格尔图
p2 <-
  p1 +
  coord_polar() +
  theme_void() +
  theme(plot.margin = unit(c(0,0,0,0), "cm"))+
  scale_y_continuous(limits = c(-150, 2300))+ #设定数值范围
  theme(legend.position="none")
p2

#添加文字，geom_text参数

p3 <-
  p2 +
  geom_text(
    data = . %>% filter(id <= 19),
    nudge_y =170,
    angle = 95 - 180 * c(1:19) / 19,
    size=2
  ) +
  geom_text(
    data = . %>% filter(between(id, 20, 27)),
    nudge_y = -200,
    nudge_x = 0,
    color = "white",
    fontface = "bold",
    size=1.9
  ) +
  geom_text(
    data = . %>% filter(id >= 28),
    nudge_y = -90,
    color = "white",
    angle = 80 - 75 * c(1:7)/7,
    fontface = "bold",
    size=2
  )
p3
#上色
p4 <-
  p3 +
  scale_fill_gradientn(
    colors = c("#54778f", "#4EB043", "#E69D2A", "#DD4714", "#A61650"),
    guide = F
  )
p4
#ggsave函数可以保存各种形式的图片格式和文件格式，而且还可以调分辨率
ggsave("mtcars.png", width = 20, height = 20, units = "cm",dpi=300)






library(grid)
qplot(rnorm(100)) +
  ggtitle("Title") +
  theme(axis.title.x=element_text(vjust=-2)) +
  theme(axis.title.y=element_text(angle=90, vjust=-0.5)) +
  theme(plot.title=element_text(size=15, vjust=3)) +
  theme(plot.margin = unit(c(1,1,1,1), "cm"))
