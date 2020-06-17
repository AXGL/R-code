x<--10:10
y<-x^2
x
y
z<-cbind.data.frame(x,y)
z

library(ggplot2)
library(ggimage)
ggplot(z,aes(x,y))+
  geom_pokemon(aes(image=ifelse(x<0,'pikachu','gengar')))+
  theme(panel.grid.major = element_blank(),#这一行是用来去除网格线
        panel.grid.minor = element_blank(),
        axis.title = element_blank())#可用于去除标签
#保存图片
ggsave("pokemon.png",width =32,height = 32,units = "cm",dpi = 300)
?geom_pokemon

#可用于画正态分布，stat_function可以定义函数类型
p<-ggplot(data.frame(x=c(-3,3)),aes(x=x))
p+stat_function(fun=dnorm)

set.seed(2017-02-21)
example <- data.frame(x = rnorm(30),y = rnorm(30),image = sample(c("https://www.r-project.org/logo/Rlogo.png", "https://jeroenooms.github.io/images/frink.png"),
                                                                 size=10, replace = TRUE)) 
ggplot(example, aes(x, y)) + geom_image(aes(image=image), size=.07)+labs(title= "Example 2 for Geom Image",y="Icon 1", x = "Icon 2")+theme_classic()
ggplot(d, aes(x, y)) + geom_image(aes(image=image), size=.1, by='height')+labs(title= "Specifying size",
                                                                               y="Icon 1", x = "Icon 2")+ theme_classic()
ggplot(example, aes(x, y)) + geom_image(aes(image=image), size=.1, by='width')+labs(title= "Specifying size", y="Icon 1", x = "Icon 2")+ theme_classic()


set.seed(2018-12-11)
df  <-  data.frame(x=1:10, y=1:10,
                   type = sample(LETTERS[1:3], 10, replace=T),
                   angle = runif(10, 0, 360))
options(ggimage.keytype = "point")
ggplot(df, aes(x, y, colour=type, angle=angle)) +
  geom_pokemon(aes(image=ifelse(x>5, 'pikachu', 'tauros')))+labs(title= "pokemon Icon for X value greater than 5")+ theme_classic()
options(ggimage.keytype = "rect")
ggplot(df, aes(x, y, colour=type, angle=angle)) +
  geom_pokemon(aes(image=ifelse(x>5, 'pikachu', 'tauros')))+labs(title= "pokemon Icon for X value greater than 5")

set.seed(123)
iris2 <- iris[sample(1:nrow(iris), 30),]
model <- lm(Petal.Length ~ Sepal.Length, data=iris2)
iris2$fitted <- predict(model)
ggplot(iris2, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_linerange(aes(ymin = fitted, ymax = Petal.Length),
                 colour = "purple") +
  geom_abline(intercept = model$coefficients[1],
              slope = model$coefficients[2]) +
  geom_emoji(aes(image = ifelse(abs(Petal.Length-fitted) > 0.5, '1f622', '1f600')))
library(ggplot2)

set.seed(1)
x <- 1:10
y <- x + rnorm(10, sd = 1)
notlikethis <- data.frame(x = x, y = y)
n_pals      <- 200
pals        <- data.frame(
  x = runif(n_pals, -2, 12), y = runif(n_pals, -2, 12),
  pal = sample(c("wutface", "kappa", "pogchamp"), size = n_pals, replace = TRUE)
)
ggplot(notlikethis, aes(x = x, y = y)) +
  geom_twitchemote(data = pals,
                   aes(image = 'pogchamp'), size = 0.03, alpha = 0.3) +
  geom_twitchemote(aes(image = 'notlikethis'), size = 0.15) +
  geom_smooth()

library(knitr)

