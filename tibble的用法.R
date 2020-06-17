library(tibble)
as_tibble(iris)
t1<-tibble(1:10,b=LETTERS[1:10])
t1   #tibble会在每一列上面多出一个描述类型的字符
#int，代表integer
#dbl，代表double
#chr，代表character向量或字符串。
#dttm，代表日期+时间(a date + a time)
#lgl，代表逻辑判断TRUE或者FALSE
#fctr，代表因子类型factor
#date，代表日期dates.
class(t1)
#判断是否tibble
is_tibble(t1)
#查看tibble结构
attributes(t1)
#创建一个字母串tibble
tibble(letters)
#通过列表构建tibble
tibble(x = list(diag(1), diag(2)))
#data.frame变成tibble
d1<-data.frame(1:5,b=LETTERS[1:5])
d2<-as_tibble(d1)
d2
#在变回data.frme
as.data.frame(d2)
#向量转成tibble
x<-as.tibble(1:5)
x
as.vector(x)#但是向量无法转回tibble
# 把list转型为tibble
df <- as.tibble(list(x = 1:500, y = runif(500), z = 500:1))
df
# 把tibble再转为list
str(as.list(df))
# 生成一个matrix
m <- matrix(rnorm(15), ncol = 5)
# matrix转为tibble
df <- as_tibble(m)
df
#tibble转成矩阵
as.matrix(df)


#tibble通常用glimpse来获得结构，类似data.frame的str
glimpse(mtcars)
# 打印静态结构
str(mtcars)

#按列出数据，一层[]返回的结果还是tibbe，二层[]与$返回的结果为列组成的向量。
#返回tibble
df <- tibble(x = 1:3, y = 3:1)
df[1]
# 按列取，返回向量
df[[1]]
#按行取数据，这时一定要用,来做分隔符
# 取第一行，tibble
df[1,]
# 取前2行
df[1:2,]
# 取第二列的2，3行
df[2:3,2]


df <- tibble(x = 1:3, y = 3:1)
# 增加一列
add_column(df, z = -1:1, w = 0)
# 在最后，增加一行
add_row(df, x = 99, y = 9)
# 插入第二行，增加一行
add_row(df, x = 99, y = 9, .before = 2)


#打印输出控制，tibble的打印控制被重写了，所以执行print()函数时，模型会先进行类型匹配，然后调用print.tbl()。
# 创建tiblle
tb<-tibble(a=1:5, b = a * 2, c=NA, d='a', e=letters[1:5])
# 打印前10行，不限宽度
print(tb,n = 10, width = Inf)
# 打印前3行，宽度30
print(tb,n = 3, width = 30)


#甚至可以自动计算
tibble(x = 1:5, y = 1, z = x ^ 2 + y)

tribble(
  ~x, ~y,  ~z,
  "a", 2,  3.6,
  "b", 1,  8.5
)
