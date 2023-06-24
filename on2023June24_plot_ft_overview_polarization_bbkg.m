%https://ww2.mathworks.cn/videos/making-a-multi-color-line-in-matlab-97127.html
%%load and create ion energy spectrom
%%Epoch
%%mms1_dis_energyspectr_omni_brst
%mobmeanWnd=300;
%arrBxyzMovmean=movmean(arrBxyz,mobmeanWnd,1);%%%%滑动窗口可以选择
clear all;
close all;
%% -------------------------------------------------------------------------
ic = 1; % Spacecraft number
mmsColors=[0 0 1;0 1 1; 1 0 1; 0 0 0];
colorArr=['b','c','m','k','y'];
lineColorArr=['k','w','w'];
myFontSize=12;
ylimRange=[0.5 12];
Bsumthres=1e-1;%%1e-1
planthres=0.7;%%0.55
%%
% %case#1
caseCutBrst=1;
trangeLoadData=('2017-12-01T14:40:30.000Z/2017-12-01T14:41:30.000Z');
TintEBSP=irf.tint('2017-12-01T14:40:50.00Z/2017-12-01T14:41:10.000Z');
TintShow=irf.tint('2017-12-01T14:40:55.00Z/2017-12-01T14:41:05.000Z');
%
tShock=irf.time_array('2017-12-01T14:41:00.000Z');
TintAll=irf.tint('2017-12-01T14:40:30.000Z/2017-12-01T14:41:30.000Z');
TintSW=irf.tint('2017-12-01T14:40:30.000Z/2017-12-01T14:40:40.000Z');
TintFT=irf.tint('2017-12-01T14:40:40.000Z/2017-12-01T14:41:00.200Z');
TintFS=irf.tint('2017-12-01T14:41:00.200Z/2017-12-01T14:41:30.000Z');
cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2017\12\01\mms1_fpi_brst_l2_dis-moms_20171201143933_v3.3.0.cdf');
%
TintInterested=irf.tint('2017-12-01T14:41:00.100Z/2017-12-01T14:41:03.000Z');
freInterested=[0.5,6];
% % %case#2
% trangeLoadData=('2017-12-17T17:52:23.000Z/2017-12-17T17:53:50.000Z');
% TintEBSP=irf.tint('2017-12-17T17:53:10.000Z/2017-12-17T17:53:30.000Z');
% TintShow=irf.tint('2017-12-17T17:53:15.000Z/2017-12-17T17:53:25.000Z');
% %
% tShock=irf.time_array('2017-12-17T17:53:20.500Z');
% TintAll=irf.tint('2017-12-17T17:52:23.000Z/2017-12-17T17:53:50.000Z');
% TintSW=irf.tint('2017-12-17T17:52:10.000Z/2017-12-17T17:52:45.000Z');
% TintFT=irf.tint('2017-12-17T17:52:45.000Z/2017-12-17T17:53:20.000Z');
% TintFS=irf.tint('2017-12-17T17:53:20.000Z/2017-12-17T17:53:50.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2017\12\17\mms1_fpi_brst_l2_dis-moms_20171217175223_v3.3.0.cdf');
% % %case#3
% trangeLoadData=('2017-12-18T12:55:13.000Z/2017-12-18T12:57:43.000Z');
% TintEBSP=irf.tint('2017-12-18T12:56:45.000Z/2017-12-18T12:57:05.000Z');
% TintShow=irf.tint('2017-12-18T12:56:45.000Z/2017-12-18T12:57:05.000Z');
% %
% tShock=irf.time_array('2017-12-18T12:56:47.400Z');
% TintAll=irf.tint('2017-12-18T12:55:13.000Z/2017-12-18T12:57:43.000Z');
% TintSW=irf.tint('2017-12-18T12:55:13.000Z/2017-12-18T12:55:50.000Z');
% TintFT=irf.tint('2017-12-18T12:55:50.000Z/2017-12-18T12:56:47.400Z');
% TintFS=irf.tint('2017-12-18T12:56:47.400Z/2017-12-18T12:57:43.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2017\12\18\mms1_fpi_brst_l2_dis-moms_20171218125513_v3.3.0.cdf');
% % %case#4
% trangeLoadData=('2017-12-29T19:10:50.000Z/2017-12-29T19:12:00.000Z');
% TintEBSP=irf.tint('2017-12-29T19:10:30.000Z/2017-12-29T19:11:50.000Z');
% TintShow=irf.tint('2017-12-29T19:11:30.000Z/2017-12-29T19:11:50.000Z');
% %
% tShock=irf.time_array('2017-12-29T19:11:36.200Z');
% TintAll=irf.tint('2017-12-29T19:10:50.000Z/2017-12-29T19:12:00.000Z');
% TintSW=irf.tint('2017-12-29T19:10:50.000Z/2017-12-29T19:11:05.000Z');
% TintFT=irf.tint('2017-12-29T19:11:05.000Z/2017-12-29T19:11:36.200Z');
% TintFS=irf.tint('2017-12-29T19:11:36.200Z/2017-12-29T19:12:00.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2017\12\29\mms1_fpi_brst_l2_dis-moms_20171229191013_v3.3.0.cdf');
% % %case#5
% trangeLoadData=('2018-01-09T08:34:23.000Z/2018-01-09T08:35:03.000Z');
% TintEBSP=irf.tint('2018-01-09T08:34:45.000Z/2018-01-09T08:35:03.000Z');
% TintShow=irf.tint('2018-01-09T08:34:45.000Z/2018-01-09T08:35:03.000Z');
% %
% tShock=irf.time_array('2018-01-09T08:34:52.000Z');
% TintAll=irf.tint('2018-01-09T08:34:23.000Z/2018-01-09T08:35:03.000Z');
% TintSW=irf.tint('2018-01-09T08:34:23.000Z/2018-01-09T08:34:34.000Z');
% TintFT=irf.tint('2018-01-09T08:34:34.000Z/2018-01-09T08:34:52.000Z');
% TintFS=irf.tint('2018-01-09T08:34:52.000Z/2018-01-09T08:35:03.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\01\09\mms1_fpi_brst_l2_dis-moms_20180109083423_v3.3.0.cdf');
% % %case#6
% trangeLoadData=('2018-02-04T10:37:13.000Z/2018-02-04T10:38:53.000Z');
% TintEBSP=irf.tint('2018-02-04T10:38:05.000Z/2018-02-04T10:38:25.000Z');
% TintShow=irf.tint('2018-02-04T10:38:05.000Z/2018-02-04T10:38:25.000Z');
% %
% tShock=irf.time_array('2018-02-04T10:38:12.600Z');
% TintAll=irf.tint('2018-02-04T10:37:13.000Z/2018-02-04T10:38:53.000Z');
% TintSW=irf.tint('2018-02-04T10:37:13.000Z/2018-02-04T10:37:30.000Z');
% TintFT=irf.tint('2018-02-04T10:37:30.000Z/2018-02-04T10:38:12.600Z');
% TintFS=irf.tint('2018-02-04T10:38:12.600Z/2018-02-04T10:38:53.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\02\04\mms1_fpi_brst_l2_dis-moms_20180204103713_v3.3.0.cdf');
% % %case#7
% trangeLoadData=('2018-02-21T11:34:23.000Z/2018-02-21T11:37:23.000Z');
% TintEBSP=irf.tint('2018-02-21T11:36:40.000Z/2018-02-21T11:37:00.000Z');
% TintShow=irf.tint('2018-02-21T11:36:40.000Z/2018-02-21T11:37:00.000Z');
% %
% tShock=irf.time_array('2018-02-21T11:36:44.688Z');
% TintAll=irf.tint('2018-02-21T11:34:23.000Z/2018-02-21T11:37:23.000Z');
% TintSW=irf.tint('2018-02-21T11:34:23.000Z/2018-02-21T11:34:57.000Z');
% TintFT=irf.tint('2018-02-21T11:34:57.000Z/2018-02-21T11:36:44.688Z');
% TintFS=irf.tint('2018-02-21T11:36:44.688Z/2018-02-21T11:37:23.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\02\21\mms1_fpi_brst_l2_dis-moms_20180221113423_v3.3.0.cdf');
% % %case#8
% % % demo case
% % %case#9 注意 频率
% trangeLoadData=('2018-12-10T04:40:23.000Z/2018-12-10T04:42:13.000Z');
% TintEBSP=irf.tint('2018-12-10T04:41:40.000Z/2018-12-10T04:42:00.000Z');
% TintShow=irf.tint('2018-12-10T04:41:45.000Z/2018-12-10T04:41:55.000Z');
% %
% tShock=irf.time_array('2018-12-10T04:41:48.625Z');
% TintAll=irf.tint('2018-12-10T04:40:23.000Z/2018-12-10T04:42:13.000Z');
% TintSW=irf.tint('2018-12-10T04:40:23.000Z/2018-12-10T04:40:57.000Z');
% TintFT=irf.tint('2018-12-10T04:40:57.000Z/2018-12-10T04:41:48.625Z');
% TintFS=irf.tint('2018-12-10T04:41:48.625Z/2018-12-10T04:42:13.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210044023_v3.3.0.cdf');
% % % case#10 注意持续时间
% caseCutBrst=2;
% trangeLoadData=('2018-12-10T05:48:00.000Z/2018-12-10T05:50:30.000Z');
% TintEBSP=irf.tint('2018-12-10T05:49:45.000Z/2018-12-10T05:50:10.000Z');
% TintShow=irf.tint('2018-12-10T05:49:50.000Z/2018-12-10T05:50:05.000Z');
% %
% tShock=irf.time_array('2018-12-10T05:49:54.560Z');
% TintAll=irf.tint('2018-12-10T05:48:00.000Z/2018-12-10T05:50:30.000Z');
% TintSW=irf.tint('2018-12-10T05:48:00.000Z/2018-12-10T05:48:30.000Z');
% TintFT=irf.tint('2018-12-10T05:48:30.000Z/2018-12-10T05:49:54.560Z');
% TintFS=irf.tint('2018-12-10T05:49:54.560Z/2018-12-10T05:50:30.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210054723_v3.3.0.cdf');
% cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210054943_v3.3.0.cdf');
% % % case#11
% caseCutBrst=2;
% trangeLoadData=('2018-12-10T06:27:30.000Z/2018-12-10T06:29:23.000Z');
% Tint=irf.tint(trangeLoadData);
% TintEBSP=irf.tint('2018-12-10T06:28:45.000Z/2018-12-10T06:29:05.000Z');
% TintShow=irf.tint('2018-12-10T06:28:45.000Z/2018-12-10T06:29:05.000Z');
% %
% tShock=irf.time_array('2018-12-10T06:28:55.750Z');
% TintAll=irf.tint('2018-12-10T06:27:30.000Z/2018-12-10T06:29:23.000Z');
% TintSW=irf.tint('2018-12-10T06:27:30.000Z/2018-12-10T06:27:56.000Z');
% TintFT=irf.tint('2018-12-10T06:27:56.000Z/2018-12-10T06:28:55.750Z');
% TintFS=irf.tint('2018-12-10T06:28:55.750Z/2018-12-10T06:29:23.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210062703_v3.3.0.cdf');
% cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210062853_v3.3.0.cdf');
% % % case#12 注意这个事件的性质
% caseCutBrst=1;
% trangeLoadData=('2019-01-18T21:03:13.000Z/2019-01-18T21:04:13.000Z');
% TintEBSP=irf.tint('2019-01-18T21:03:50.000Z/2019-01-18T21:04:13.000Z');
% TintShow=irf.tint('2019-01-18T21:03:50.000Z/2019-01-18T21:04:13.000Z');
% %
% %Bsumthres=1e-2;
% %
% tShock=irf.time_array('2019-01-18T21:03:54.000Z');
% TintAll=irf.tint('2019-01-18T21:03:13.000Z/2019-01-18T21:04:13.000Z');
% TintSW=irf.tint('2019-01-18T21:03:13.000Z/2019-01-18T21:03:14.000Z');
% TintFT=irf.tint('2019-01-18T21:03:14.000Z/2019-01-18T21:03:54.000Z');
% TintFS=irf.tint('2019-01-18T21:03:54.000Z/2019-01-18T21:04:13.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2019\01\18\mms1_fpi_brst_l2_dis-moms_20190118210313_v3.3.0.cdf');
% % % case#13 
% caseCutBrst=1;
% trangeLoadData=('2019-12-06T05:12:03.000Z/2019-12-06T05:15:00.000Z');
% TintEBSP=irf.tint('2019-12-06T05:13:50.000Z/2019-12-06T05:14:10.000Z');
% TintShow=irf.tint('2019-12-06T05:13:50.000Z/2019-12-06T05:14:10.000Z');
% %
% tShock=irf.time_array('2019-12-06T05:13:54.688Z');
% TintAll=irf.tint('2019-12-06T05:12:03.000Z/2019-12-06T05:15:00.000Z');
% TintSW=irf.tint('2019-12-06T05:12:03.000Z/2019-12-06T05:12:55.000Z');
% TintFT=irf.tint('2019-12-06T05:12:55.000Z/2019-12-06T05:13:54.688Z');
% TintFS=irf.tint('2019-12-06T05:13:54.688Z/2019-12-06T05:15:00.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2019\12\06\mms1_fpi_brst_l2_dis-moms_20191206051033_v3.3.0.cdf');
% % % case#14
% caseCutBrst=1;
% trangeLoadData=('2020-03-20T19:46:33.000Z/2020-03-20T19:47:53.000Z');
% TintEBSP=irf.tint('2020-03-20T19:47:20.000Z/2020-03-20T19:47:50.000Z');
% TintShow=irf.tint('2020-03-20T19:47:20.000Z/2020-03-20T19:47:50.000Z');
% %
% tShock=irf.time_array('2020-03-20T19:47:26.813Z');
% TintAll=irf.tint('2020-03-20T19:46:33.000Z/2020-03-20T19:47:53.000Z');
% TintSW=irf.tint('2020-03-20T19:46:33.000Z/2020-03-20T19:47:03.000Z');
% TintFT=irf.tint('2020-03-20T19:47:03.000Z/2020-03-20T19:47:26.813Z');
% TintFS=irf.tint('2020-03-20T19:47:26.813Z/2020-03-20T19:47:53.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2020\03\20\mms1_fpi_brst_l2_dis-moms_20200320194633_v3.3.0.cdf');
% % % case#15
% caseCutBrst=2;
% trangeLoadData=('2021-01-12T01:19:03.000Z/2021-01-12T01:20:30.000Z');
% TintEBSP=irf.tint('2021-01-12T01:19:55.000Z/2021-01-12T01:20:15.000Z');
% TintShow=irf.tint('2021-01-12T01:19:55.000Z/2021-01-12T01:20:15.000Z');
% %
% tShock=irf.time_array('2021-01-12T01:19:01.560Z');
% TintAll=irf.tint('2021-01-12T01:19:03.000Z/2021-01-12T01:20:30.000Z');
% TintSW=irf.tint('2021-01-12T01:19:03.000Z/2021-01-12T01:19:10.000Z');
% TintFT=irf.tint('2021-01-12T01:19:10.000Z/2021-01-12T01:20:01.560Z');
% TintFS=irf.tint('2021-01-12T01:20:01.560Z/2021-01-12T01:20:30.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\01\12\mms1_fpi_brst_l2_dis-moms_20210112011753_v3.3.0.cdf');
% cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\01\12\mms1_fpi_brst_l2_dis-moms_20210112011933_v3.3.0.cdf');
% % %case#16
% caseCutBrst=1;
% trangeLoadData=('2021-01-27T00:59:53.000Z/2021-01-27T01:02:13.000Z');
% TintEBSP=irf.tint('2021-01-27T01:01:45.000Z/2021-01-27T01:02:05.000Z');
% TintShow=irf.tint('2021-01-27T01:01:45.000Z/2021-01-27T01:02:05.000Z');
% %
% tShock=irf.time_array('2021-01-27T01:01:53.938Z');
% TintAll=irf.tint('2021-01-27T00:59:53.000Z/2021-01-27T01:02:13.000Z');
% TintSW=irf.tint('2021-01-27T00:59:53.000Z/2021-01-27T01:00:07.000Z');
% TintFT=irf.tint('2021-01-27T01:00:07.000Z/2021-01-27T01:01:53.938Z');
% TintFS=irf.tint('2021-01-27T01:01:53.938Z/2021-01-27T01:02:13.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\01\27\mms1_fpi_brst_l2_dis-moms_20210127005953_v3.3.0.cdf');
% % %case#17
% caseCutBrst=1;
% trangeLoadData=('2021-02-27T12:56:05.000Z/2021-02-27T12:58:23.000Z');
% TintEBSP=irf.tint('2021-02-27T12:57:45.000Z/2021-02-27T12:58:05.000Z');
% TintShow=irf.tint('2021-02-27T12:57:45.000Z/2021-02-27T12:58:05.000Z');
% %
% tShock=irf.time_array('2021-02-27T12:57:39.438Z');
% TintAll=irf.tint('2021-02-27T12:56:05.000Z/2021-02-27T12:58:23.000Z');
% TintSW=irf.tint('2021-02-27T12:56:05.000Z/2021-02-27T12:57:25.000Z');
% TintFT=irf.tint('2021-02-27T12:57:25.000Z/2021-02-27T12:57:49.438Z');
% TintFS=irf.tint('2021-02-27T12:57:49.438Z/2021-02-27T12:58:23.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\02\27\mms1_fpi_brst_l2_dis-moms_20210227125603_v3.3.0.cdf');
% % %case#18
% caseCutBrst=1;
% trangeLoadData=('2021-03-05T20:26:33.000Z/2021-03-05T20:27:43.000Z');
% TintEBSP=irf.tint('2021-03-05T20:27:00.000Z/2021-03-05T20:27:20.000Z');
% TintShow=irf.tint('2021-03-05T20:27:05.000Z/2021-03-05T20:27:15.000Z');
% %
% %Bsumthres=1e-0;%%1e-1
% %
% tShock=irf.time_array('2021-03-05T20:27:09.000Z');
% TintAll=irf.tint('2021-03-05T20:26:33.000Z/2021-03-05T20:27:43.000Z');
% TintSW=irf.tint('2021-03-05T20:26:33.000Z/2021-03-05T20:26:45.000Z');
% TintFT=irf.tint('2021-03-05T20:26:45.000Z/2021-03-05T20:27:09.000Z');
% TintFS=irf.tint('2021-03-05T20:27:09.000Z/2021-03-05T20:27:43.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\03\05\mms1_fpi_brst_l2_dis-moms_20210305202633_v3.3.0.cdf');
% % %case#19
% caseCutBrst=1;
% trangeLoadData=('2021-03-20T19:28:33.000Z/2021-03-20T19:30:00.000Z');
% TintEBSP=irf.tint('2021-03-20T19:29:30.000Z/2021-03-20T19:30:00.000Z');
% TintShow=irf.tint('2021-03-20T19:29:30.000Z/2021-03-20T19:30:00.000Z');
% %
% %
% tShock=irf.time_array('2021-03-20T19:29:38.000Z');
% TintAll=irf.tint('2021-03-20T19:28:33.000Z/2021-03-20T19:30:00.000Z');
% TintSW=irf.tint('2021-03-20T19:28:33.000Z/2021-03-20T19:29:03.000Z');
% TintFT=irf.tint('2021-03-20T19:29:03.000Z/2021-03-20T19:29:38.000Z');
% TintFS=irf.tint('2021-03-20T19:29:38.000Z/2021-03-20T19:30:00.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\03\20\mms1_fpi_brst_l2_dis-moms_20210320192833_v3.3.0.cdf');
% % %case#20
% caseCutBrst=1;
% trangeLoadData=('2021-04-18T01:51:00.000Z/2021-04-18T01:53:00.000Z');
% TintEBSP=irf.tint('2021-04-18T01:52:35.000Z/2021-04-18T01:52:55.000Z');
% TintShow=irf.tint('2021-04-18T01:52:35.000Z/2021-04-18T01:52:55.000Z');
% %
% %
% tShock=irf.time_array('2021-04-18T01:52:39.563Z');
% TintAll=irf.tint('2021-04-18T01:51:00.000Z/2021-04-18T01:53:00.000Z');
% TintSW=irf.tint('2021-04-18T01:51:00.000Z/2021-04-18T01:51:23.000Z');
% TintFT=irf.tint('2021-04-18T01:51:23.000Z/2021-04-18T01:52:39.563Z');
% TintFS=irf.tint('2021-04-18T01:52:39.563Z/2021-04-18T01:53:00.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\04\18\mms1_fpi_brst_l2_dis-moms_20210418015023_v3.3.0.cdf');
% % %case#21
% caseCutBrst=1;
% trangeLoadData=('2021-12-07T13:23:43.000Z/2021-12-07T13:24:35.000Z');
% TintEBSP=irf.tint('2021-12-07T13:24:15.000Z/2021-12-07T13:24:35.000Z');
% TintShow=irf.tint('2021-12-07T13:24:15.000Z/2021-12-07T13:24:35.000Z');
% %
% %
% tShock=irf.time_array('2021-12-07T13:24:18.000Z');
% TintAll=irf.tint('2021-12-07T13:23:43.000Z/2021-12-07T13:24:35.000Z');
% TintSW=irf.tint('2021-12-07T13:23:43.000Z/2021-12-07T13:23:57.000Z');
% TintFT=irf.tint('2021-12-07T13:23:57.000Z/2021-12-07T13:24:18.000Z');
% TintFS=irf.tint('2021-12-07T13:24:18.000Z/2021-12-07T13:24:35.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\12\07\mms1_fpi_brst_l2_dis-moms_20211207132343_v3.4.0.cdf');
% 
% % %case#22
% caseCutBrst=2;
% trangeLoadData=('2021-12-18T05:06:00.000Z/2021-12-18T05:06:50.000Z');
% TintEBSP=irf.tint('2021-12-18T05:06:20.000Z/2021-12-18T05:06:40.000Z');
% TintShow=irf.tint('2021-12-18T05:06:20.000Z/2021-12-18T05:06:40.000Z');
% %
% % Bsumthres=1e-2;%%1e-1
% %
% tShock=irf.time_array('2021-12-18T05:06:26.563Z');
% TintAll=irf.tint('2021-12-18T05:06:00.000Z/2021-12-18T05:06:50.000Z');
% TintSW=irf.tint('2021-12-18T05:06:00.000Z/2021-12-18T05:06:10.000Z');
% TintFT=irf.tint('2021-12-18T05:06:10.000Z/2021-12-18T05:06:26.563Z');
% TintFS=irf.tint('2021-12-18T05:06:26.563Z/2021-12-18T05:06:50.000Z');
% cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\12\18\mms1_fpi_brst_l2_dis-moms_20211218050413_v3.4.0.cdf');
% cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2021\12\18\mms1_fpi_brst_l2_dis-moms_20211218050633_v3.4.0.cdf');

%% 2.0 Load energy spectrum data
switch caseCutBrst
    case 1
        infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile1);
        epochData1 = spdfcdfread(cdfFPIFile1, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
        ionEnergyChannel1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energy_brst');
        ionEnergyspectr1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energyspectr_omni_brst');%600*32
         % %
        epochArr=[epochData1];
        unixEpoch=EpochUnix(epochArr);
        epochSpec=unixEpoch.epoch;
        ionEnergyChannel=[ionEnergyChannel1];
        spectrArr=[ionEnergyspectr1];
        ionEnerSpe=struct('t',epochSpec);
        ionEnerSpe.f=ionEnergyChannel;
        ionEnerSpe.p=spectrArr;
        ionEnerSpe.f_label={'Energy (eV)'};
        ionEnerSpe.p_label={'Eflux'};
        ionEnerSpe.p_label={['keV/(cm^2 s sr keV)']};%{'keV/(cm^2 s sr keV)'}
        ionEnerSpe.plot_type=['log'];
    case 2
        infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile1);
        epochData1 = spdfcdfread(cdfFPIFile1, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
        ionEnergyChannel1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energy_brst');
        ionEnergyspectr1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energyspectr_omni_brst');%600*32
        infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile2);
        epochData2 = spdfcdfread(cdfFPIFile2, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
        ionEnergyChannel2=spdfcdfread(cdfFPIFile2,'Variables','mms1_dis_energy_brst');
        ionEnergyspectr2=spdfcdfread(cdfFPIFile2,'Variables','mms1_dis_energyspectr_omni_brst');%600*32

        epochArr=[epochData1;epochData2];
        unixEpoch=EpochUnix(epochArr);
        epochSpec=unixEpoch.epoch;
        ionEnergyChannel=[ionEnergyChannel1;ionEnergyChannel2];
        spectrArr=[ionEnergyspectr1;ionEnergyspectr2];
        ionEnerSpe=struct('t',epochSpec);
        ionEnerSpe.f=ionEnergyChannel;
        ionEnerSpe.p=spectrArr;
        ionEnerSpe.f_label={'Energy (eV)'};
        ionEnerSpe.p_label={'Eflux'};
        ionEnerSpe.p_label={['keV/(cm^2 s sr keV)']};%{'keV/(cm^2 s sr keV)'}
        ionEnerSpe.plot_type=['log'];
end

%
%% 2. Load data
epochUnixInterested=TintInterested.epochUnix;
Tint=irf.tint(trangeLoadData);
Tintl = Tint+[-100 100];
R  = mms.get_data('R_gse',Tintl);
c_eval('Rxyz = irf.ts_vec_xyz(R.time,R.gseR?);',ic);
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',ic);
c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',Tint);',ic);%load data
c_eval('ne = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',Tint);',ic);
c_eval('ni = mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_numberdensity_brst'',Tint);',ic);
c_eval('Vxyz=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',Tint);',ic);
% %
c_eval('neSRVY0 = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintEBSP);',ic);
c_eval('BxyzSRVY=mms.db_get_ts(''mms?_fgm_srvy_l2'',''mms?_fgm_b_gse_srvy_l2'',TintEBSP);',ic);
c_eval('BxyzBRST=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintEBSP);',ic);
%
c_eval('ExyzBRST=mms.db_get_ts(''mms?_edp_brst_l2_dce'',''mms?_edp_dce_gse_brst_l2'',TintEBSP);',ic);
%c_eval('ExyzFAST=mms.db_get_ts(''mms?_edp_fast_l2_dce'',''mms?_edp_dce_gse_fast_l2'',TintEBSP);',ic);
%
c_eval('BscmBRST=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',TintEBSP);',ic);
%%%
%%%
%% 2.1 preprocessing data
% %
magB = Bxyz.abs;
Bxyzmag = TSeries(Bxyz.time,[Bxyz.data magB.data]);
magB = BxyzSRVY.abs;
BxyztSRVY = TSeries(BxyzSRVY.time,[BxyzSRVY.data magB.data]);
% % interpolation ne to the sampling of Bxyz srvy
neSRVY=neSRVY0.resample(BxyzSRVY);
BtSRVY=BxyzSRVY.abs;
% %
arrNe=neSRVY.data;
arrBxyz=BxyzSRVY.data;
arrBt=BtSRVY.data;
% % find the upstream of FT shock 
epochBsrvy=BxyzSRVY.time.epoch;
indexMovmean=find(epochBsrvy >= tShock.epoch);
% %
arrNe0Mvm=arrNe(indexMovmean);
arrBxyz0Mvm=arrBxyz(indexMovmean,:);
arrBt0Mvm=arrBt(indexMovmean);
% % move mean data upstream of FT shock
movmeanWnd=20;
arrNe1Mvm=movmean(arrNe0Mvm,movmeanWnd,1);
arrBxyz1Mvm=movmean(arrBxyz0Mvm,movmeanWnd,1);%%%%滑动窗口可以选择
arrBt1Mvm=movmean(arrBt0Mvm,movmeanWnd,1);
% % 用滑动平均后的数据替换激波上游的数据
arrNe(indexMovmean)=arrNe1Mvm;
arrBxyz(indexMovmean,:)=arrBxyz1Mvm;
arrBt(indexMovmean)=arrBt1Mvm;
% % re-store data ti TSeries structure
neBKG=TSeries(BxyzSRVY.time,arrNe);
BxyzBKG=TSeries(BxyzSRVY.time,arrBxyz);
BtBKG=TSeries(BxyzSRVY.time,arrBt);
% %
cutBscm=size(Bscm);
if cutBscm(1) >1 || cutBscm(2) >1
    BscmCut1=Bscm{1};
    BscmCut2=Bscm{2};
    data1=BscmCut1.data;
    time1=BscmCut1.time;
    data2=BscmCut2.data;
    time2=BscmCut2.time;
    dataNew=[data1;data2];
    timeNew=[time1;time2];
    BscmNew=TSeries(timeNew,dataNew);
    Bscm=BscmNew;
end
%
cutBscm=size(BscmBRST);
if cutBscm(1) >1 || cutBscm(2) >1
    BscmCut1=BscmBRST{1};
    BscmCut2=BscmBRST{2};
    data1=BscmCut1.data;
    time1=BscmCut1.time;
    data2=BscmCut2.data;
    time2=BscmCut2.time;
    dataNew=[data1;data2];
    timeNew=[time1;time2];
    BscmNew=TSeries(timeNew,dataNew);
    BscmBRST=BscmNew;
end
%%
Units=irf_units; % read in standard units
Me=Units.me;
Mp=Units.mp;
e=Units.e;
epso=Units.eps0;
mu0=Units.mu0;
Mp_Me = Mp/Me;
%
B_SI=arrBt*1e-9;
Wpe = sqrt(neBKG.data*1e6*e^2/Me/epso);
Wce = e*B_SI/Me;
Wpp = sqrt(neBKG.data*1e6*e^2/Mp/epso);
Fce = Wce/2/pi;
Fpe = Wpe/2/pi;
Fcp = Fce/Mp_Me;
Fpp = Wpp/2/pi;
Flh = sqrt(Fcp.*Fce./(1+Fce.^2./Fpe.^2)+Fcp.^2);
Fcp = irf.ts_scalar(BxyzBKG.time,Fcp);
Fce = irf.ts_scalar(BxyzBKG.time,Fce);
Flh = irf.ts_scalar(BxyzBKG.time,Flh);
Fpp = irf.ts_scalar(BxyzBKG.time,Fpp);
%% 3. analysis
%irf_ebsp(E,dB,fullB,B0,xyz,freq_int,[OPTIONS])
polarization = irf_ebsp(ExyzBRST,BscmBRST,[],BxyzBKG,Rxyz,[0.5,100],'polarization','fac');%%%%0.5-100[0.01,100]

%BxyzBRST
%Bscm
%tsBgseFSM
frequency = polarization.f;
time = polarization.t;
Bsum = polarization.bb_xxyyzzss(:,:,4);
Bperp = polarization.bb_xxyyzzss(:,:,1)+polarization.bb_xxyyzzss(:,:,2);
Esum = polarization.ee_xxyyzzss(:,:,4);
Eperp = polarization.ee_xxyyzzss(:,:,1)+polarization.ee_xxyyzzss(:,:,2);
ellipticity = polarization.ellipticity;
dop = polarization.dop;
thetak = polarization.k_tp(:,:,1);
planarity = polarization.planarity;
pfluxz = polarization.pf_xyz(:,:,3)./sqrt(polarization.pf_xyz(:,:,1).^2+polarization.pf_xyz(:,:,2).^2+polarization.pf_xyz(:,:,3).^2);
% Calculate phase speed v_ph = E/B.
vph = sqrt(Esum./Bsum)*1e6*1e-3;%km/s
vphperp = sqrt(Eperp./Bperp)*1e6*1e-3;%km/s
%
%%
% Remove points with very low B amplitutes
removepts = find(Bsum < Bsumthres | planarity < planthres);
ellipticity(removepts) = NaN;
thetak(removepts) = NaN;
dop(removepts) = NaN;
planarity(removepts) = NaN;
pfluxz(removepts) = NaN;
vph(removepts) = NaN;
vphperp(removepts) = NaN;

%%
interest=find(time >= epochUnixInterested(1) | time <= epochUnixInterested(2));
%% 4. Plot Figure
% 4.0. basic
npanel = 11;
hFrst=irf_plot(npanel,'newfigure');
delete(hFrst(6));
hFrst(6)=[];					% remove handle
%xSize=2100/2; ySize=2970/2;

xSize=900;ySize=900;
set(gcf,'Position',[10 10 xSize ySize]);
xwidth = 0.70;      ywidth = 0.07;
set(hFrst(1),'position',[0.17 0.97-ywidth*1 xwidth ywidth/2]);
c_eval('set(hFrst(?),''position'',[0.17 0.97-ywidth*? xwidth ywidth]);', 2:5);
set(hFrst(6),'position',[0.17 0.97-ywidth*7 xwidth ywidth]);
set(hFrst(7),'position',[0.17 0.97-ywidth*8 xwidth ywidth]);
set(hFrst(8),'position',[0.17 0.97-ywidth*9 xwidth ywidth]);
set(hFrst(9),'position',[0.17 0.97-ywidth*10 xwidth ywidth]);
set(hFrst(10),'position',[0.17 0.97-ywidth*11 xwidth ywidth]);
%set(h(11),'position',[0.17 0.97-ywidth*12 xwidth ywidth]);


%
ip=0;
ip = ip+1;
hFrst(ip)=irf_panel('Bar');
c_eval('BarAll = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintAll);',ic);
c_eval('BarSW = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintSW);',ic);
c_eval('BarFT = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintFT);',ic);
c_eval('BarFS = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintFS);',ic);
BarSW=ones(size(BarSW.data,1),3);
BarFT=ones(size(BarFT.data,1),3)*2;
BarFS=ones(size(BarFS.data,1),3)*1;
hold on;
%irf_spectrogram(hFrst(ip),BarSW,'lin');


unixEpoch=EpochUnix(BarAll.time.epoch);
epochSpec=unixEpoch.epoch;
barSpe=struct('t',epochSpec);
barSpe.f=[1;2;3];
barSpe.p=[BarSW;BarFT;BarFS];
barSpe.f_label={};
barSpe.p_label={};
barSpe.p_label={};
%barSpe.plot_type='lin';
irf_spectrogram(hFrst(ip),barSpe,'lin', 'donotshowcolorbar' );
set(hFrst(ip),'ytick',[ ]);
trpMap = [0 153 255
    255 102 0]/256;
%0 153 51]/256;
colormap(hFrst(ip),trpMap);
% text(hFrst(1),0.5,2,'Solar wind','FontSize',myFontSize+2);
% text(hFrst(1),36,2,'Foreshock transient','FontSize',myFontSize+2);
% text(hFrst(1),93,2,'Solar wind','FontSize',myFontSize+2);
%text(hFrst(1),90,5,'FT shock','FontSize',myFontSize+2);
% 4.1. Bxyz
ip = ip+1;
hFrst(ip)=irf_panel('Bfgm');
irf_plot(hFrst(ip), Bxyzmag);
set(hFrst(ip),'ColorOrder',mmsColors)
irf_legend(hFrst(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(hFrst(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(hFrst(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(hFrst(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
hFrst(ip).YLimMode = 'auto';
%irf_zoom(hFrst(ip),'y',[-50 60]);
%set(hFrst(ip),'ylim',[-12,17]);
% yticks=[-5, 0, 5, 10, 15];
% yticklabels=[' ', '0','5','10','15'];
% set(hFrst(ip),'ytick',yticks,'yticklabel',xticklabels);
%text(hFrst(2),92,11,'\leftarrow FT shock','Color','Red','FontSize',myFontSize+2,'FontWeight','Bold');
% 4.4. Ion energy spectrom
ip=ip+1;
hFrst(ip)=irf_panel('IonEnerSpec');
irf_spectrogram(hFrst(ip),ionEnerSpe,'log','donotfitcolorbarlabel');
colormap(hFrst(ip),'jet');
hold(hFrst(ip),'off');
set(hFrst(ip),'yscale','log');
%set(hFrst(ip),'ytick',[1 1e1 1e2 1e3]);
%caxis(hFrst(ip),[2 5])
ylabel(hFrst(ip),{'','i_{+} eFlux','(eV)'},'fontsize',12);
set(hFrst(ip),'ylim',[100,20000]);%[17800]

% 4.2 Ni Ne
ip=ip+1;
hFrst(ip)=irf_panel('Nplasma');
axN=irf_plot(hFrst(ip), ne, 'c');
hold(hFrst(ip),'on');
irf_plot(hFrst(ip), ni, 'm');
irf_legend(hFrst(ip),{'Ni'},[1.01 0.24], 'color','m','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Ne'},[1.01 0.74], 'color','c','fontsize',myFontSize);
ylabel(hFrst(ip),{' ','Density','(cm^{-3})'},'Interpreter','tex');
%set(hFrst(ip),'ylim',[0,17]);
hFrst(ip).YLimMode = 'auto';

%4.3 Vxyz
ip=ip+1;
hFrst(ip)=irf_panel('Vxyz');
irf_plot(hFrst(ip), Vxyz);%,['b','c','m']);
set(hFrst(ip),'ColorOrder',mmsColors);
ylabel(hFrst(ip),{' ','i_{+} V','(km/s)'},'Interpreter','tex');
irf_legend(hFrst(ip),{'Vx GSE'},[1.01 0.24], 'color','b','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Vy GSE'},[1.01 0.49], 'color','c','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Vz GSE'},[1.01 0.94], 'color','m','fontsize',myFontSize);
%set(hFrst(ip),'ylim',[-750,750]);
hFrst(ip).YLimMode = 'auto';


% 4.5. Bxyz
ip = 6;
%hFrst(ip)=irf_panel('BfgmZoom');
irf_plot(hFrst(ip), Bxyzmag);
set(hFrst(ip),'ColorOrder',mmsColors)
irf_legend(hFrst(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(hFrst(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(hFrst(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(hFrst(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
%irf_zoom(hFrst(ip),'y',[-50 60]);
%set(hFrst(ip),'ylim',[-7,17]);
hFrst(ip).YLimMode = 'auto';
% %
ip=ip+1;
irf_plot(hFrst(ip),BscmBRST);
set(hFrst(ip),'ColorOrder',mmsColors)
irf_legend(hFrst(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(hFrst(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(hFrst(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
ylabel(hFrst(ip),{' ','B SCM','(nT)'},'Interpreter','tex');
%irf_zoom(hFrst(ip),'y',[-50 60]);

ip=ip+1;
%hFrst(ip)=irf_panel('Bsum');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=Bsum;
specrec.f_label='';
specrec.p_label={'log_{10}B^{2}','nT^2 Hz^{-1}'};
irf_spectrogram(hFrst(ip),specrec,'log','donotfitcolorbarlabel');
hold(hFrst(ip),'on');
irf_plot(hFrst(ip),Flh,'linewidth',1.5,'color','k')
irf_legend(hFrst(ip),'f_{lh}',[0.95 0.90],'color','k','fontsize',20);
hold(hFrst(ip),'off');
set(hFrst(ip),'yscale','log');
set(hFrst(ip),'ytick',[0.1 1 5]);
caxis(hFrst(ip),[-5 1])
ylabel(hFrst(ip),{' ','f', '(Hz)'},'fontsize',myFontSize);
set(hFrst(ip),'ylim',ylimRange);

ip=ip+1;
%hFrst(ip)=irf_panel('thetak');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=thetak;
specrec.f_label='';
specrec.p_label={'\theta_{k} (deg)'};
irf_spectrogram(hFrst(ip),specrec,'lin','donotfitcolorbarlabel');
hold(hFrst(ip),'on');
irf_plot(hFrst(ip),Flh,'linewidth',1.5,'color','k')
irf_legend(hFrst(ip),'f_{lh}',[0.95 0.90],'color','k','fontsize',20);
hold(hFrst(ip),'off');
set(hFrst(ip),'yscale','log');
set(hFrst(ip),'ytick',[0.1 1 5]);
caxis(hFrst(ip),[0, 90])
ylabel(hFrst(ip),{' ', 'f', '(Hz)'},'fontsize',myFontSize);
set(hFrst(ip),'ylim',ylimRange);


% ip=ip+1;
% %hFrst(ip)=irf_panel('planarity');
% specrec=struct('t',time);
% specrec.f=frequency;
% specrec.p=planarity;
% specrec.f_label='';
% specrec.p_label={'Planarity'};
% irf_spectrogram(hFrst(ip),specrec,'lin','donotfitcolorbarlabel');
% hold(hFrst(ip),'on');
% irf_plot(hFrst(ip),Flh,'linewidth',1.5,'color','w')
% hold(hFrst(ip),'off');
% set(hFrst(ip),'yscale','log');
% set(hFrst(ip),'ytick',[0.1 1 5]);
% caxis(hFrst(ip),[0, 1])
% ylabel(hFrst(ip),{' ', 'f', '(Hz)'},'fontsize',12);
% set(hFrst(ip),'ylim',ylimRange);

ip=ip+1;
%hFrst(ip)=irf_panel('ellipt');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=ellipticity;
specrec.f_label='';
specrec.p_label={'Ellipticity'};
irf_spectrogram(hFrst(ip),specrec,'lin','donotfitcolorbarlabel');
%irf_legend(hFrst(ip),'(i)',[0.99 0.98],'color','w','fontsize',12)
hold(hFrst(ip),'on');
irf_plot(hFrst(ip),Flh,'linewidth',1.5,'color','k')
irf_legend(hFrst(ip),'f_{lh}',[0.95 0.90],'color','k','fontsize',20);
hold(hFrst(ip),'off');
set(hFrst(ip),'yscale','log');
set(hFrst(ip),'ytick',[0.1 1 5]);
caxis(hFrst(ip),[-1, 1])
ylabel(hFrst(ip),{' ', 'f', '(Hz)'},'fontsize',12);
set(hFrst(ip),'ylim',ylimRange);
%%-------------------------------------------------------------------------

% Remove grid and set background to grey
set(hFrst(8:10),'xgrid','off','ygrid','off')
set(hFrst(8:10),'Color',0.7*[1 1 1]);

% Define blue-red colormap
rr = interp1([1 64 128 192 256],[0.0  0.5 0.75 1.0 0.75],1:256);
gg = interp1([1 64 128 192 256],[0.0  0.5 0.75 0.5 0.00],1:256);
bb = interp1([1 64 128 192 256],[0.75 1.0 0.75 0.5 0.00],1:256);
bgrcmap = [rr' gg' bb'];

colormap(hFrst(8),'jet');
colormap(hFrst(9),'jet');
colormap(hFrst(10),bgrcmap);
%colormap(hFrst(11),bgrcmap);

% irf_pl_number_subplots(h,[.03,.93],'num','\bf{(?)}','fontsize',18,...
%   'interpreter','latex','backgroundcolor','w','edgecolor','k','linewidth',1.8)
%irf_pl_number_subplots(hFrst(2:11),[.01,.95],'fontsize',18);

irf_pl_number_subplots(hFrst(2:10),[.01,.95],'num','(?)','fontsize',18,...
    'interpreter','tex','linewidth',1.8)
irf_zoom(hFrst(1: 5),'x',Tint);
irf_plot_axis_align(hFrst(1: 10));
irf_zoom(hFrst(6:10),'x',TintShow);
%irf_plot_axis_align(hFrst(6: 6));
irf_plot_zoomin_lines_between_panels(hFrst(5),hFrst(6));

% add tmarks and mark intervals
% add line marks
tmarks=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');
irf_pl_mark(hFrst(6:10),tmarks,'black','LineWidth',0.5)

% 4.X. global
%load('caa/cmap.mat');
%c_eval('title(hFrst(1),''MMS?'')',ic);


set(hFrst(2: 10),'fontsize',myFontSize);

%irf_zoom(h,'x',Tint);




%%%align aix
%%
figAName=sprintf('FT_FT_shock_field_spctrm_%s%s%s_%s%s%s',...
    trangeLoadData(1:4),trangeLoadData(6:7),trangeLoadData(9:10),...
    trangeLoadData(12:13),trangeLoadData(15:16),trangeLoadData(18:19));
exportgraphics(gcf,[figAName,'.png'],'Resolution',300)
exportgraphics(gcf,[figAName,'.pdf'],'ContentType','vector')%vector
exportgraphics(gcf,[figAName,'.emf'])
%% Plot the data before and after moving-average
npanel = 6;
hScnd=irf_plot(npanel,'newfigure');
ip=0;
set(gcf,'PaperUnits','centimeters')
xSize = 12; ySize = 14;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(gcf,'PaperPosition',[xLeft yTop xSize ySize])
set(gcf,'Position',[10 10 xSize*50 ySize*50])
set(gcf,'paperpositionmode','auto') % to get the same printing as on screen
clear xLeft xSize sLeft ySize yTop
% additional good options
set(gcf,'defaultAxesFontSize',14);
set(gcf,'defaultTextFontSize',14);
set(gcf,'defaultAxesFontUnits','pixels');
set(gcf,'defaultTextFontUnits','pixels');
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd,'BxyzSRVY');
irf_plot(hScnd(ip),BxyzSRVY);
set(hScnd(ip),'ColorOrder',mmsColors)
irf_legend(hScnd(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(hScnd(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(hScnd(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd,'BxyzBKG');
irf_plot(hScnd(ip),BxyzBKG);
set(hScnd(ip),'ColorOrder',mmsColors)
irf_legend(hScnd(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(hScnd(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(hScnd(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd,'BtSRVY');
irf_plot(hScnd(ip),BtSRVY);
irf_legend(hScnd(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd, 'BtBKG');
irf_plot(hScnd(ip),BtBKG);
irf_legend(hScnd(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd,'NeSRVY');
irf_plot(hScnd(ip),neSRVY);
irf_legend(hScnd(ip),{'Ne'},[1.01 0.74], 'color','c','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','Density','(cm^{-3})'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
% %
ip=ip+1;
hScnd(ip)=irf_panel(hScnd,'NeBKG');
irf_plot(hScnd(ip),neBKG);
irf_legend(hScnd(ip),{'Ne'},[1.01 0.74], 'color','c','fontsize',myFontSize);
ylabel(hScnd(ip),{' ','Density','(cm^{-3})'},'Interpreter','tex');
hScnd(ip).YLimMode = 'auto';
irf_plot_axis_align(hScnd(1: npanel));
irf_zoom(hScnd(1:npanel),'x',TintShow);

figBName=sprintf('FT_shock_bkg_field_%s%s%s_%s%s%s',...
    trangeLoadData(1:4),trangeLoadData(6:7),trangeLoadData(9:10),...
    trangeLoadData(12:13),trangeLoadData(15:16),trangeLoadData(18:19));
exportgraphics(gcf,[figBName,'.png'],'Resolution',300)
exportgraphics(gcf,[figBName,'.pdf'],'ContentType','vector')%vector
exportgraphics(gcf,[figBName,'.emf'])