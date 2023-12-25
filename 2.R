###第二節：結合地理資訊的視覺化(1)
#在資料視覺化的領域中，結合地理資訊系統的應用是一個重要的部分。這個部分與其他資料視覺化技術最大的不同在於，他必須結合外部的地圖資訊。
#Google地圖是我們最常用的地圖，他包含了街道圖/衛星圖等不同圖資，在R裡面我們可以透過套件輕鬆的與Google地圖作結合。
#請下載登革熱流行的範例資料”data10_1.csv”。
dat = read.csv("data10_1.csv", header = TRUE, fileEncoding = 'CP950')
head(dat)
#套件『RgoogleMaps』是最常拿來繪製Google地圖的套件，請安裝並載入他
install.packages("RgoogleMaps", repos="http://R-Forge.R-project.org")
library(RgoogleMaps)

#結合地理資訊的視覺化(2)
#首先我們先試著學習一下該怎麼使用這個套件。我們想要畫出台南市在2015年大流行時每天的流行狀況，首先我們要先獲得台南市的google地圖作為底圖。
#注意，你需要準備API Key：
lat = c(22.88751, 23.41373)
lon = c(120.023, 120.6562)
center = c(mean(lat), mean(lon))
zoom = min(MaxZoom(range(lat), range(lon)))

MyMap = GetMap(center = center, zoom = zoom, API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')

PlotOnStaticMap(MyMap)

#如果你想要畫衛星圖，可以這樣…
MyMap2 = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')
PlotOnStaticMap(MyMap2)

#結合地理資訊的視覺化(3)
#接著我們可以透過索引函數找出台南市在2015年9月份整個月份的登革熱病例
dat[,1] = as.Date(dat[,1])
subdat = dat[dat[,1] <= as.Date("2015-09-30") & dat[,1] >= as.Date("2015-09-01") & dat[,6] == "台南市",]
nrow(subdat)
#台南市9月份居然有12815個新登革熱病例！
#我們可以透過函數「PlotOnStaticMap()」把點放到MyMap上面
PlotOnStaticMap(MyMap, lat = subdat$最小統計區中心點Y, lon = subdat$最小統計區中心點X, pch = 19, col = "red", cex = 1)

#結合地理資訊的視覺化(4)
#點實在太密了，還記得上週的練習2中，你如何將散布圖的點做顏色密度的改變嗎?
x1 <- subdat$最小統計區中心點Y
x2 <- subdat$最小統計區中心點X
df <- data.frame(x1,x2)

## Use densCols() output to get density at each point
x <- densCols(x1,x2, colramp=colorRampPalette(c("black", "white")))
df$dens <- col2rgb(x)[1,] + 1L

## Map densities to colors
cols <-  colorRampPalette(c("#000099", "#00FEFF", "#45FE4F", 
                            "#FCFF00", "#FF9400", "#FF3100"))(256)
df$col <- cols[df$dens]

PlotOnStaticMap(MyMap, lat = df$x1, lon = df$x2, pch = 19, col = df$col, cex = 1.5)

#結合地理資訊的視覺化(5)
#如果我們希望畫行政區邊界的圖，我們可以下載各行政區地圖邊界的資訊”TWmap”。
mapdat = read.table("TWmap/TWmap/鄉村資料.txt", fileEncoding = "UTF-8")
head(mapdat)
#找出與台南市有關的鄉里
Tainan.mapdat = mapdat[mapdat[,4] == "臺南市",]
nrow(Tainan.mapdat)

#接著我們可以利用迴圈把村里邊界標上去
MysubMap = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')

PlotOnStaticMap(MysubMap)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  PlotOnStaticMap(MysubMap, lat = linedat[,2], lon = linedat[,1], FUN = lines, add = TRUE, col = "red")
}

#再把剛剛的點打上去
MysubMap = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')
PlotOnStaticMap(MysubMap)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  PlotOnStaticMap(MysubMap, lat = linedat[,2], lon = linedat[,1], FUN = lines, add = TRUE, col = "red")
}

PlotOnStaticMap(MysubMap, lat = df$x1, lon = df$x2, pch = 19, col = df$col, add = TRUE)

#結合地理資訊的視覺化(6)
#既然你有各行政區的地理邊界資訊，其實我們可以利用函數「polygon()」畫出地圖邊界：
lat = c(22.88751, 23.41373)
lon = c(120.023, 120.6562)
plot.new()
plot.window(xlim = lon, ylim = lat)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  polygon(linedat[,1], linedat[,2], col = "white")
}
#我們可以結合這兩個資訊，畫出各行政區的發病狀況：
lat = c(22.88751, 23.41373)
lon = c(120.023, 120.6562)
plot.new()
plot.window(xlim = lon, ylim = lat)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  n.sample = sum(subdat[,16] == as.character(Tainan.mapdat[i,2]))
  if (n.sample == 0) {COL = "#FFFFFF"} 
  else if (n.sample <= 3) {COL = "#000099"} 
  else if (n.sample <= 10) {COL = "#00FEFF"} 
  else if (n.sample <= 30) {COL = "#45FE4F"} 
  else if (n.sample <= 50) {COL = "#FCFF00"} 
  else if (n.sample <= 100) {COL = "#FF9400"} 
  else {COL = "#FF3100"} 
  polygon(linedat[,1], linedat[,2], col = COL)
}

#結合地理資訊的視覺化(7)
#還記得要怎樣讓顏色變成透明的嗎?我們可以使用8位色碼
lat = c(22.88751, 23.41373)
lon = c(120.023, 120.6562)
plot.new()
plot.window(xlim = lon, ylim = lat)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  n.sample = sum(subdat[,16] == as.character(Tainan.mapdat[i,2]))
  if (n.sample == 0) {COL = "#FFFFFF80"} 
  else if (n.sample <= 3) {COL = "#00009980"} 
  else if (n.sample <= 10) {COL = "#00FEFF80"} 
  else if (n.sample <= 30) {COL = "#45FE4F80"} 
  else if (n.sample <= 50) {COL = "#FCFF0080"} 
  else if (n.sample <= 100) {COL = "#FF940080"} 
  else {COL = "#FF310080"} 
  polygon(linedat[,1], linedat[,2], col = COL)
}
#接著我們也可以將圖片疊在google地圖上，是不是看起來很專業呢?
MysubMap = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')
PlotOnStaticMap(MysubMap)

for (i in 1:nrow(Tainan.mapdat)) {
  linedat = read.csv(paste0("TWmap/TWmap/編號", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
  n.sample = sum(subdat[,16] == as.character(Tainan.mapdat[i,2]))
  if (n.sample == 0) {COL = "#FFFFFF80"} 
  else if (n.sample <= 3) {COL = "#00009980"} 
  else if (n.sample <= 10) {COL = "#00FEFF80"} 
  else if (n.sample <= 30) {COL = "#45FE4F80"} 
  else if (n.sample <= 50) {COL = "#FCFF0080"} 
  else if (n.sample <= 100) {COL = "#FF940080"} 
  else {COL = "#FF310080"} 
  PlotOnStaticMap(MysubMap, lat = linedat[,2], lon = linedat[,1], FUN = polygon, add = TRUE, col = COL)
}

