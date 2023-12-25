###第一節：3D圖形(1)
#R的社群提供了多個套件用來繪製3D圖形，我們提供幾個比較常用的套件為同學做介紹
#真的想要畫好看的圖，Google後修改前人的程式碼最快

#3D圖形(2)
#鳶尾花卉數據集(Iris flower data set)最初是Edgar Anderson 從加拿大加斯帕半島上的鳶尾屬花朵中提取的地理變異數據，後由Ronald Fisher作為判別分析的一個例子。
#其數據集包含了150個樣本，都屬於鳶尾屬下的三個亞屬，分別是山鳶尾(setosa)、變色鳶尾(versicolor)和維吉尼亞鳶尾(virginica)。四個特徵被用作樣本的定量分析，它們分別是花萼(sepal)和花瓣(petal)的長度和寬度。
#在R裡面，我們能輕易的透過使用函數「data()」叫出IRIS資料集：
data(iris)
head(iris)

#3D圖形(3)
#我們有個假設，3種花彼此之間的花瓣/花萼長寬應該有段差距，但同樣一種花不同的50個樣本應該相當接近，現在我們要來驗證一下自己想的對不對
#我們先用2D散布圖來看看…
COLOR = as.integer(iris$Species)+1 #先根據Species分顏色，顏色代碼2在R裡面是紅色；3是綠色；4是藍色

par(mfrow = c(2, 3))
plot(iris[,"Sepal.Length"], iris[,"Sepal.Width"], pch = 19, col = COLOR)
legend("topright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
plot(iris[,"Sepal.Length"], iris[,"Petal.Length"], pch = 19, col = COLOR)
legend("bottomright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
plot(iris[,"Sepal.Length"], iris[,"Petal.Width"], pch = 19, col = COLOR)
legend("bottomright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
plot(iris[,"Sepal.Width"], iris[,"Petal.Length"], pch = 19, col = COLOR)
legend("topright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
plot(iris[,"Sepal.Width"], iris[,"Petal.Width"], pch = 19, col = COLOR)
legend("topright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
plot(iris[,"Petal.Length"], iris[,"Petal.Width"], pch = 19, col = COLOR)
legend("bottomright", levels(iris$Species), pch = 19, col = 2:4, bg = "gray90")
#雖然勉強能分開，但明顯可以發現versicolor與virginica比較接近，現在我們希望把這樣的分類放在3D散布圖上。

#3D圖形(4)
#這邊我們需要使用套件『scatterplot3d』。
library(scatterplot3d)
#接著，我們選擇3個變項來繪製散布圖
scatterplot3d(x = iris[,"Sepal.Length"],
              y = iris[,"Sepal.Width"],
              z = iris[,"Petal.Length"],
              color = COLOR, pch = 19, angle = 40, main="3D Scatterplot")
#感覺確實分的比較開了，但這個角度並不好調整，我們再試試其他套件

#3D圖形(5)
#這邊我們需要使用套件『rgl』。
#套件『rgl』是在R裡面最常拿來繪製3D圖形的套件，他支援了互動式的3D圖像。
library(rgl)
#接著，我們選擇3個變項來繪製散布圖
library(rgl)
plot3d(x = iris[,"Sepal.Length"],
       y = iris[,"Sepal.Width"],
       z = iris[,"Petal.Length"],
       col = COLOR, size = 3, main="3D Scatterplot")

