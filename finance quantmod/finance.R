library(quantmod)
setwd("D:/R/R-exercise/finance quantmod")
library(readxl)
library(dplyr)
stock <- read_excel("年报公布时间.xlsx") %>% as.data.frame()
colnames(stock) <- c("code","2018","2019","2020")

stock_name <- lapply(stock$code,function(file){
  file <- paste(file,".SS",sep = "")
  return(file)
})

a <- as.Date(stock[,2])
b <- as.Date(stock[,3])
c <- as.Date(stock[,4])

stock <- as.matrix(stock)



library(quantmod)

setSymbolLookup(A1=list(name='600435.SS'),B1=list(name='600436.SS'),
                C1=list(name='600438.SS'),D1=list(name='600439.SS'),
                E1=list(name='600444.SS'),F1=list(name='600446.SS'),
                G1=list(name='600448.SS'),H1=list(name='600449.SS'),
                I1=list(name='600452.SS'),J1=list(name='600455.SS'),
                K1=list(name='600456.SS'),L1=list(name='600458.SS'),
                M1=list(name='600459.SS'),N1=list(name='600460.SS'),
                O1=list(name='600461.SS'),Q1=list(name='600462.SS'),
                R1=list(name='600463.SS'),S1=list(name='600466.SS'),
                T1=list(name='600467.SS'),U1=list(name='600468.SS'),
                V1=list(name='600469.SS'),W1=list(name='600470.SS'),
                X1=list(name='600475.SS'),Y1=list(name='600476.SS'),
                Z1=list(name='600477.SS'),A=list(name='600478.SS'),
                B=list(name='600479.SS'),C=list(name='600480.SS'),
                D=list(name='600481.SS'),E=list(name='600482.SS'),
                F=list(name='600483.SS'),G=list(name='600485.SS'),
                H=list(name='600486.SS'),I=list(name='600487.SS'),
                J=list(name='600488.SS'),K=list(name='600489.SS'),
                L=list(name='600490.SS'),M=list(name='600491.SS'),
                N=list(name='600493.SS'),O=list(name='600495.SS'),
                P=list(name='600496.SS'),Q=list(name='600497.SS'),
                R=list(name='600498.SS'),S=list(name='600499.SS'),
                T=list(name='600500.SS'),U=list(name='600501.SS'),
                V=list(name='600502.SS'),W=list(name='600503.SS'),
                X=list(name='600505.SS'),Y=list(name='600506.SS'))


universes1 <- c('A1','B1','C1','D1','E1','F1','G1','H1','I1','J1','K1','L1','M1','N1','O1','Q1','R1','S1','T1','U1','V1','W1','X1','Y1','Z1','A','B','C','D','E','F','G',
                'H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y')

#同理，2018年的数据和2019年的数据在这里改变时间即可
loadSymbols(universes1,from="2020-03-01",to='2020-05-30',src="yahoo")

Q20201 <- cbind.data.frame(A1,B1,C1,D1,E1,F1,G1,H1,I1,J1,K1,L1,M1,N1,O1,Q1,R1,S1,T1,U1,V1,W1,X1,Y1,Z1,make.row.names=TRUE)

q20202 <- cbind.data.frame(A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,make.row.names=TRUE)









write.csv(Q20201,file = "20201.csv")
write.csv(q20202,file = "20202.csv")








# 试验部分

########################################################################################

a1 <- A1[a::b]
b1 <- B1[c[2]-15:c[2]+15]
c1 <- C1[c[3]-15:c[3]+15]
d1 <- D1[c[4]-15:c[4]+15]
e1 <- E1[c[5]-15:c[5]+15]
f1 <- F1[c[6]-15:c[6]+15]
g1 <- G1[c[7]-15:c[7]+15]
h1 <- H1[c[8]-15:c[8]+15]
i1 <- I1[c[9]-15:c[9]+15]
j1 <- J1[c[10]-15:c[10]+15]
k1 <- K1[c[11]-15:c[11]+15]
l1 <- L1[c[12]-15:c[12]+15]
m1 <- M1[c[13]-15:c[13]+15]
n1 <- N1[c[14]-15:c[14]+15]
o1 <- O1[c[15]-15:c[15]+15]
q1 <- Q1[c[16]-15:c[16]+15]
r1 <- R1[c[17]-15:c[17]+15]
s1 <- S1[c[18]-15:c[18]+15]
t1 <- T1[c[19]-15:c[19]+15]
u1 <- U1[c[20]-15:c[20]+15]
v1 <- V1[c[21]-15:c[21]+15]
w1 <- W1[c[22]-15:c[22]+15]
x1 <- X1[c[23]-15:c[23]+15]
y1 <- Y1[c[24]-15:c[24]+15]
z1 <- Z1[c[25]-15:c[25]+15]
a2 <- A[c[26]-15:c[26]+15]
b2<- B[c[27]-15:c[27]+15]
c2<- C[c[28]-15:c[28]+15]
d2<- D[c[29]-15:c[29]+15]
e2 <- E[c[30]-15:c[30]+15]
f2 <- F[c[31]-15:c[31]+15]
g2 <- G[c[32]-15:c[32]+15]
h2 <- H[c[33]-15:c[33]+15]
i2 <- I[c[34]-15:c[34]+15]
j2 <- J[c[35]-15:c[35]+15]
k2 <- K[c[36]-15:c[36]+15]
l2 <- L[c[37]-15:c[37]+15]
m2 <- M[c[38]-15:c[38]+15]
n2 <- N[c[39]-15:c[39]+15]
o2 <- O[c[40]-15:c[40]+15]
p2 <- P[c[41]-15:c[41]+15]
q2 <- Q[c[42]-15:c[42]+15]
r2 <- R[c[43]-15:c[43]+15]
s2 <- S[c[44]-15:c[44]+15]
t2 <- T[c[45]-15:c[45]+15]
u2 <- U[c[46]-15:c[46]+15]
v2 <- V[c[47]-15:c[47]+15]
w2 <- W[c[48]-15:c[48]+15]
x2 <- X[c[49]-15:c[49]+15]
y2 <- Y[c[50]-15:c[50]+15]




Q20201 <- rbind(a1,b1,c1,d1,e1,f1,g1,h1,i1,j1,k1,l1,m1,n1,o1,q1,r1,s1,t1,u1,v1,w1,x1,y1,z1,make.row.names=TRUE)

q20202 <- rbind(a2,b2,c2,d2,e2,f2,g2,h2,i2,j2,k2,l2,m2,n2,o2,p2,q2,r2,s2,t2,u2,v2,w2,x2,y2)




write.csv(Q20201,file = "20201.csv")
write.csv(q20202,file = "20202.csv")












setSymbolLookup(A1=list(name="600435.SS"),B1=list(name="AAPL"))
c <- c('A1','B1')
loadSymbols(c)




qq <- cbind(AA,BB,CC,DD,EE,LL,VV,WW,YY,A,B,C,D,E,FF,G,H,I,J,K,L,M,O,P,U,V,W,X,Y,Z)


from1
AA


loadSymbols('AAPL')
universes

setSymbolLookup(TX=list(name="600435.ss",src="yahoo"))
getSymbols("TX")
chartSeries(TX)
stock$code



from1




setwd("D:/R/R-exercise/finance quantmod")
library(readxl)
library(dplyr)
stock <- read_excel("年报公布时间.xlsx") %>% as.data.frame()
stock


stock_name <- lapply(stock$证券代码,function(file){
  file <- paste(file,".ss",sep = "")
  return(file)
})
stock_name

stock_function <- function()

stock_me <- lapply(stock_name, loadSymbols)



