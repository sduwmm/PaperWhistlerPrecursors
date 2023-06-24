%https://ww2.mathworks.cn/videos/making-a-multi-color-line-in-matlab-97127.html
%%load and create ion energy spectrom 
%%Epoch
%%mms1_dis_energyspectr_omni_brst
%mobmeanWnd=300;
%arrBxyzMovmean=movmean(arrBxyz,mobmeanWnd,1);%%%%滑动窗口可以选择

clear all;
close all;
cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210041743_v3.3.0.cdf');
infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile1); 
epochData1 = spdfcdfread(cdfFPIFile1, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
ionEnergyChannel1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energy_brst');
ionEnergyspectr1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energyspectr_omni_brst');%600*32
cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210041913_v3.3.0.cdf');
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
%%-------------------------------------------------------------------------
ic = 1; % Spacecraft number
mmsColors=[0 0 1;0 1 1; 1 0 1; 0 0 0];
colorArr=['b','c','m','k','y'];
lineColorArr=['k','w','w'];
myFontSize=12;

Tint=irf.tint('2018-12-10T04:18:30.000Z/2018-12-10T04:20:20.000Z');
TintShow=irf.tint('2018-12-10T04:20:00.000Z/2018-12-10T04:20:06.000Z');
TintMVA=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');


%% 2. Load data
Tintl = Tint+[-100 100];
R  = mms.get_data('R_gse',Tintl);
c_eval('Rxyz = irf.ts_vec_xyz(R.time,R.gseR?);',ic);
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',ic);
c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',Tint);',ic);%load data
c_eval('ne = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',Tint);',ic);
c_eval('ni = mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_numberdensity_brst'',Tint);',ic);
c_eval('Vxyz=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',Tint);',ic);
%%%
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
%%%    
magB = Bxyz.abs;
Bxyzmag = TSeries(Bxyz.time,[Bxyz.data magB.data]);


%% 4. Plot Figure
% 4.0. basic
npanel = 8;
h=irf_plot(npanel,'newfigure');
delete(h(6));
h(6)=[];					% remove handle
%xSize=2100/2; ySize=2970/2;

xSize=900;ySize=900;
set(gcf,'Position',[10 10 xSize ySize]);
xwidth = 0.70;      ywidth = 0.07;
set(h(1),'position',[0.17 0.97-ywidth*1 xwidth ywidth/2]);
c_eval('set(h(?),''position'',[0.17 0.97-ywidth*? xwidth ywidth]);', 2:5);
set(h(6),'position',[0.17 0.97-ywidth*7 xwidth ywidth]);
set(h(7),'position',[0.17 0.97-ywidth*8 xwidth ywidth]);


%
ip=0;
ip = ip+1;
h(ip)=irf_panel('Bar');
TintAll=irf.tint('2018-12-10T04:18:30.000Z/2018-12-10T04:20:20.000Z');
TintSW=irf.tint('2018-12-10T04:18:30.000Z/2018-12-10T04:18:50.000Z');
TintFT=irf.tint('2018-12-10T04:18:50.000Z/2018-12-10T04:20:02.000Z');
TintFS=irf.tint('2018-12-10T04:20:02.000Z/2018-12-10T04:20:20.000Z');
c_eval('BarAll = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintAll);',ic);
c_eval('BarSW = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintSW);',ic);
c_eval('BarFT = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintFT);',ic);
c_eval('BarFS = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',TintFS);',ic);
BarSW=ones(size(BarSW.data,1),3);
BarFT=ones(size(BarFT.data,1),3)*2;
BarFS=ones(size(BarFS.data,1),3)*1;
hold on;
%irf_spectrogram(h(ip),BarSW,'lin');


unixEpoch=EpochUnix(BarAll.time.epoch);
epochSpec=unixEpoch.epoch;
barSpe=struct('t',epochSpec);
barSpe.f=[1;2;3];
barSpe.p=[BarSW;BarFT;BarFS];
barSpe.f_label={};
barSpe.p_label={};
barSpe.p_label={};
barSpe.plot_type=['lin'];
irf_spectrogram(h(ip),barSpe,'lin', 'donotshowcolorbar' );
set(h(ip),'ytick',[ ]);
trpMap = [0 153 255
    255 102 0]/256;
    %0 153 51]/256;
colormap(h(ip),trpMap);
text(h(1),0.5,2,'Solar wind','FontSize',myFontSize+2);
text(h(1),36,2,'Foreshock transient','FontSize',myFontSize+2);
text(h(1),93,2,'Solar wind','FontSize',myFontSize+2);
%text(h(1),90,5,'FT shock','FontSize',myFontSize+2);
% 4.1. Bxyz
ip = ip+1;
h(ip)=irf_panel('Bfgm');
irf_plot(h(ip), Bxyzmag);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(h(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
%irf_zoom(h(ip),'y',[-50 60]);
set(h(ip),'ylim',[-12,17]);
% yticks=[-5, 0, 5, 10, 15]; 
% yticklabels=[' ', '0','5','10','15'];
% set(h(ip),'ytick',yticks,'yticklabel',xticklabels);
text(h(2),92,11,'\leftarrow FT shock','Color','Red','FontSize',myFontSize+2,'FontWeight','Bold');
% 4.4. Ion energy spectrom
ip=ip+1;
h(ip)=irf_panel('IonEnerSpec');
irf_spectrogram(h(ip),ionEnerSpe,'log','donotfitcolorbarlabel');
colormap(h(ip),'jet');
hold(h(ip),'off');
set(h(ip),'yscale','log');
%set(h(ip),'ytick',[1 1e1 1e2 1e3]);
%caxis(h(ip),[2 5])
ylabel(h(ip),{'','i_{+} eFlux','(eV)'},'fontsize',12);
set(h(ip),'ylim',[100,20000]);%[17800]

% 4.2 Ni Ne
ip=ip+1;
h(ip)=irf_panel('Nplasma');
axN=irf_plot(h(ip), ne, 'c');
hold(h(ip),'on');
irf_plot(h(ip), ni, 'm');
irf_legend(h(ip),{'Ni'},[1.01 0.24], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'Ne'},[1.01 0.74], 'color','c','fontsize',myFontSize);
ylabel(h(ip),{' ','Density','(cm^{-3})'},'Interpreter','tex');
set(h(ip),'ylim',[0,17]);

%4.3 Vxyz
ip=ip+1;
h(ip)=irf_panel('Vxyz');
irf_plot(h(ip), Vxyz);%,['b','c','m']);
set(h(ip),'ColorOrder',mmsColors);
ylabel(h(ip),{' ','i_{+} V','(km/s)'},'Interpreter','tex');
irf_legend(h(ip),{'Vx GSE'},[1.01 0.24], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'Vy GSE'},[1.01 0.49], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Vz GSE'},[1.01 0.94], 'color','m','fontsize',myFontSize);
set(h(ip),'ylim',[-750,750]);


% 4.5. Bxyz
ip = 6; 
%h(ip)=irf_panel('BfgmZoom');
irf_plot(h(ip), Bxyzmag);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
irf_legend(h(ip),{'B total'},[1.01 0.99], 'color','k','fontsize',myFontSize);
ylabel(h(ip),{' ','B FGM','(nT)'},'Interpreter','tex');
%irf_zoom(h(ip),'y',[-50 60]);
set(h(ip),'ylim',[-7,17]);

ip=ip+1;
irf_plot(h(ip),Bscm);
set(h(ip),'ColorOrder',mmsColors)
irf_legend(h(ip),{'Bx GSE'},[1.01 0.05], 'color','b','fontsize',myFontSize);
irf_legend(h(ip),{'By GSE'},[1.01 0.30], 'color','c','fontsize',myFontSize);
irf_legend(h(ip),{'Bz GSE'},[1.01 0.75], 'color','m','fontsize',myFontSize);
ylabel(h(ip),{' ','B SCM','(nT)'},'Interpreter','tex');
%irf_zoom(h(ip),'y',[-50 60]);
%%
% irf_pl_number_subplots(h,[.03,.93],'num','\bf{(?)}','fontsize',18,...
%   'interpreter','latex','backgroundcolor','w','edgecolor','k','linewidth',1.8)
%irf_pl_number_subplots(h(2:7),[.01,.95],'fontsize',18);
irf_pl_number_subplots(h(2:7),[.01,.95],'num','\bf{(?)}','fontsize',18,...
    'interpreter','tex','linewidth',1.8)
irf_zoom(h(1: 5),'x',Tint);
irf_plot_axis_align(h(1: 7));
irf_zoom(h(6:7),'x',TintShow);
%irf_plot_axis_align(h(6: 6));
irf_plot_zoomin_lines_between_panels(h(5),h(6));

% add tmarks and mark intervals
% add line marks
tmarks=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');
tmarks=TintMVA;
irf_pl_mark(h(6:7),tmarks,'black','LineWidth',0.5)

% 4.X. global
%load('caa/cmap.mat');
%c_eval('title(h(1),''MMS?'')',ic);


set(h(2: 7),'fontsize',16);

%irf_zoom(h,'x',Tint);




%%
%%
filter=[2,6];
c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',TintMVA);',ic);%load data
% %%MVA on data filtered--------------------------------------------------->
bwM1        = Bscm.data(:,1);
byM1        = Bscm.data(:,2);
bzM1        = Bscm.data(:,3);
bwM1Filter  = bandpass(bwM1,filter,8192);
byM1Filter  = bandpass(byM1,filter,8192);
bzM1Filter  = bandpass(bzM1,filter,8192);
bM1Filter   = [bwM1Filter byM1Filter bzM1Filter];
BscmM1Filter = TSeries(Bscm.time,bM1Filter);%%%
%
bData=Bscm;
bData=BscmM1Filter;
bb=bData.data;
bo=Bxyz.data;
boVector=[irf.nanmean(bo(:,1)), irf.nanmean(bo(:,2)), irf.nanmean(bo(:,3))];


%
[~,eigenvalues,eigenvectors]=irf_minvar(bb);
disp(strcat('Max    eigenvalue l1=',num2str(eigenvalues(1),3),'v1=[',num2str(eigenvectors(1,1),3),', ',num2str(eigenvectors(1,2),3),', ',num2str(eigenvectors(1,3),3),']'))
disp(strcat('Interm eigenvalue l2=',num2str(eigenvalues(2),3),'v2=[',num2str(eigenvectors(2,1),3),', ',num2str(eigenvectors(2,2),3),', ',num2str(eigenvectors(2,3),3),']'))
disp(strcat('Min    eigenvalue l3=',num2str(eigenvalues(3),3),'v3=[',num2str(eigenvectors(3,1),3),', ',num2str(eigenvectors(3,2),3),', ',num2str(eigenvectors(3,3),3),']'))
%
b1xyzMVA=bb(:,1).*eigenvectors(1,1)+bb(:,2).*eigenvectors(1,2)+bb(:,3).*eigenvectors(1,3);%%把磁场扰动转到最大特征值对应的特征向量方向
b2xyzMVA=bb(:,1).*eigenvectors(2,1)+bb(:,2).*eigenvectors(2,2)+bb(:,3).*eigenvectors(2,3);%%把磁场扰动转到中间特征值对应的特征向量方向
b3xyzMVA=bb(:,1).*eigenvectors(3,1)+bb(:,2).*eigenvectors(3,2)+bb(:,3).*eigenvectors(3,3);%%把磁场扰动转到最小特征值对应的特征向量方向
%
bxyzMVA=TSeries(bData.time,[b1xyzMVA b2xyzMVA b3xyzMVA]);
boMVA=boVector(1)*eigenvectors(3,1)+boVector(2)*eigenvectors(3,2)+boVector(3)*eigenvectors(3,3);

%%
%%%------------------------------------------------------------------------
%
figFFT=axes('position',[0.17 0.97-0.9 0.25 0.25]);
box on;
TintFFT=TintMVA;
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintFFT);',ic);
c_eval('Bscm=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintFFT);',ic);
magB = Bxyz.abs;
Bxyzmag = TSeries(Bxyz.time,[Bxyz.data magB.data]);

%cmp=4;
cmp=2;
dataAll=Bxyzmag.data;
    data    = dataAll(:,cmp);
    time    = double(Bxyzmag.time.epoch);                    %%%time vector
    ll      = length(data);                               %%%length of singal
    smplInt = single((time(ll) - time(1))*10^(-9))/(ll-1);%%%sampling interval
    smplFre = 1/smplInt;                                  %%%sampling frequency; should be ~128Hz
    %--------------------------------------------------------------------------
    %%
    NFFT = 2^nextpow2(ll);                                %%%1024
    Y       = fft(data, NFFT)/ll;
    frequency    = smplFre/2*linspace(0, 1, NFFT/2+1);%真实频率
    %Y2    = 2*abs(Y(1:NFFT/2+1));
    Y2    = abs(Y(1:NFFT/2+1)).^2;
    [pxx,w]=periodogram(data);
    loglog(figFFT,frequency,pxx,colorArr(cmp)); %%%功率谱密度和频率的关系
    xline(4,colorArr(cmp));
    %yline(5.975)
    hold 
legend({'B_{total}'});
legend({'B_{y}'});

xlim([0.3,100]);
ylim([1e-5,100]);
text(0.5,0.01,'f_{sc}=4 Hz')
% yline(65.3,'m-.');
%yline(100,'m-.');
xlabel('Frequency (Hz)');
ylabel('Power (nT^{2}/Hz)');
set(gca,'Fontweight','Bold','Fontsize',14,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');

%%%------------------------------------------------------------------------
%figHodo=subplot(1,2,2);
%
%set(figHodo,'position',[0.54 0.97-0.9 0.25 0.25]);
%set(figHodo,'position',[0.17 0.97-0.9 0.25 0.25]);
figHodo=axes('position',[0.54 0.97-0.9 0.25 0.25]);
box on;
%%%
%plot(figHodo,b1xyzMVA,b2xyzMVA,'k','LineWidth',1);
b1xyzMVA(end+1)=NaN;
b2xyzMVA(end+1)=NaN;
c=linspace(1,size(b2xyzMVA,1),size(b2xyzMVA,1));
patch(b1xyzMVA,b2xyzMVA,c,'EdgeColor', 'interp','Marker','.','MarkerFaceColor','flat');
cb=colorbar;
colormap(figHodo,'jet');
cb.Position=[0.8,0.07,0.03,0.25];
cb.TickLabels=[];
cb.Ticks=[c(1),c(end)];
cb.TickLabels={'Start','End'};
lambda12=eigenvalues(1)/eigenvalues(2);
title(['\lambda_{1}/\lambda_{2}=',num2str(lambda12,'%.1f'),', 2 Hz<B<6 Hz'],'Interpreter','tex','fontsize',14);%'Fontweight','Bold',
xlabel('B1(nT)','fontsize',14);
ylabel('B2(nT)','fontsize',14);
hold on;
xlim([-1.5,1.5]);
ylim([-1.3,1.7]);
endInd=length(b1xyzMVA);

%scatter(b1xyzMVA(endInd),b2xyzMVA(endInd),'s','black');
if boMVA > 0 
    scatter(1,1.5,100,'o','black','LineWidth',2);
    scatter(1,1.5,100,'.','black','LineWidth',2);
else
     scatter(1,1.5,100,'x','black','LineWidth',2);
end
scatter(b1xyzMVA(1),b2xyzMVA(1),'.','black','LineWidth',2);
scatter(b1xyzMVA(endInd),b2xyzMVA(endInd),'d','black','LineWidth',2);

text(0.9,1.28,'B_{ok}','Fontweight','Bold','fontsize',14);
%arrow([2,-1.5],[2-0.1,-1.5-0.1],'BaseAngle',0);
arrow([0.5,1.5],[-0.5,1.5]);

set(gca,'Fontweight','Bold','Fontsize',14,...
'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');


irf_pl_number_subplots(figFFT,[.02,.97],'num','\bf{(?)}','fontsize',18,'firstletter','g',...
    'interpreter','tex','linewidth',1.8);
irf_pl_number_subplots(figHodo,[.02,.97],'num','\bf{(?)}','fontsize',18,'firstletter','h',...
    'interpreter','tex','linewidth',1.8);


%%%align aix
%%
exportgraphics(gcf,'figure1_MVA.png','Resolution',300)

exportgraphics(gcf,'figure1_MVA.pdf','ContentType','vector')%vector

exportgraphics(gcf,'figure1_MVA.emf')