###�m��2�G���X�v���ܤƪ��ʵe
#�{�b�A�A�w�g�|���X�a�z��T�Ӷi���ı�ƤF�C
#���w�A�Ʊ�e�{���9����y�v��z���y�ֿn�Ӯ״����ϡz�A�A����k���m�o�ާ@�A���e�ϧ޳N�F��?

###�m��2����
#�o���y�k�i�H��Ҧ��ϩ�b�P��PDF���G
MysubMap = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')

pdf('Tainan.pdf', width = 7, height = 7)

for (k in 1:30) {
  subdat = dat[dat[,1] <= as.Date(paste0("2015-09-", k)) & dat[,1] >= as.Date("2015-09-01") & dat[,6] == "�x�n��",]
  PlotOnStaticMap(MysubMap)
  for (i in 1:nrow(Tainan.mapdat)) {
    linedat = read.csv(paste0("TWmap/TWmap/�s��", Tainan.mapdat[i,1], ".csv"), header = TRUE, fileEncoding = 'CP950')
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
  text(-200, -250, as.Date(paste0("2015-09-", k)), cex = 2, col = "red")
}

dev.off()
