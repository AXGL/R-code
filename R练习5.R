sum<-0
i<-0
while (i<4){
  sum<-sum+i
  i=i+1
}
  print(sum)

x<-5
if(x<4){
y<-sum(1:x)
}else {y<-sum(1:x)-4}
y

age<-10
if(age>61){
  print("老年")
}else if(age>36){
  print("中年")
}else if(age>13){
  print("青年")
}else{
  print("少年")
}
age<-45
if(age>61){
  print("老年")
}else if(age>36){
  print("中年")
}else if(age>13){
  print("青年")
}else{
  print("少年")
}

  stat1 <- function(x, plot.it=TRUE){
  if (!is.vector(x)) stop('argument x is not a vector, please check it.')
  mean <- mean(x)
  var <- var(x)
  stats <- c(mean=mean,var=var)
  if (plot.it){
    par(mfrow=c(1,2))
    hist(x)
}
  return(stat1)  
  }
stat1(c(1,2,3,4,5))

  stat2 <- function(x,y){
  if (!is.numeric(x)) stop('argument x is not a numeric,it is wrong.')
  sum<-x+y
  product<-x*y
  stats <- c(sum=sum,product=product)
  results<- list(stats=round(stats, digits=3))
  return(results) 
  }
  stat2(1:100,1:100)


yold <-function(age){
    if(age>61){
    print("老年")
  }else if(age>36){
    print("中年")
  }else if(age>13){
    print("青年")
  }else{
    print("少年")
  }
}
age<-c(20,20,40,50)
sapply(age, yold)
