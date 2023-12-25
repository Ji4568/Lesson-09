###�ĤG�`�G���X�a�z��T����ı��(1)
#�b��Ƶ�ı�ƪ���줤�A���X�a�z��T�t�Ϊ����άO�@�ӭ��n�������C�o�ӳ����P��L��Ƶ�ı�Ƨ޳N�̤j�����P�b��A�L�������X�~�����a�ϸ�T�C
#Google�a�ϬO�ڭ̳̱`�Ϊ��a�ϡA�L�]�t�F��D��/�ìP�ϵ����P�ϸ�A�bR�̭��ڭ̥i�H�z�L�M���P���PGoogle�a�ϧ@���X�C
#�ФU���n�����y�檺�d�Ҹ�ơ�data10_1.csv���C
dat = read.csv("data10_1.csv", header = TRUE, fileEncoding = 'CP950')
head(dat)
#�M��yRgoogleMaps�z�O�̱`����ø�sGoogle�a�Ϫ��M��A�Цw�˨ø��J�L
install.packages("RgoogleMaps", repos="http://R-Forge.R-project.org")
library(RgoogleMaps)

#���X�a�z��T����ı��(2)
#�����ڭ̥��յ۾ǲߤ@�U�ӫ��ϥγo�ӮM��C�ڭ̷Q�n�e�X�x�n���b2015�~�j�y��ɨC�Ѫ��y�檬�p�A�����ڭ̭n����o�x�n����google�a�ϧ@�����ϡC
#�`�N�A�A�ݭn�ǳ�API Key�G
lat = c(22.88751, 23.41373)
lon = c(120.023, 120.6562)
center = c(mean(lat), mean(lon))
zoom = min(MaxZoom(range(lat), range(lon)))

MyMap = GetMap(center = center, zoom = zoom, API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')

PlotOnStaticMap(MyMap)

#�p�G�A�Q�n�e�ìP�ϡA�i�H�o�ˡK
MyMap2 = GetMap(center = center, zoom = zoom, maptype = "satellite", API_console_key = 'AIzaSyA4DVFtF70aXE7RgrXViy2z5Ku2pMkVxFI')
PlotOnStaticMap(MyMap2)

#���X�a�z��T����ı��(3)
#���ۧڭ̥i�H�z�L���ި�Ƨ�X�x�n���b2015�~9�����Ӥ�����n�����f��
dat[,1] = as.Date(dat[,1])
subdat = dat[dat[,1] <= as.Date("2015-09-30") & dat[,1] >= as.Date("2015-09-01") & dat[,6] == "�x�n��",]
nrow(subdat)
#�x�n��9����~�M��12815�ӷs�n�����f�ҡI
#�ڭ̥i�H�z�L��ơuPlotOnStaticMap()�v���I���MyMap�W��
PlotOnStaticMap(MyMap, lat = subdat$�̤p�έp�Ϥ����IY, lon = subdat$�̤p�έp�Ϥ����IX, pch = 19, col = "red", cex = 1)
