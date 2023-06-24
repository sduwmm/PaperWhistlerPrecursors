clear all;
close all;
mmsColors=[0 0 1;0 1 1; 1 0 1; 0 0 0];
mms.db_init('local_file_db','D:/data/mms/');
ic=1;
%%%%时间要长一些
%%%用By做fft
%%
Tint=irf.tint('2017-12-01T14:41:00.100Z/2017-12-01T14:41:03.000Z');%%1.5Hz
%Tint=irf.tint('2017-12-17T17:53:20.600Z/2017-12-17T17:53:23.000Z');%%2.25Hz%%注意这个事件%%这个事件可能有猫腻
% Tint=irf.tint('2017-12-18T12:56:48.000Z/2017-12-18T12:56:53.000Z');%%1.75
 Tint=irf.tint('2017-12-29T19:11:37.000Z/2017-12-29T19:11:45.000Z');%%1.875
% Tint=irf.tint('2018-01-09T08:34:52.000Z/2018-01-09T08:34:59.000Z');%%2.125
% Tint=irf.tint('2018-02-04T10:38:13.000Z/2018-02-04T10:38:18.000Z');%%1.125Hz
% Tint=irf.tint('2018-02-21T11:36:44.700Z/2018-02-21T11:36:54.000Z');%%1.562Hz
% Tint=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');%%4Hz
% Tint=irf.tint('2018-12-10T04:41:48.500Z/2018-12-10T04:41:54.000Z');%%2.625Hz
% Tint=irf.tint('2018-12-10T05:49:55.000Z/2018-12-10T05:49:58.000Z');%%%2.25Hz%%05:50:05
% Tint=irf.tint('2018-12-10T06:28:56.000Z/2018-12-10T06:29:00.000Z');%%3Hz
% Tint=irf.tint('2019-01-18T21:03:58.000Z/2019-01-18T21:04:13.000');%%%1.062Hz
% Tint=irf.tint('2019-12-06T05:13:55.000Z/2019-12-06T05:14:02.000Z');%%%1.125Hz
% Tint=irf.tint('2020-03-20T19:47:27.000Z/2020-03-20T19:47:35.000Z');%%0.875Hz%%%47:40
% Tint=irf.tint('2021-01-12T01:20:00.000Z/2021-01-12T01:20:10.000Z');%%%1.25Hz
% Tint=irf.tint('2021-01-27T01:01:54.000Z/2021-01-27T01:01:58.000Z');%%3Hz%%%检查band filter
% Tint=irf.tint('2021-02-27T12:57:49.000Z/2021-02-27T12:57:55.000Z');%%%1.5Hz
% Tint=irf.tint('2021-03-05T20:27:09.000Z/2021-03-05T20:27:11.000Z');%%%3Hz%%%检查band filter
% Tint=irf.tint('2021-03-20T19:29:42.000Z/2021-03-20T19:29:52.000Z');
%Tint=irf.tint('2021-04-18T01:52:39.500Z/2021-04-18T01:52:50.000Z');%%%1.25Hz%%%这个事件可能也有猫腻%%%%注意！
%Tint=irf.tint('2021-12-07T13:24:17.700Z/2021-12-07T13:24:25.000Z');%%%1.375Hz
%Tint=irf.tint('2021-12-18T05:06:27.000Z/2021-12-18T05:06:38.000Z');%%%0.875Hz

%%
nf = 100;
%  2. load data
%c_eval('Rxyz = irf.ts_vec_xyz(R.time,R.gseR?);',ic);
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',ic);
c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',Tint);',ic);
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
%%%----------------------------------------------------
% 4. Plot Figure
% 4.0. basic
colorArr=['b','c','m','k','y'];
lineColorArr=['k','w','w'];
npanel = 2;
h=irf_plot(npanel,'newfigure');
xSize=900; ySize=600;
set(gcf,'Position',[10 10 xSize ySize]);
xwidth = 0.80;      ywidth = 0.30;
c_eval('set(h(?),''position'',[0.15 0.97-ywidth*? xwidth ywidth]);', 1:npanel);

% 4.1. B
magB = Bxyz.abs;
Bxyzmag = TSeries(Bxyz.time,[Bxyz.data magB.data]);
% 4.x. Bxyz
ip = 1;
h(ip)=irf_panel('BxyzFGM');
irf_plot(h(ip), Bxyzmag);
set(h(ip),'ColorOrder',mmsColors)

hold(h(ip),'on');
set(h(ip),'ylim',[-4,8]);
ylabel(h(ip),{'B GSE','FGM','(nT)'}, 'Interpreter','tex');%%'fontsize',12,
%irf_zoom(h(ip),'y',[-50 60]);
irf_legend(h(ip),{'B_{x}'},[0.85 0.15], 'color',colorArr(1));
irf_legend(h(ip),{'B_{y}'},[0.89 0.15], 'color',colorArr(2));
irf_legend(h(ip),{'B_{z}'},[0.93 0.15], 'color',colorArr(3));
irf_legend(h(ip),{'|B|'},[0.97 0.15], 'color',colorArr(4));
%irf_legend(h(ip),'(c)',[0.99 0.94],'color','k','fontsize',12)
%%%%%-------------------------------------------------------------------4.1

%%%%---4.2 BxyzSCm
ip = ip+1;
Bscm_data = Bscm.data;
Bxscm = TSeries(Bscm.time, Bscm_data(:,1));
Byscm = TSeries(Bscm.time, Bscm_data(:,2));
Bzscm = TSeries(Bscm.time, Bscm_data(:,3));
h(ip)=irf_panel('BxyzSCM');
irf_plot(h(ip), Bxscm, colorArr(1));
hold(h(ip),'on');
irf_plot(h(ip), Byscm,colorArr(2));
irf_plot(h(ip), Bzscm,colorArr(3));
set(h(ip),'ylim',[-7,7]);
ylabel(h(ip),{'B GSE','SCM','(nT)'},'Interpreter','tex');
%irf_zoom(h(ip),'y',[-50 60]);
irf_legend(h(ip),{'B_{x}'},[0.85 0.15], 'color',colorArr(1));
irf_legend(h(ip),{'B_{y}'},[0.89 0.15], 'color',colorArr(2));
irf_legend(h(ip),{'B_{z}'},[0.93 0.15], 'color',colorArr(3));
%irf_legend(h(ip),'(d)',[0.99 0.94],'color','k','fontsize',12);

% 4.X. global
irf_plot_axis_align(h(1: npanel));
irf_zoom(h(1: npanel),'x',Tint);
set(h(1: npanel),'fontsize',12);

%%
figB=figure;
set(figB,...%'defaultAxesColorOrder',[left_color; right_color],...
    'unit','normalized','position',[0.0,0.0,0.1600*6,0.2560*3]);
%%%FFT=================================================================
%%%full width at half maxima-----------------------------------------------
magB = Bxyz.abs;
% Bxyz_data = Bxyz.data;
% Bxyz_data = [Bxyz_data magB.data];
% Bxmag = TSeries(Bxyz.time, Bxyz_data(:,1));
% Bymag = TSeries(Bxyz.time, Bxyz_data(:,2));
% Bzmag = TSeries(Bxyz.time, Bxyz_data(:,3));
% Btmag = magB;

subplot(1,2,1);
dataAll=Bxyzmag.data;
for comp=1:4
    data    = dataAll(:,comp);
    time    = double(Bxyzmag.time.epoch);                    %%%time vector
    ll      = length(data);                               %%%length of singal
    smplInt = single((time(ll) - time(1))*10^(-9))/(ll-1);%%%sampling interval
    smplFre = 1/smplInt;                                  %%%sampling frequency; should be ~128Hz
    %--------------------------------------------------------------------------
    %%
    NFFT = 2^nextpow2(ll);                                %%%1024%和采样长度有关
    Y       = fft(data, NFFT)/ll;
    frequency    = smplFre/2*linspace(0, 1, NFFT/2+1);%真实频率
    %Y2    = 2*abs(Y(1:NFFT/2+1));
    Y2    = abs(Y(1:NFFT/2+1)).^2;
    [pxx,w]=periodogram(data);
    loglog(frequency,pxx,colorArr(comp)); %%%功率谱密度和频率的关系
    %xline(4,colorArr(comp));
    %yline(5.975)
    hold on;
end
legend({'B_{x}','B_{y}','B_{z}','B_{total}'});
xlim([0.1,128/2+10]);
ylim([1e-6,1000]);
% yline(65.3,'m-.');
%yline(100,'m-.');
xlabel('Frequency (Hz)');
ylabel('Power (nT^{2}/Hz)');
set(gca,'Fontweight','Bold','Fontsize',14,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
title('FGM');
%% ---------------------------------------------------------------------
subplot(1,2,2);
dataAll=Bscm.data;
for comp=1:3
    data    = dataAll(:,comp);
    time    = double(Bscm.time.epoch);                    %%%time vector
    ll      = length(data);                               %%%length of singal
    smplInt = single((time(ll) - time(1))*10^(-9))/(ll-1);%%%sampling interval
    smplFre = 1/smplInt;                                  %%%sampling frequency; should be ~8192Hz
    %--------------------------------------------------------------------------
    %%
    NFFT = 2^nextpow2(ll);                                %%%1024
    Y       = fft(data, NFFT)/ll;
    frequency    = smplFre/2*linspace(0, 1, NFFT/2+1);%真实频率
    %Y2    = 2*abs(Y(1:NFFT/2+1));
    Y2    = abs(Y(1:NFFT/2+1)).^2;
    [pxx,w]=periodogram(data);
    loglog(frequency,pxx,colorArr(comp)); %%%功率谱密度和频率的关系
    %xline(4,colorArr(comp));
    %yline(5.975)
    hold on;
end
legend({'B_{x}','B_{y}','B_{z}'});
xlim([0.1,8192/2+1000]);
xlim([0.1,128/2+10]);
ylim([1e-6,100000]);
% yline(65.3,'m-.');
%yline(100,'m-.');
xlabel('Frequency (Hz)');
ylabel('Power (nT^{2}/Hz)');
set(gca,'Fontweight','Bold','Fontsize',14,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
title('SCM');


%% ------------------------------------------------------------------
% %%
% %%使用加窗函数
% window=boxcar(length(data)); %矩形窗
% %window=hamming(length(data)); %hamming window
% nfft=NFFT;
% [Pxx,frequency2]=periodogram(data,window,nfft,smplFre); %直接法
% figure;
% subplot(1,2,1);
% plot(data);
% subplot(1,2,2);
% semilogx(frequency2,10*log10(Pxx));
% plot(frequency2,pxx);
% %findpeaks(pxx)
% xlim([0.1,6]);
% %ylim([-50,20]);
% xlabel('Frequency (Hz)');
% ylabel('PSD');
%%%-----------------------------------------------------------------------
%%
%自相关
%{
[autocor,lags]=xcorr(data,'coeff');
figure;
subplot(1,2,1);
plot(data);
subplot(1,2,2);
plot(lags,autocor)
%}
%%
% %% Written by Zhangshuai
% % 对时间序列为Time的V_z信号进行FFT(快速傅里叶变换)
% ys=magB.data;
% Time=magB.time;
% L=length(ys);     %数据个数
% T=(Time(L)-Time(1))*3600*24/(L-1);  %采样间隔s，时间序列为Time3
% Fs=1/T;           %采样频率
% X=fft(ys)*2/L;    %信号的Fourier变换                         其实主要就是这个fft指令算出每个频率对应的幅度值向量
% f=Fs/2*linspace(0,1,L/2+1); %真实频率                        这个是上面每个幅度值对应的频率向量
% X2=abs(X(1:L/2.+1)).^2;
% X3=X2*2*L*T;      %这一步和上一步是算功率谱密度，也可以不算，直接画频率与幅度值的关系就好了
% % 画幅值谱
% plot(f,X3,'r')    %                                         然后plot频率向量和幅度值向量就好了
% %xlim([0,0.020])   %设置横坐标范围，看自己需要