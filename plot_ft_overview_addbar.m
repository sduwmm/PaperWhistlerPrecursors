%https://ww2.mathworks.cn/videos/making-a-multi-color-line-in-matlab-97127.html
%%load and create ion energy spectrom 
%%Epoch
%%mms1_dis_energyspectr_omni_brst
%mobmeanWnd=300;
%arrBxyzMovmean=movmean(arrBxyz,mobmeanWnd,1);%%%%滑动窗口可以选择

clear all;
close all;
ic = 1; % Spacecraft number
mmsColors=[0 0 1;0 1 1; 1 0 1; 0 0 0];
colorArr=['b','c','m','k','y'];
lineColorArr=['k','w','w'];
myFontSize=12;
ylimRange=[1 10];
Bsumthres=1e-1;%%1e-1
planthres=0.7;%%0.55


Tint=irf.tint('2018-12-10T04:18:30.000Z/2018-12-10T04:20:20.000Z');
TintShow=irf.tint('2018-12-10T04:20:00.000Z/2018-12-10T04:20:06.000Z');
TintEBSP=irf.tint('2018-12-10T04:19:50.000Z/2018-12-10T04:20:10.000Z');
cdfFPIFile1=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210041743_v3.3.0.cdf');
cdfFPIFile2=('D:\data\mms\mms1\fpi\brst\l2\dis-moms\2018\12\10\mms1_fpi_brst_l2_dis-moms_20181210041913_v3.3.0.cdf');
% % %--------------------------------------------------------------------------
infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile1); 
epochData1 = spdfcdfread(cdfFPIFile1, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
ionEnergyChannel1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energy_brst');
ionEnergyspectr1=spdfcdfread(cdfFPIFile1,'Variables','mms1_dis_energyspectr_omni_brst');%600*32
infoCDFFPIFIle=spdfcdfinfo(cdfFPIFile2); 
epochData2 = spdfcdfread(cdfFPIFile2, 'Variables','Epoch','KeepEpochAsIs', 1);%600*1
ionEnergyChannel2=spdfcdfread(cdfFPIFile2,'Variables','mms1_dis_energy_brst');
ionEnergyspectr2=spdfcdfread(cdfFPIFile2,'Variables','mms1_dis_energyspectr_omni_brst');%600*32
%
epochArr=[epochData1;epochData2];
unixEpoch=EpochUnix(epochArr);
ionEnergyChannel=[ionEnergyChannel1;ionEnergyChannel2];
spectrArr=[ionEnergyspectr1;ionEnergyspectr2];
%%
epochSpec=unixEpoch.epoch;
ionEnerSpe=struct('t',epochSpec);
ionEnerSpe.f=ionEnergyChannel;
ionEnerSpe.p=spectrArr;
ionEnerSpe.f_label={'Energy (eV)'};
ionEnerSpe.p_label={'Eflux'};
ionEnerSpe.p_label={['keV/(cm^2 s sr keV)']};%{'keV/(cm^2 s sr keV)'}
ionEnerSpe.plot_type=['log'];
%%-------------------------------------------------------------------------


%% 2. Load data
Tintl = Tint+[-100 100];
R  = mms.get_data('R_gse',Tintl);
c_eval('Rxyz = irf.ts_vec_xyz(R.time,R.gseR?);',ic);
c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',ic);
c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',Tint);',ic);%load data
c_eval('ne = mms.db_get_ts(''mms?_fpi_brst_l2_des-moms'',''mms?_des_numberdensity_brst'',Tint);',ic);
c_eval('ni = mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_numberdensity_brst'',Tint);',ic);
c_eval('Vxyz=mms.db_get_ts(''mms?_fpi_brst_l2_dis-moms'',''mms?_dis_bulkv_gse_brst'',Tint);',ic);
% %
c_eval('BxyzSRVY=mms.db_get_ts(''mms?_fgm_srvy_l2'',''mms?_fgm_b_gse_srvy_l2'',TintEBSP);',ic);
c_eval('BxyzBRST=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',TintEBSP);',ic);
%
c_eval('ExyzBRST=mms.db_get_ts(''mms?_edp_brst_l2_dce'',''mms?_edp_dce_gse_brst_l2'',TintEBSP);',ic);
c_eval('ExyzFAST=mms.db_get_ts(''mms?_edp_fast_l2_dce'',''mms?_edp_dce_gse_fast_l2'',TintEBSP);',ic);
%
c_eval('BscmBRST=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',TintEBSP);',ic);
%%%
%%%
arrBxyz=BxyzSRVY.data;
mobmeanWnd=20;
arrBxyzMovmean=movmean(arrBxyz,40,1);%%%%滑动窗口可以选择
BxyzBKG=TSeries(BxyzSRVY.time,arrBxyzMovmean);
%%%
magB = BxyzSRVY.abs;
BxyztSRVY = TSeries(BxyzSRVY.time,[BxyzSRVY.data magB.data]);
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
%% Polarization analysis
Units=irf_units; % read in standard units
Me=Units.me;
e=Units.e;
B_SI=BxyzSRVY.abs.data*1e-9;
Wce = e*B_SI/Me;
ecfreq = Wce/2/pi;
ecfreq01 = ecfreq*0.1;
ecfreq05 = ecfreq*0.5;
ecfreq = irf.ts_scalar(BxyzBKG.time,ecfreq);
ecfreq01 = irf.ts_scalar(BxyzBKG.time,ecfreq01);
ecfreq05 = irf.ts_scalar(BxyzBKG.time,ecfreq05);
%% M. M. Wang starts inserting
Mp=Units.mp;
epso=Units.eps0;
mu0=Units.mu0;
Mp_Me = Mp/Me;
Wpe = sqrt(ne.resample(BxyzBKG).data*1e6*e^2/Me/epso);
Wce = e*B_SI/Me;
Wpp = sqrt(ne.resample(BxyzBKG).data*1e6*e^2/Mp/epso);
Fce = Wce/2/pi;
Fpe = Wpe/2/pi;
Fcp = Fce/Mp_Me;
Fpp = Wpp/2/pi;
Flh = sqrt(Fcp.*Fce./(1+Fce.^2./Fpe.^2)+Fcp.^2);
Fcp = irf.ts_scalar(BxyzBKG.time,Fcp);
Fce = irf.ts_scalar(BxyzBKG.time,Fce);
Flh = irf.ts_scalar(BxyzBKG.time,Flh);
Fpp = irf.ts_scalar(BxyzBKG.time,Fpp);
%% M. M. Wang ends inserting
%irf_ebsp(E,dB,fullB,B0,xyz,freq_int,[OPTIONS])
%polarization = irf_ebsp(ExyzFAST,BxyzBRST,[],BxyzBKG,Rxyz,ylimRange,'polarization','fac');
polarization = irf_ebsp(ExyzBRST,BxyzBRST,[],BxyzBKG,Rxyz,[0.5,2000],'polarization','fac');
%polarization = irf_ebsp(ExyzBRST,BscmBRST,[],BxyzBKG,Rxyz,ylimRange,'polarization','fac');
%polarization = irf_ebsp(ExyzBRST,tsBgseFSM,[],BxyzBKG,Rxyz,ylimRange,'polarization','fac');

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
%Bsumthres = 1e-2; planthres = 0.55;  ylimRange=[1.1 70]; %for lalti 2022
%Bsumthres = 1e-2; planthres = 0.7; %for lalti 2022
%Bsumthres = 1e-2; planthres = 0.55; 

removepts = find(Bsum < Bsumthres | planarity < planthres);
ellipticity(removepts) = NaN;
thetak(removepts) = NaN;
dop(removepts) = NaN;
planarity(removepts) = NaN;
pfluxz(removepts) = NaN;
vph(removepts) = NaN;
vphperp(removepts) = NaN;


%% 4. Plot Figure
% 4.0. basic
npanel = 11;
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
set(h(8),'position',[0.17 0.97-ywidth*9 xwidth ywidth]);
set(h(9),'position',[0.17 0.97-ywidth*10 xwidth ywidth]);
set(h(10),'position',[0.17 0.97-ywidth*11 xwidth ywidth]);
%set(h(11),'position',[0.17 0.97-ywidth*12 xwidth ywidth]);


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

ip=ip+1;
%h(ip)=irf_panel('Bsum');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=Bsum;
specrec.f_label='';
specrec.p_label={'log_{10}B^{2}','nT^2 Hz^{-1}'};
irf_spectrogram(h(ip),specrec,'log','donotfitcolorbarlabel');
hold(h(ip),'on');
irf_plot(h(ip),Flh,'linewidth',1.5,'color','w')
hold(h(ip),'off');
set(h(ip),'yscale','log');
set(h(ip),'ytick',[0.1 1 5]);
caxis(h(ip),[-5 1])
ylabel(h(ip),{' ','f', '(Hz)'},'fontsize',myFontSize);
set(h(ip),'ylim',ylimRange);

ip=ip+1;
%h(ip)=irf_panel('thetak');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=thetak;
specrec.f_label='';
specrec.p_label={'\theta_{k} (deg)'};
irf_spectrogram(h(ip),specrec,'lin','donotfitcolorbarlabel');
hold(h(ip),'on');
irf_plot(h(ip),Flh,'linewidth',1.5,'color','w')
hold(h(ip),'off');
set(h(ip),'yscale','log');
set(h(ip),'ytick',[0.1 1 5]);
caxis(h(ip),[0, 90])
ylabel(h(ip),{' ', 'f', '(Hz)'},'fontsize',myFontSize);
set(h(ip),'ylim',ylimRange);

% ip=ip+1;
% %h(ip)=irf_panel('planarity');
% specrec=struct('t',time);
% specrec.f=frequency;
% specrec.p=planarity;
% specrec.f_label='';
% specrec.p_label={'Planarity'};
% irf_spectrogram(h(ip),specrec,'lin','donotfitcolorbarlabel');
% hold(h(ip),'on');
% irf_plot(h(ip),Flh,'linewidth',1.5,'color','w')
% hold(h(ip),'off');
% set(h(ip),'yscale','log');
% set(h(ip),'ytick',[0.1 1 5]);
% caxis(h(ip),[0, 1])
% ylabel(h(ip),{' ', 'f', '(Hz)'},'fontsize',12);
% set(h(ip),'ylim',ylimRange);

ip=ip+1;
%h(ip)=irf_panel('ellipt');
specrec=struct('t',time);
specrec.f=frequency;
specrec.p=ellipticity;
specrec.f_label='';
specrec.p_label={'Ellipticity'};
irf_spectrogram(h(ip),specrec,'lin','donotfitcolorbarlabel');
%irf_legend(h(ip),'(i)',[0.99 0.98],'color','w','fontsize',12)
hold(h(ip),'on');
irf_plot(h(ip),Flh,'linewidth',1.5,'color','w')
hold(h(ip),'off');
set(h(ip),'yscale','log');
set(h(ip),'ytick',[0.1 1 5]);
caxis(h(ip),[-1, 1])
ylabel(h(ip),{' ', 'f', '(Hz)'},'fontsize',12);
set(h(ip),'ylim',ylimRange);
%%-------------------------------------------------------------------------

% Remove grid and set background to grey
set(h(8:10),'xgrid','off','ygrid','off')
set(h(8:10),'Color',0.7*[1 1 1]);

% Define blue-red colormap
rr = interp1([1 64 128 192 256],[0.0  0.5 0.75 1.0 0.75],1:256);
gg = interp1([1 64 128 192 256],[0.0  0.5 0.75 0.5 0.00],1:256);
bb = interp1([1 64 128 192 256],[0.75 1.0 0.75 0.5 0.00],1:256);
bgrcmap = [rr' gg' bb'];

colormap(h(8),'jet');
colormap(h(9),'jet');
colormap(h(10),bgrcmap);
%colormap(h(11),bgrcmap);

% irf_pl_number_subplots(h,[.03,.93],'num','\bf{(?)}','fontsize',18,...
%   'interpreter','latex','backgroundcolor','w','edgecolor','k','linewidth',1.8)
%irf_pl_number_subplots(h(2:11),[.01,.95],'fontsize',18);

irf_pl_number_subplots(h(2:10),[.01,.95],'num','(?)','fontsize',18,...
    'interpreter','tex','linewidth',1.8)
irf_zoom(h(1: 5),'x',Tint);
irf_plot_axis_align(h(1: 10));
irf_zoom(h(6:10),'x',TintShow);
%irf_plot_axis_align(h(6: 6));
irf_plot_zoomin_lines_between_panels(h(5),h(6));

% add tmarks and mark intervals
% add line marks
tmarks=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');
irf_pl_mark(h(6:10),tmarks,'black','LineWidth',0.5)

% 4.X. global
%load('caa/cmap.mat');
%c_eval('title(h(1),''MMS?'')',ic);


set(h(2: 10),'fontsize',myFontSize);

%irf_zoom(h,'x',Tint);






%%%align aix
%%
exportgraphics(gcf,'figure1s.png','Resolution',300)

exportgraphics(gcf,'figure1s.pdf','ContentType','vector')%vector

%exportgraphics(gcf,'figure1s.pdf','ContentType','image')%vector

exportgraphics(gcf,'figure1s.emf')