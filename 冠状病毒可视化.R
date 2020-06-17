install.packages("remotes")
remotes::install_github("GuangchuangYu/nCov2019",force = TRUE)
require(nCov2019)
x <- get_nCov2019()
x
 #返回数据的更新时间
time(x)
#直接打开腾讯的数据库
open(x)
x[]
x[1,]
x[2,]
x['广东', ]
x['湖北', ]
library(forcats)
library(ggplot2)
#广东的感染人数
d = x['广东',]
d$confirm=as.numeric(d$confirm)
d$name = fct_reorder(d$name, d$confirm)
#绘制广东的感染人数条形图
ggplot(d, aes(name, confirm)) + 
  geom_col(fill='steelblue') + coord_flip() +
  geom_text(aes(y = confirm+2, label=confirm), hjust=0) +
  theme_minimal(base_size=14) + 
  scale_y_continuous(expand=c(0,10)) +
  xlab(NULL) + ylab(NULL)

#获取全国今天的感染数据
head(x[by='today'], 34)
#查看湖北今天新增人数
x['湖北', by = "today"]


#查看全球感染数据
x['global',]
#中国冠状病毒累计情况
summary(x)
#中国冠状病毒每日新增情况
summary(x, by='today')
#中国冠状病毒每日新增情况直方图
ggplot(summary(x), aes(as.Date(date, "%m.%d"), as.numeric(confirm))) +
  geom_col(fill='firebrick') + theme_minimal(base_size = 14) +
  xlab(NULL) + ylab(NULL) + 
  labs(caption = paste("accessed date:", time(x)))

library(dplyr)
library(leafletCN)
#单独取某几列
name<-x[][1]
number<-x[][3]
number<-lapply(number, as.numeric)
data<-x[][c(1,3)]
geojsonMap(data, "city",
           popup =  paste0(name,":",number),
           palette = "Reds", legendTitle = "number")#绘制不成功
#绘制世界疫情分布情况
x = get_nCov2019()
plot(x)
#从杨老师的GitHub上安装Chinamap包##出现版本号不兼容问题
remotes::install_github("GuangchuangYu/chinamap")
1
require(chinamap)
cn = get_map_china()

plot(x, chinamap=cn)
install.packages('chinamap')


#用GGanimate来画动图，需要配合gifski包
install.packages("devtools")#安装GitHub的包
library(devtools)
install.packages('gifski') 
library(gifski)
install_github("https://github.com/thomasp85/gganimate/releases/tag/v0.1.1")#被拒绝了，只好本地安装
#本地安装也失败了？？最后还是install.packages起了作用
install.packages('gganimate')
library(gganimate)
x=load_nCov2019()
time(x)
a=x[]
a
view(a)
library(dplyr)
#用dplyr中的summarise函数把每个省份的数据加起来，因为总数据给出的是每个市的
b=summarise(group_by(a,time,province),
            sum(cum_confirm),
            sum(cum_dead),
            sum(cum_heal))
colnames(b)[3:5]=c('confirm','dead','heal')#修改列名
#不要武汉，武汉数据太多了
b=subset(b,province!='湖北')
#作图x轴为治愈人数，y轴为确诊人数，size即加上死亡人数，死亡越多，size越大，colour区分省份
library(ggplot2)
p3=ggplot(b,aes(x=heal,y=confirm,
                size=dead,
                colour=province))+
  geom_point(show.legend=T,alpha=0.8)+#show.lengend会显示图例，如果F就不会显示
  labs(x="治愈",y="确诊")
p3
ggsave("p3.png",width = 30,height = 54,units = "cm",dpi = 300)

#使用gganimate画动图,成功了！做残影
animate(p3+transition_time(time)+labs(title="日期:{frame_time}")#标签
+shadow_wake(wake_length = 0.4,alpha = FALSE),renderer = gifski_renderer(),height=1200,width=900,duration=10,fps=30)#做残影
#做轨迹没有成功
-animate(p3+transition_time(time)+labs(title="日期:{frame_time}")#标签
+shadow_mark(alpha = 0.3,size=0.5),renderer=gifski_renderer())#做残影
anim_save("残影.gif")
#这个包可以直接下载应用程序
install.packages("installr")
installr::install.ImageMagick("http://www.imagemagick.org/script/download.php")

#关于GDP增长的动态图
library(gapminder)

p1<-ggplot(gapminder, aes(gdpPercap, lifeExp, size = pop, colour = country)) +
  geom_point(alpha = 0.7, show.legend = FALSE) +
  scale_colour_manual(values = country_colors) +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  facet_wrap(~continent) +
  # Here comes the gganimate specific bits
  labs(title = 'Year: {frame_time}', x = 'GDP per capita', y = 'life expectancy') +
  transition_time(year) +
  ease_aes('linear')
animate(p1,renderer=gifski_renderer(),width=1600,height=900,duration = 10,fps = 30)
anim_save("p1.gif")

#折线图
p4=ggplot(b,aes(x=time,y=confirm,color=factor(province)))+
  geom_line(size=1)+
  scale_color_viridis_d()+
  scale_size(range = c(2,8))+
  labs(x="时间",y="确诊")+
  geom_point()+
  transition_reveal(time)
animate(p4,renderer=gifski_renderer(),width=1600,height=1200,duration = 10,fps=30)
anim_save("p2.gif")
#文字动图
p5=ggplot(b,aes(x=time,y=confirm,
                color=factor(province)))+
  scale_y_continuous(breaks = seq(0,1500,50))+
  geom_text(aes(x=time,y=confirm,label=province))+
  labs(x="时间","确诊")+theme(legend.position = "none")+
  transition_time(time)+labs(title="{frame_time}")+
  shadow_mark(alpha=1,size=1)
animate(p5)
