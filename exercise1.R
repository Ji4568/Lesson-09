###練習1：學習如何做出進階功能
#現在我們知道了，資料視覺化要做得好，就是要在google上找尋適合的範例，以套件『rgl』為例，我們可以在A complete guide to 3D visualization device system in R - R software and data visualization看到完整的教學
#我們來牛刀小試一下，剛剛的圖片我們想要命令R將我們的點圈起來，我們可以使用下面程式碼…
library(rgl)
plot3d(x = iris[,"Sepal.Length"],
       y = iris[,"Sepal.Width"],
       z = iris[,"Petal.Length"],
       col = COLOR, size = 3, main="3D Scatterplot")

VCOV = cov(iris[,c("Sepal.Length", "Sepal.Width", "Petal.Length")])
MEAN = c(mean(iris[,"Sepal.Length"]), mean(iris[,"Sepal.Width"]), mean(iris[,"Petal.Length"]))

ellips = ellipse3d(VCOV, centre = MEAN, level = 0.95)
plot3d(ellips, col = "black", alpha = 0.2, add = TRUE, box = FALSE)

###練習1答案

plot3d(x = iris[,"Sepal.Length"],
       y = iris[,"Sepal.Width"],
       z = iris[,"Petal.Length"],
       col = COLOR, size = 3, xlab = "Sepal Length", ylab = "Sepal Width", zlab = "Petal Length")

VCOV = cov(iris[1:50,c("Sepal.Length", "Sepal.Width", "Petal.Length")])
MEAN = apply(iris[1:50,c("Sepal.Length", "Sepal.Width", "Petal.Length")], 2, mean)

ellips <- ellipse3d(VCOV, centre = MEAN, level = 0.95)
plot3d(ellips, col = "red", alpha = 0.2, add = TRUE, box = FALSE)


VCOV = cov(iris[51:100,c("Sepal.Length", "Sepal.Width", "Petal.Length")])
MEAN = apply(iris[51:100,c("Sepal.Length", "Sepal.Width", "Petal.Length")], 2, mean)

ellips <- ellipse3d(VCOV, centre = MEAN, level = 0.95)
plot3d(ellips, col = "green", alpha = 0.2, add = TRUE, box = FALSE)


VCOV = cov(iris[101:150,c("Sepal.Length", "Sepal.Width", "Petal.Length")])
MEAN = apply(iris[101:150,c("Sepal.Length", "Sepal.Width", "Petal.Length")], 2, mean)

ellips <- ellipse3d(VCOV, centre = MEAN, level = 0.95)
plot3d(ellips, col = "blue", alpha = 0.2, add = TRUE, box = FALSE)

