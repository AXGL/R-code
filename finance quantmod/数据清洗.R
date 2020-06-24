library(quantmod)
setwd("D:/R/R-exercise/finance quantmod")
library(readxl)
library(dplyr)
library(gtools)
library(plyr)
library(reshape)
stock <- read_excel("年报公布时间.xlsx") %>% as.data.frame()
colnames(stock) <- c("code","2018","2019","2020")

stock_name <- lapply(stock$code,function(file){
  file <- paste(file,".SS",sep = "")
  return(file)
})

a <- as.Date(stock[,2])
b <- as.Date(stock[,3])
c <- as.Date(stock[,4])
a+15

stock <- as.matrix(stock)
stock
n <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20181.csv")
g <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20182.csv")
h <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20191.csv")
m <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20192.csv")
l <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20201.csv")
p <- read.csv("C:/Users/Administrator.SC-201809091908/Desktop/20202.csv")



zf1 <- apply(n[,c(seq(5,151,by=6))],2,Delt)
zf1[is.na(zf1)] <- 0
nzf <- apply(zf1,2,cumsum) %>% as.data.frame()
n <- cbind.data.frame(n,nzf)



zf2 <- apply(g[,c(seq(5,151,by=6))],2,Delt)
zf2[is.na(zf2)] <- 0
gzf <- apply(zf2,2,cumsum) %>% as.data.frame()
g <- cbind.data.frame(g,gzf)


zf3 <- apply(h[,c(seq(5,151,by=6))],2,Delt)
zf3[is.na(zf3)] <- 0
hzf <- apply(zf3,2,cumsum) %>% as.data.frame()
h <- cbind.data.frame(h,hzf)

zf4 <- apply(m[,c(seq(5,151,by=6))],2,Delt)
zf4[is.na(zf4)] <- 0
mzf <- apply(zf4,2,cumsum) %>% as.data.frame()
m <- cbind.data.frame(m,mzf)

zf5 <- apply(l[,c(seq(5,151,by=6))],2,Delt)
zf5[is.na(zf5)] <- 0
lzf <- apply(zf5,2,cumsum) %>% as.data.frame()
l <- cbind.data.frame(l,lzf)

zf6 <- apply(p[,c(seq(5,151,by=6))],2,Delt)
zf6[is.na(zf6)] <- 0
pzf <- apply(zf6,2,cumsum) %>% as.data.frame()
p <- cbind.data.frame(p,pzf)





n$X <- as.Date(n$X)
g$X <- as.Date(g$X)
h$X <- as.Date(h$X)
m$X <- as.Date(m$X)
l$X <- as.Date(l$X)
p$X <- as.Date(p$X)




x435 <- subset(n[,c(1:7,153)],n$X>=a[1]-21&n$X<=a[1]+21)
x436 <- subset(n[,c(1,8:13,154)],n$X>=a[2]-21&n$X<=a[2]+21)
x437 <- subset(n[,c(1,14:19,155)],n$X>=a[3]-21&n$X<=a[3]+21)
x438 <- subset(n[,c(1,20:25,156)],n$X>=a[4]-21&n$X<=a[4]+21)
x439 <- subset(n[,c(1,26:31,157)],n$X>=a[5]-21&n$X<=a[5]+21)
x440 <- subset(n[,c(1,32:37,158)],n$X>=a[6]-21&n$X<=a[6]+21)
x441 <- subset(n[,c(1,38:43,159)],n$X>=a[7]-21&n$X<=a[7]+21)
x442 <- subset(n[,c(1,44:49,160)],n$X>=a[8]-21&n$X<=a[8]+21)
x443 <- subset(n[,c(1,50:55,161)],n$X>=a[9]-21&n$X<=a[9]+21)
x444 <- subset(n[,c(1,56:61,162)],n$X>=a[10]-21&n$X<=a[10]+21)
x445 <- subset(n[,c(1,62:67,163)],n$X>=a[11]-21&n$X<=a[11]+21)
x446 <- subset(n[,c(1,68:73,164)],n$X>=a[12]-21&n$X<=a[12]+21)
x447 <- subset(n[,c(1,74:79,165)],n$X>=a[13]-21&n$X<=a[13]+21)
x448 <- subset(n[,c(1,80:85,166)],n$X>=a[14]-21&n$X<=a[14]+21)
x449 <- subset(n[,c(1,86:91,167)],n$X>=a[21]-21&n$X<=a[21]+21)
x550 <- subset(n[,c(1,92:97,168)],n$X>=a[16]-21&n$X<=a[16]+21)
x551 <- subset(n[,c(1,98:103,169)],n$X>=a[17]-21&n$X<=a[17]+21)
x552 <- subset(n[,c(1,104:109,170)],n$X>=a[18]-21&n$X<=a[18]+21)
x553 <- subset(n[,c(1,110:121,171)],n$X>=a[19]-21&n$X<=a[19]+21)
x554 <- subset(n[,c(1,116:121,172)],n$X>=a[20]-21&n$X<=a[20]+21)
x555 <- subset(n[,c(1,122:127,173)],n$X>=a[21]-21&n$X<=a[21]+21)
x556 <- subset(n[,c(1,128:133,174)],n$X>=a[22]-21&n$X<=a[22]+21)
x557 <- subset(n[,c(1,134:139,175)],n$X>=a[23]-21&n$X<=a[23]+21)
x558 <- subset(n[,c(1,140:145,176)],n$X>=a[24]-21&n$X<=a[24]+21)
x559 <- subset(n[,c(1,146:151,177)],n$X>=a[25]-21&n$X<=a[25]+21)

x4351 <- subset(g[,c(1:7,153)],g$X>=a[26]-21&g$X<=a[26]+21)
x4362 <- subset(g[,c(1,8:13,154)],g$X>=a[27]-21&g$X<=a[27]+21)
x4373 <- subset(g[,c(1,14:19,155)],g$X>=a[28]-21&g$X<=a[28]+21)
x4384 <- subset(g[,c(1,20:25,156)],g$X>=a[29]-21&g$X<=a[29]+21)
x4395 <- subset(g[,c(1,26:31,157)],g$X>=a[30]-21&g$X<=a[30]+21)
x4406 <- subset(g[,c(1,32:37,158)],g$X>=a[31]-21&g$X<=a[31]+21)
x4417 <- subset(g[,c(1,38:43,159)],g$X>=a[32]-21&g$X<=a[32]+21)
x4428 <- subset(g[,c(1,44:49,160)],g$X>=a[33]-21&g$X<=a[33]+21)
x4439 <- subset(g[,c(1,50:55,161)],g$X>=a[34]-21&g$X<=a[34]+21)
x44410 <- subset(g[,c(1,56:61,162)],g$X>=a[35]-21&g$X<=a[35]+21)
x44511 <- subset(g[,c(1,62:67,163)],g$X>=a[36]-21&g$X<=a[36]+21)
x44612 <- subset(g[,c(1,68:73,164)],g$X>=a[37]-21&g$X<=a[37]+21)
x44713 <- subset(g[,c(1,74:79,165)],g$X>=a[38]-21&g$X<=a[38]+21)
x44814 <- subset(g[,c(1,80:85,166)],g$X>=a[39]-21&g$X<=a[39]+21)
x44921 <- subset(g[,c(1,86:91,167)],g$X>=a[40]-21&g$X<=a[40]+21)
x55016 <- subset(g[,c(1,92:97,168)],g$X>=a[41]-21&g$X<=a[41]+21)
x55117 <- subset(g[,c(1,98:103,169)],g$X>=a[42]-21&g$X<=a[42]+21)
x55218 <- subset(g[,c(1,104:109,170)],g$X>=a[43]-21&g$X<=a[43]+21)
x55319 <- subset(g[,c(1,110:121,171)],g$X>=a[44]-21&g$X<=a[44]+21)
x55420 <- subset(g[,c(1,116:121,172)],g$X>=a[45]-21&g$X<=a[45]+21)
x55521 <- subset(g[,c(1,122:127,173)],g$X>=a[46]-21&g$X<=a[46]+21)
x55622 <- subset(g[,c(1,128:133,174)],g$X>=a[47]-21&g$X<=a[47]+21)
x55723 <- subset(g[,c(1,134:139,175)],g$X>=a[48]-21&g$X<=a[48]+21)
x55824 <- subset(g[,c(1,140:145,176)],g$X>=a[49]-21&g$X<=a[49]+21)
x55925 <- subset(g[,c(1,146:151,177)],g$X>=a[50]-21&g$X<=a[50]+21)


x41 <- subset(h[,c(1:7,152)],h$X>=b[1]-21&h$X<=b[1]+21)
x42 <- subset(h[,c(1,8:13,153)],h$X>=b[2]-21&h$X<=b[2]+21)
x43 <- subset(h[,c(1,14:19,154)],h$X>=b[3]-21&h$X<=b[3]+21)
x44 <- subset(h[,c(1,20:25,155)],h$X>=b[4]-21&h$X<=b[4]+21)
x45 <- subset(h[,c(1,26:31,156)],h$X>=b[5]-21&h$X<=b[5]+21)
x46 <- subset(h[,c(1,32:37,157)],h$X>=b[6]-21&h$X<=b[6]+21)
x47 <- subset(h[,c(1,38:43,158)],h$X>=b[7]-21&h$X<=b[7]+21)
x48 <- subset(h[,c(1,44:49,159)],h$X>=b[8]-21&h$X<=b[8]+21)
x49 <- subset(h[,c(1,50:55,160)],h$X>=b[9]-21&h$X<=b[9]+21)
x50 <- subset(h[,c(1,56:61,161)],h$X>=b[10]-21&h$X<=b[10]+21)
x51 <- subset(h[,c(1,62:67,162)],h$X>=b[11]-21&h$X<=b[11]+21)
x52 <- subset(h[,c(1,68:73,163)],h$X>=b[12]-21&h$X<=b[12]+21)
x53 <- subset(h[,c(1,74:79,164)],h$X>=b[13]-21&h$X<=b[13]+21)
x54 <- subset(h[,c(1,80:85,165)],h$X>=b[14]-21&h$X<=b[14]+21)
x55 <- subset(h[,c(1,86:91,166)],h$X>=b[21]-21&h$X<=b[21]+21)
x56 <- subset(h[,c(1,92:97,167)],h$X>=b[16]-21&h$X<=b[16]+21)
x57 <- subset(h[,c(1,98:103,168)],h$X>=b[17]-21&h$X<=b[17]+21)
x58 <- subset(h[,c(1,104:109,169)],h$X>=b[18]-21&h$X<=b[18]+21)
x59 <- subset(h[,c(1,110:115,170)],h$X>=b[19]-21&h$X<=b[19]+21)
x60 <- subset(h[,c(1,116:121,171)],h$X>=b[20]-21&h$X<=b[20]+21)
x61 <- subset(h[,c(1,122:127,172)],h$X>=b[21]-21&h$X<=b[21]+21)
x62 <- subset(h[,c(1,128:133,173)],h$X>=b[22]-21&h$X<=b[22]+21)
x63 <- subset(h[,c(1,134:139,174)],h$X>=b[23]-21&h$X<=b[23]+21)
x64 <- subset(h[,c(1,140:145,175)],h$X>=b[24]-21&h$X<=b[24]+21)
x65 <- subset(h[,c(1,146:151,176)],h$X>=b[25]-21&h$X<=b[25]+21)

x1 <- subset(m[,c(1:7,152)],m$X>=b[26]-21&m$X<=b[26]+21)
x2 <- subset(m[,c(1,8:13,153)],m$X>=b[27]-21&m$X<=b[27]+21)
x3 <- subset(m[,c(1,14:19,154)],m$X>=b[28]-21&m$X<=b[28]+21)
x4 <- subset(m[,c(1,20:25,155)],m$X>=b[29]-21&m$X<=b[29]+21)
x5 <- subset(m[,c(1,26:31,156)],m$X>=b[30]-21&m$X<=b[30]+21)
x6 <- subset(m[,c(1,32:37,157)],m$X>=b[31]-21&m$X<=b[31]+21)
x7 <- subset(m[,c(1,38:43,158)],m$X>=b[32]-21&m$X<=b[32]+21)
x8 <- subset(m[,c(1,44:49,159)],m$X>=b[33]-21&m$X<=b[33]+21)
x9 <- subset(m[,c(1,50:55,160)],m$X>=b[34]-21&m$X<=b[34]+21)
x10 <- subset(m[,c(1,56:61,161)],m$X>=b[35]-21&m$X<=b[35]+21)
x11 <- subset(m[,c(1,62:67,162)],m$X>=b[36]-21&m$X<=b[36]+21)
x12 <- subset(m[,c(1,68:73,163)],m$X>=b[37]-21&m$X<=b[37]+21)
x13 <- subset(m[,c(1,74:79,164)],m$X>=b[38]-21&m$X<=b[38]+21)
x14 <- subset(m[,c(1,80:85,165)],m$X>=b[39]-21&m$X<=b[39]+21)
x15 <- subset(m[,c(1,86:91,166)],m$X>=b[40]-21&m$X<=b[40]+21)
x16 <- subset(m[,c(1,92:97,167)],m$X>=b[41]-21&m$X<=b[41]+21)
x17 <- subset(m[,c(1,98:103,168)],m$X>=b[42]-21&m$X<=b[42]+21)
x18 <- subset(m[,c(1,104:109,169)],m$X>=b[43]-21&m$X<=b[43]+21)
x19 <- subset(m[,c(1,110:121,170)],m$X>=b[44]-21&m$X<=b[44]+21)
x20 <- subset(m[,c(1,116:121,171)],m$X>=b[45]-21&m$X<=b[45]+21)
x21 <- subset(m[,c(1,122:127,172)],m$X>=b[46]-21&m$X<=b[46]+21)
x22 <- subset(m[,c(1,128:133,173)],m$X>=b[47]-21&m$X<=b[47]+21)
x23 <- subset(m[,c(1,134:139,174)],m$X>=b[48]-21&m$X<=b[48]+21)
x24 <- subset(m[,c(1,140:145,175)],m$X>=b[49]-21&m$X<=b[49]+21)
x25 <- subset(m[,c(1,146:151,176)],m$X>=b[50]-21&m$X<=b[50]+21)

x411 <- subset(l[,c(1:7,152)],l$X>=c[1]-21&l$X<=c[1]+21)
x422 <- subset(l[,c(1,8:13,153)],l$X>=c[2]-21&l$X<=c[2]+21)
x433 <- subset(l[,c(1,14:19,154)],l$X>=c[3]-21&l$X<=c[3]+21)
x444 <- subset(l[,c(1,20:25,155)],l$X>=c[4]-21&l$X<=c[4]+21)
x455 <- subset(l[,c(1,26:31,156)],l$X>=c[5]-21&l$X<=c[5]+21)
x466 <- subset(l[,c(1,32:37,157)],l$X>=c[6]-21&l$X<=c[6]+21)
x477 <- subset(l[,c(1,38:43,158)],l$X>=c[7]-21&l$X<=c[7]+21)
x488 <- subset(l[,c(1,44:49,159)],l$X>=c[8]-21&l$X<=c[8]+21)
x499 <- subset(l[,c(1,50:55,160)],l$X>=c[9]-21&l$X<=c[9]+21)
x5010 <- subset(l[,c(1,56:61,161)],l$X>=c[10]-21&l$X<=c[10]+21)
x5111 <- subset(l[,c(1,62:67,162)],l$X>=c[11]-21&l$X<=c[11]+21)
x5212 <- subset(l[,c(1,68:73,163)],l$X>=c[12]-21&l$X<=c[12]+21)
x5313 <- subset(l[,c(1,74:79,164)],l$X>=c[13]-21&l$X<=c[13]+21)
x5414 <- subset(l[,c(1,80:85,165)],l$X>=c[14]-21&l$X<=c[14]+21)
x5515 <- subset(l[,c(1,86:91,166)],l$X>=c[21]-21&l$X<=c[21]+21)
x5616 <- subset(l[,c(1,92:97,167)],l$X>=c[16]-21&l$X<=c[16]+21)
x5717 <- subset(l[,c(1,98:103,168)],l$X>=c[17]-21&l$X<=c[17]+21)
x5818 <- subset(l[,c(1,104:109,169)],l$X>=c[18]-21&l$X<=c[18]+21)
x5919 <- subset(l[,c(1,110:115,170)],l$X>=c[19]-21&l$X<=c[19]+21)
x6020 <- subset(l[,c(1,116:121,171)],l$X>=c[20]-21&l$X<=c[20]+21)
x6121 <- subset(l[,c(1,122:127,172)],l$X>=c[21]-21&l$X<=c[21]+21)
x6222 <- subset(l[,c(1,128:133,173)],l$X>=c[22]-21&l$X<=c[22]+21)
x6323 <- subset(l[,c(1,134:139,174)],l$X>=c[23]-21&l$X<=c[23]+21)
x6424 <- subset(l[,c(1,140:145,175)],l$X>=c[24]-21&l$X<=c[24]+21)
x6525 <- subset(l[,c(1,146:151,176)],l$X>=c[25]-21&l$X<=c[25]+21)

xa <- subset(p[,c(1:7,152)],p$X>=c[26]-21&p$X<=c[26]+21)
xb <- subset(p[,c(1,8:13,153)],p$X>=c[27]-21&p$X<=c[27]+21)
xc <- subset(p[,c(1,14:19,154)],p$X>=c[28]-21&p$X<=c[28]+21)
xd <- subset(p[,c(1,20:25,155)],p$X>=c[29]-21&p$X<=c[29]+21)
xe <- subset(p[,c(1,26:31,156)],p$X>=c[30]-21&p$X<=c[30]+21)
xf <- subset(p[,c(1,32:37,157)],p$X>=c[31]-21&p$X<=c[31]+21)
xg <- subset(p[,c(1,38:43,158)],p$X>=c[32]-21&p$X<=c[32]+21)
xh <- subset(p[,c(1,44:49,159)],p$X>=c[33]-21&p$X<=c[33]+21)
xi <- subset(p[,c(1,50:55,160)],p$X>=c[34]-21&p$X<=c[34]+21)
xj <- subset(p[,c(1,56:61,161)],p$X>=c[35]-21&p$X<=c[35]+21)
xk <- subset(p[,c(1,62:67,162)],p$X>=c[36]-21&p$X<=c[36]+21)
xl <- subset(p[,c(1,68:73,163)],p$X>=c[37]-21&p$X<=c[37]+21)
xm <- subset(p[,c(1,74:79,164)],p$X>=c[38]-21&p$X<=c[38]+21)
xn <- subset(p[,c(1,80:85,165)],p$X>=c[39]-21&p$X<=c[39]+21)
xo <- subset(p[,c(1,86:91,166)],p$X>=c[40]-21&p$X<=c[40]+21)
xp <- subset(p[,c(1,92:97,167)],p$X>=c[41]-21&p$X<=c[41]+21)
xq <- subset(p[,c(1,98:103,168)],p$X>=c[42]-21&p$X<=c[42]+21)
xr <- subset(p[,c(1,104:109,169)],p$X>=c[43]-21&p$X<=c[43]+21)
xs <- subset(p[,c(1,110:121,170)],p$X>=c[44]-21&p$X<=c[44]+21)
xt <- subset(p[,c(1,116:121,171)],p$X>=c[45]-21&p$X<=c[45]+21)
xu <- subset(p[,c(1,122:127,172)],p$X>=c[46]-21&p$X<=c[46]+21)
xv <- subset(p[,c(1,128:133,173)],p$X>=c[47]-21&p$X<=c[47]+21)
xw <- subset(p[,c(1,134:139,174)],p$X>=c[48]-21&p$X<=c[48]+21)
xx <- subset(p[,c(1,140:145,175)],p$X>=c[49]-21&p$X<=c[49]+21)
xy <- subset(p[,c(1,146:151,176)],p$X>=c[50]-21&p$X<=c[50]+21)














ooo <- merge_recurse(list(x435,x436,x437,x438,x439,x440,x441,x442,x443,x444,x445,x446,x447,x448,x449,x550,x551,x552,x553,x554,x555,x556,x557,x558,x559),all.x=TRUE)

write.csv(ooo,file = "2018_fitted.csv")

ppp <- merge_recurse(list(x4351,x4362,x4373,x4384,x4395,x4406,x4417,x4428,x4439,x44410,x44511,x44612,x44713,x44814,x44921,x55016,x55117,x55218,x55319,x55420,x55521,x55622,x55723,x55824,x55925),all.x=TRUE)

write.csv(ppp,file = "201802_fitted.csv")

nnn <- merge_recurse(list(x41,x42,x43,x44,x45,x46,x47,x48,x49,x50,x51,x52,x53,x54,x55,x56,x57,x58,x59,x60,x61,x62,x63,x64,x65),all.x=TRUE)
write.csv(nnn,file = "201901_fitted.csv")


mmm <-merge_recurse(list(x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15,x16,x17,x18,x19,x20,x21,x22,x23,x24,x25),all.x=TRUE)
write.csv(mmm,file = "201902_fitted.csv")


rrr <- merge_recurse(list(x411,x422,x433,x444,x455,x466,x477,x488,x499,x5010,x5111,x5212,x5313,x5414,x5515,x5616,x5717,x5818,x5919,x6020,x6121,x6222,x6323,x6424,x6525),all.x=TRUE)
write.csv(rrr,file = "202001_fitted.csv")

ttt <- merge_recurse(list(xa,xb,xc,xd,xe,xf,xg,xh,xi,xj,xk,xl,xm,xn,xo,xp,xq,xr,xs,xt,xu,xv,xw,xx,xy),all.x=TRUE)
write.csv(ttt,"202002_fitted.csv")



