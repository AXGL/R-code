#?????ڴ?
rm(list=ls())
#??GitHub?ϵİ???????????ʽ???ذ?װ
install.packages('devtools')
library(devtools)
install_github("GuangchuangYu/ggimage")
#或者下载GitHub仓库的zip文件，然后用devtools包的install_local来安装
#????GitHub?????????⣬��???ϣ??ͱ??ذ?װ???????????????????????д?bioconductor????,??????R????Ҫ?ֲ???cran????bioconductor??
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
#??bioconductor?????ذ?
BiocManager::install("ggimage")
library(gganimate)
library(ggplot2)
library(ggimage)
#???ذ?ggplot2,ggimage
mytheme <- theme_minimal() +
  theme(axis.title = element_blank())
theme_set(mytheme)
#???켣ͼ,ggimage??????????ͼƬӳ?䣬gganimate?????ڻ??ƶ?̬ͼƬ
x <- seq(-2 * pi, 2 * pi, length.out = 30)
d <- data.frame(x = x, y =sin(x))
img <- "C:/Users/Administrator.SC-201809091908/Desktop/webp.png"
#??ͼ
p1<-ggplot(d, aes(x, y)) + geom_image(image = img, size = .1)
#???켣??̬ͼ
p2<-p1+transition_reveal(x)
animate(p2,renderer=gifski_renderer())


set.seed(123)
iris2 <- iris[sample(1:nrow(iris), 30), ]
model <- lm(Petal.Length ~ Sepal.Length, data = iris2)
iris2$fitted <- predict(model)
p <- ggplot(iris2, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_linerange(aes(ymin = fitted, ymax = Petal.Length),
                 colour = "purple") +
  geom_abline(intercept = model$coefficients[1],
              slope = model$coefficients[2])
p1<-p + ggimage::geom_emoji(aes(image = ifelse(abs(Petal.Length-fitted) > 0.5, '1f622', '1f600')))
p2<-p1+transition_reveal(x)
p2

        
#?????? ͨ????????????ҳ????rvest??????ȡ??ҳ?????????ҵ???????û?гɹ?????
install.packages('rvest')
library(rvest)
library(dplyr)
url <- "C:/Users/Administrator.SC-201809091908/Desktop/????ƥ???˶??ά??ͳ?? - ά???ٿƣ????ɵİٿ?ȫ??.html"
heritage_parsed <- read_html(url,encoding="UTF-8")
a<-heritage_parsed%>%html_nodes(,'/html/body/div[5]/div[3]/div[4]/div/table[3]')%>%html_table
b<-heritage_parsed%>%html_nodes(,'/html/body/div[5]/div[3]/div[4]/div/table[4]')%>%html_table
head(b)
c<-b[[1]][2]
d<-b[[1]][3]

