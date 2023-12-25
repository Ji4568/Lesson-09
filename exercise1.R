###�m��1�G�ǲߦp�󰵥X�i���\��
#�{�b�ڭ̪��D�F�A��Ƶ�ı�ƭn���o�n�A�N�O�n�bgoogle�W��M�A�X���d�ҡA�H�M��yrgl�z���ҡA�ڭ̥i�H�bA complete guide to 3D visualization device system in R - R software and data visualization�ݨ짹�㪺�о�
#�ڭ̨Ӥ��M�p�դ@�U�A��誺�Ϥ��ڭ̷Q�n�R�OR�N�ڭ̪��I��_�ӡA�ڭ̥i�H�ϥΤU���{���X�K
library(rgl)
plot3d(x = iris[,"Sepal.Length"],
       y = iris[,"Sepal.Width"],
       z = iris[,"Petal.Length"],
       col = COLOR, size = 3, main="3D Scatterplot")

VCOV = cov(iris[,c("Sepal.Length", "Sepal.Width", "Petal.Length")])
MEAN = c(mean(iris[,"Sepal.Length"]), mean(iris[,"Sepal.Width"]), mean(iris[,"Petal.Length"]))

ellips = ellipse3d(VCOV, centre = MEAN, level = 0.95)
plot3d(ellips, col = "black", alpha = 0.2, add = TRUE, box = FALSE)

###�m��1����

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
