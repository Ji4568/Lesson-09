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
