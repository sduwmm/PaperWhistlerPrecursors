%%load and create ion energy spectrom 
%%Epoch
%%mms1_dis_energyspectr_omni_brst
%mobmeanWnd=300;
%arrBxyzMovmean=movmean(arrBxyz,mobmeanWnd,1);%%%%滑动窗口可以选择
clear all;
close all;
%% init----------------------------------------------------------->
ic = 1; % Spacecraft number
mmsColors=[0 0 1;0 1 1; 1 0 1; 0 0 0];
myFontSize=12;
% %%%init<-------------------------------------------------------------------
% %Tint=irf.tint('2018-12-10T04:18:30.000Z/2018-12-10T04:20:20.000Z');
% % Tint=irf.tint('2019-01-18T21:03:23.000Z/2019-01-18T21:04:13.000');
% % TintShock=irf.tint('2019-01-18T21:03:50.000Z/2019-01-18T21:04:13.000');
% % TintBbkg=irf.tint('2019-01-18T21:04:00.000Z/2019-01-18T21:04:10.000');
% % %%case 1
% Tint=irf.tint('2017-12-01T14:39:33.000Z/2017-12-01T14:41:30.000Z');
% TintShock=irf.tint('2017-12-01T14:40:57.00Z/2017-12-01T14:41:04.000Z');
% TintBbkg=irf.tint('2017-12-01T14:41:00.100Z/2017-12-01T14:41:02.100Z');
% TintDown=irf.tint('2017-12-01T14:40:56.900Z/2017-12-01T14:40:57.100Z');
% TintUp=irf.tint('2017-12-01T14:41:00.00Z/2017-12-01T14:41:05.000Z');
% 
% % %%%2
% % matName='FT_20171217_175200.mat';
Tint     =irf.tint('2017-12-17T17:53:10.000Z/2017-12-17T17:53:50.000Z');
TintShock=irf.tint('2017-12-17T17:53:18.000Z/2017-12-17T17:53:24.000Z');
TintBbkg =irf.tint('2017-12-17T17:53:20.600Z/2017-12-17T17:53:24.000Z');
TintDown=irf.tint('2017-12-17T17:53:18.200Z/2017-12-17T17:53:19.800Z');
TintUp=irf.tint('2017-12-17T17:53:20.400Z/2017-12-17T17:53:23.000Z');

% % %3
% % matName='FT_20171218_125500.mat';
% Tint     =irf.tint('2017-12-18T12:55:13.000Z/2017-12-18T12:57:43.000Z');
% TintShock=irf.tint('2017-12-18T12:56:45.000Z/2017-12-18T12:56:55.000Z');
% TintBbkg =irf.tint('2017-12-18T12:56:49.000Z/2017-12-18T12:56:54.000Z');
% % %%4
% % matName='FT_20171229_191000.mat';
% Tint     =irf.tint('2017-12-29T19:10:20.000Z/2017-12-29T19:12:00.000Z');
% TintShock=irf.tint('2017-12-29T19:11:30.000Z/2017-12-29T19:11:45.000Z');
% TintBbkg =irf.tint('2017-12-29T19:11:36.000Z/2017-12-29T19:11:41.000Z');
% TintDown =irf.tint('2017-12-29T19:11:35.000Z/2017-12-29T19:11:35.300Z');
% TintUp =irf.tint('2017-12-29T19:11:37.000Z/2017-12-29T19:11:45.000Z');

% % % %%%5
% % % matName='FT_20180109_083400.mat';
Tint     =irf.tint('2018-01-09T08:34:23.000Z/2018-01-09T08:35:03.000Z');
TintShock=irf.tint('2018-01-09T08:34:50.000Z/2018-01-09T08:35:00.000Z');
TintBbkg =irf.tint('2018-01-09T08:34:51.800Z/2018-01-09T08:34:56.800Z');
TintDown = irf.tint('2018-01-09T08:34:51.000Z/2018-01-09T08:34:51.500Z');
%TintUp = irf.tint('2018-01-09T08:34:52.000Z/2018-01-09T08:34:54.000Z');
TintUp = irf.tint('2018-01-09T08:34:52.000Z/2018-01-09T08:35:15.000Z');


% Tint=irf.tint('2018-01-12T02:59:13.000Z/2018-01-12T03:00:13.000Z');
% TintShock=irf.tint('2018-01-12T02:59:50.000Z/2018-01-12T03:00:12.000Z');
% TintBbkg=irf.tint('2018-01-12T02:59:58.000Z/2018-01-12T03:00:10.000Z');
% % % %%%6
% % matName='FT_20180131_231600.mat';
% Tint     =irf.tint('2018-01-31T23:16:00.000Z/2018-01-31T23:19:00.300Z');
% TintShock=irf.tint('2018-01-31T23:17:10.000Z/2018-01-31T23:17:30.000Z');
% TintBbkg =irf.tint('2018-01-31T23:17:20.000Z/2018-01-31T23:17:26.500Z');
% % % %%%7
% % matName='FT_20180204_103700.mat';
% Tint     =irf.tint('2018-02-04T10:37:20.000Z/2018-02-04T10:38:53.000Z');
% TintShock=irf.tint('2018-02-04T10:38:10.000Z/2018-02-04T10:38:20.000Z');
% TintBbkg =irf.tint('2018-02-04T10:38:13.000Z/2018-02-04T10:38:20.000Z');
% % %%%8
% matName='FT_20180217_194500.mat';
% Tint     =irf.tint('2018-02-17T19:45:33.000Z/2018-02-17T19:46:53.000Z');
% TintShock=irf.tint('2018-02-17T19:46:27.000Z/2018-02-17T19:46:36.000Z');
% TintBbkg =irf.tint('2018-02-17T19:46:32.000Z/2018-02-17T19:46:36.000Z');
% % %%%9
% % matName='FT_20180221_113400.mat';
% Tint     =irf.tint('2018-02-21T11:34:23.000Z/2018-02-21T11:37:23.000Z');
% TintShock=irf.tint('2018-02-21T11:36:40.000Z/2018-02-21T11:36:50.000Z');
% TintBbkg =irf.tint('2018-02-21T11:36:44.000Z/2018-02-21T11:36:50.000Z');
% % %%%10
% %matName='FT_20181210_041800.mat';
% Tint     =irf.tint('2018-12-10T04:19:15.000Z/2018-12-10T04:20:53.000Z');
% TintShock=irf.tint('2018-12-10T04:20:00.000Z/2018-12-10T04:20:06.000Z');
% TintBbkg =irf.tint('2018-12-10T04:20:02.000Z/2018-12-10T04:20:05.000Z');
% % 11
% %matName='FT_20181210_044000.mat';
% %%%case 11
% Tint     =irf.tint('2018-12-10T04:40:23.000Z/2018-12-10T04:42:13.000Z');
% TintShock=irf.tint('2018-12-10T04:41:45.000Z/2018-12-10T04:41:55.000Z');
% TintBbkg =irf.tint('2018-12-10T04:41:48.700Z/2018-12-10T04:41:50.000Z');
% TintDown =irf.tint('2018-12-10T04:41:47.000Z/2018-12-10T04:41:48.000Z');
% TintUp =irf.tint('2018-12-10T04:41:49.000Z/2018-12-10T04:41:54.000Z');

% % %%%12
% % matName='FT_20181210_054700.mat';
% Tint=irf.tint('2018-12-10T05:47:23.000Z/2018-12-10T05:52:03.000Z');
% TintShock=irf.tint('2018-12-10T05:49:52.000Z/2018-12-10T05:50:00.000Z');
% TintBbkg=irf.tint('2018-12-10T05:49:55.000Z/2018-12-10T05:50:00.000Z');
% % %%%13
% matName='FT_20181210_062700.mat';
% Tint=irf.tint('2018-12-10T06:27:03.000Z/2018-12-10T06:30:53.000Z');
% TintShock=irf.tint('2018-12-10T06:28:55.000Z/2018-12-10T06:29:00.000Z');
% TintBbkg=irf.tint('2018-12-10T06:28:56.000Z/2018-12-10T06:29:00.000Z');
% TintDown=irf.tint('2018-12-10T06:28:55.250Z/2018-12-10T06:28:55.500Z');
% TintUp=irf.tint('2018-12-10T06:28:56.000Z/2018-12-10T06:28:58.000Z');

% % %%%14
% matName='FT_20190105_173700.mat';
% Tint=irf.tint('2019-01-05T17:37:53.000Z/2019-01-05T17:41:53.000Z');
% TintShock=irf.tint('2019-01-05T17:40:20.000Z/2019-01-05T17:40:45.000Z');
% TintBbkg=irf.tint('2019-01-05T17:40:30.000Z/2019-01-05T17:40:36.000Z');



% Tint=irf.tint('2019-01-18T21:03:14.000Z/2019-01-18T21:04:13.000Z');
% TintShock=irf.tint('2019-01-18T21:03:44.000Z/2019-01-18T21:04:13.000Z');
% TintBbkg=irf.tint('2019-01-18T21:04:02.000Z/2019-01-18T21:04:08.000Z');
% TintDown=irf.tint('2019-01-18T21:03:49.000Z/2019-01-18T21:03:51.000Z');
% TintUp=irf.tint('2019-01-18T21:03:56.000Z/2019-01-18T21:04:00.000Z');
% % % % %%%15
% % matName='FT_20191206_051200.mat';
% Tint=irf.tint('2019-12-06T05:10:33.000Z/2019-12-06T05:15:00.000Z');
% TintShock=irf.tint('2019-12-06T05:13:52.000Z/2019-12-06T05:14:02.000Z');
% TintBbkg=irf.tint('2019-12-06T05:13:55.000Z/2019-12-06T05:14:02.000Z');
% % %%%16
% % % matName='FT_20200304_034100.mat';%%%%check---------------------------->
% Tint=irf.tint('2020-03-04T03:41:03.000Z/2020-03-04T03:43:23.000Z');
% TintShock=irf.tint('2020-03-04T03:42:10.000Z/2020-03-04T03:42:30.000Z');
% TintBbkg=irf.tint('2020-03-04T03:42:21.800Z/2020-03-04T03:42:22.550Z');%%Bx By Bz
%%%%%case#
% Tint=irf.tint('2020-03-20T19:46:33.000Z/2020-03-20T19:47:45.000Z');
% TintShock=irf.tint('2020-03-20T19:47:20.000Z/2020-03-20T19:47:45.000Z');
% TintBbkg=irf.tint('2020-03-20T19:47:27.000Z/2020-03-20T19:47:30.000Z');
% TintDown=irf.tint('2020-03-20T19:47:24.000Z/2020-03-20T19:47:25.000Z');
% TintUp=irf.tint('2020-03-20T19:47:28.000Z/2020-03-20T19:47:36.000Z');
% % %%%17
% % matName='FT_20210112_011900.mat';
% Tint=irf.tint('2021-01-12T01:19:33.000Z/2021-01-12T01:20:15.000Z');
% TintShock=irf.tint('2021-01-12T01:19:57.000Z/2021-01-12T01:20:10.000Z');
% TintBbkg=irf.tint('2021-01-12T01:20:01.000Z/2021-01-12T01:20:10.000Z');
% % %%%18
% % %matName='FT_20210127_005900.mat';
% Tint=irf.tint('2021-01-27T00:59:53.000Z/2021-01-27T01:02:13.000Z');
% TintShock=irf.tint('2021-01-27T01:01:53.000Z/2021-01-27T01:01:59.000Z');
% TintBbkg=irf.tint('2021-01-27T01:01:55.000Z/2021-01-27T01:01:59.000Z');
% % %%%%19
% %matName='FT_20210227_125700.mat';
% Tint=irf.tint('2021-02-27T12:56:05.000Z/2021-02-27T12:58:23.000Z');
% TintShock=irf.tint('2021-02-27T12:57:45.000Z/2021-02-27T12:57:55.000Z');
% TintBbkg=irf.tint('2021-02-27T12:57:48.000Z/2021-02-27T12:57:55.000Z');
% % % %%%20
% %% matName='FT_20210305_202600.mat';
% Tint=irf.tint('2021-03-05T20:26:33.000Z/2021-03-05T20:27:43.000Z');
% TintShock=irf.tint('2021-03-05T20:27:08.000Z/2021-03-05T20:27:11.000Z');
% TintBbkg=irf.tint('2021-03-05T20:27:09.000Z/2021-03-05T20:27:10.000Z');
% TintDown=irf.tint('2021-03-05T20:27:08.000Z/2021-03-05T20:27:08.600Z');
% TintUp=irf.tint('2021-03-05T20:27:09.000Z/2021-03-05T20:27:11.000Z');
% % %%%21
% matName='FT_20210320_155700.mat';
% Tint=irf.tint('2021-03-20T15:59:33.000Z/2021-03-20T16:01:53.000Z');
% TintShock=irf.tint('2021-03-20T15:59:50.000Z/2021-03-20T16:00:15.000Z');
% TintBbkg=irf.tint('2021-03-20T16:00:03.000Z/2021-03-20T16:00:07.000Z');
% TintDown=irf.tint('2021-03-20T16:00:00.000Z/2021-03-20T16:00:01.000Z');
% TintUp=irf.tint('2021-03-20T16:00:02.500Z/2021-03-20T16:00:06.000Z');
% % % %%%22
% % matName='FT_20210418_015000.mat';
% Tint=irf.tint('2021-04-18T01:50:23.000Z/2021-04-18T01:54:03.000Z');
% TintShock=irf.tint('2021-04-18T01:52:38.000Z/2021-04-18T01:52:45.000Z');
% TintBbkg=irf.tint('2021-04-18T01:52:40.000Z/2021-04-18T01:52:45.000Z');
% % %%%23
% matName='FT_20211207_132300.mat';
% Tint=irf.tint('2021-12-07T13:23:43.000Z/2021-12-07T13:24:30.000Z');
% TintShock=irf.tint('2021-12-07T13:24:15.000Z/2021-12-07T13:24:25.000Z');
% TintBbkg=irf.tint('2021-12-07T13:24:20.000Z/2021-12-07T13:24:23.000Z');
% TintDown=irf.tint('2021-12-07T13:24:16.200Z/2021-12-07T13:24:17.000Z');
% TintUp=irf.tint('2021-12-07T13:24:18.000Z/2021-12-07T13:24:24.000Z');

% % %%%%24
% matName='FT_20211218_050600.mat';
% Tint=irf.tint('2021-12-18T05:06:00.000Z/2021-12-18T05:07:30.000Z');
% TintShock=irf.tint('2021-12-18T05:06:20.000Z/2021-12-18T05:06:37.000Z');
% TintBbkg=irf.tint('2021-12-18T05:06:27.000Z/2021-12-18T05:06:37.000Z');
% TintDown=irf.tint('2021-12-18T05:06:24.000Z/2021-12-18T05:06:25.000Z');
% TintUp=irf.tint('2021-12-18T05:06:27.000Z/2021-12-18T05:06:35.000Z');


%%%%
% Tint=irf.tint('2021-03-20T19:28:33.000Z/2021-03-20T19:30:00.000Z');
% TintShock=irf.tint('2021-03-20T19:29:30.000Z/2021-03-20T19:29:50.000Z');
% TintBbkg=irf.tint('2021-03-20T19:29:35.000Z/2021-03-20T19:29:50.000Z');
% TintDown=irf.tint('2021-03-20T19:29:31.000Z/2021-03-20T19:29:37.000Z');
% TintUp=irf.tint('2021-03-20T19:29:39.000Z/2021-03-20T19:29:50.000Z');

%% 2. Load data
Tintl = Tint+[-100 100];
%R  = mms.get_data('R_gse',Tintl);
%c_eval('Rxyz = irf.ts_vec_xyz(R.time,R.gseR?);',ic);
c_eval('Rxyz=mms.db_get_ts(''mms?_mec_srvy_l2_epht89q'',''mms1_mec_r_gse'',Tintl);',ic);
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',ic);
c_eval('ne = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',Tint);',ic);
c_eval('ni = mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_numberdensity_brst'',Tint);',ic);
c_eval('Vxyz=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',Tint);',ic);
magB = Bxyz.abs;
Bxyzmag = TSeries(Bxyz.time,[Bxyz.data magB.data]);
%%%
arrBxyz=Bxyzmag.data;
mobmeanWnd=40;
arrBxyzMovmean=movmean(arrBxyz,mobmeanWnd,1);%%%%滑动窗口可以选择
BxyztBKG=TSeries(Bxyz.time,arrBxyzMovmean);

%% 4. Plot Figure
% 4.0. basic
npanel = 6;
h=irf_plot(npanel,'newfigure');
delete(h(4));
h(4)=[];
xSize=800; ySize=600;
set(gcf,'Position',[10 10 xSize ySize]);
xwidth = 0.76;      ywidth = 0.12;
c_eval('set(h(?),''position'',[0.17 0.97-ywidth*? xwidth ywidth]);', 1:3);
set(h(4),'position',[0.17 0.97-ywidth*5 xwidth ywidth]);
set(h(5),'position',[0.17 0.97-ywidth*6 xwidth ywidth]);


% 4.1. Bxyz
ip = 1;
h(ip)=irf_panel('Bfgm');
irf_plot(h(ip), Bxyzmag);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(h(ip),{' ','B FGM','(nT)'},'Interpreter','tex','fontsize',myFontSize);

%
% 4.3 
ip=ip+1;
h(ip)=irf_panel('Nplasma');
irf_plot(h(ip), ne, 'c');
hold(h(ip),'on');
irf_plot(h(ip), ni, 'm');
irf_legend(h(ip),{'Ni'},[1.01 0.24], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'Ne'},[1.01 0.74], 'color','c','fontsize',myFontSize);
ylabel(h(ip),{' ','Density','(cm^{-3})'},'Interpreter','tex','fontsize',myFontSize);
set(h(ip),'ylim',[0,17]);


%4.4 Vxyz
ip=ip+1;
h(ip)=irf_panel('Vxyz');
irf_plot(h(ip), Vxyz);%,['b','c','m']);
set(h(ip),'ColorOrder',mmsColors);
ylabel(h(ip),{' ','V GSE','(km/s)'},'Interpreter','tex','fontsize',myFontSize);
irf_legend(h(ip),{'Vx GSE'},[1.01 0.24], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'Vy GSE'},[1.01 0.49], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Vz GSE'},[1.01 0.94], 'color','m','fontsize',myFontSize);
set(h(ip),'ylim',[-750,750]);

%
ip=ip+1;
irf_plot(h(ip), Bxyzmag);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(h(ip),{' ','B FGM','(nT)'},'Interpreter','tex','fontsize',myFontSize);
%
ip = ip+1;
%h(ip)=irf_panel('BfgmNew');
irf_plot(h(ip), BxyztBKG);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(h(ip),{' ','B FGM','(nT)'},'Interpreter','tex','fontsize',myFontSize);
%%
irf_zoom(h(1: ip),'x',Tint);
irf_plot_axis_align(h(1: 3));
irf_zoom(h(4:5),'x',TintShock);
irf_plot_zoomin_lines_between_panels(h(3),h(4));


c_eval('Bxyz_bkg=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintBbkg);',ic);
Bxyz_bkg=mean(Bxyz_bkg.data,1)
%%%
c_eval('Bxyz_down=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintDown);',ic);
c_eval('Bxyz_up=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintUp);',ic);
c_eval('Vxyz_down=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',TintDown);',ic);
c_eval('Vxyz_up=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',TintUp);',ic);
c_eval('ne_down = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintDown);',ic);
c_eval('ne_up = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintUp);',ic);
%%%
Bdown=[mean(Bxyz_down.data(:,1)),mean(Bxyz_down.data(:,2)),mean(Bxyz_down.data(:,3))];
Bup=[mean(Bxyz_up.data(:,1)),mean(Bxyz_up.data(:,2)),mean(Bxyz_up.data(:,3))];
Vdown=[mean(Vxyz_down.data(:,1)),mean(Vxyz_down.data(:,2)),mean(Vxyz_down.data(:,3))];
Vup=[mean(Vxyz_up.data(:,1)),mean(Vxyz_up.data(:,2)),mean(Vxyz_up.data(:,3))];
Ndown=[mean(ne_down.data)];
Nup=[mean(ne_up.data)];
%%%
deltaB=Bdown-Bup;
deltaV=Vdown-Vup;
partOne=cross(deltaB,deltaV);
partTwo=cross(partOne,deltaB);
partThree=norm(partTwo);
normalShock=partTwo/partThree
%%%
partN=dot(Vdown,normalShock)*Ndown-dot(Vup,normalShock)*Nup;
partD=Ndown-Nup;
vShock=partN/partD