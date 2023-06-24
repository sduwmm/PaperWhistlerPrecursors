%close all;
clear all;
colorBlue=[30,144,255]/256;
colorRed=[255,22,93]/256;
sizeB=8;
LineWidth=0.6;
wmmFontSize=10;
edgeColor=[51 51 51]/256;
faceColor=[136 136 136]/256;
%%-------------------------------------------------------------------------
%figPath='C:\Users\20171\OneDrive - mail.sdu.edu.cn\AAA_worklog_2023\paper_whistler_figure\';
% dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\';
% listName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\_list.txt';
dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\';
listName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\_list.txt';
% if exist(figPath)==0 %%判断文件夹是否存在
%     mkdir(figPath);  %%不存在时候，创建文件夹
% else
%     disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
% end
fileID = fopen(listName);
cellList=textscan(fileID,'%s');%%%
fclose(fileID);
%
listFT=cellList{1,1};
%
arrTest=[];
arrPrecursorYes=[];
arrPrecursorNo=[];
arrMaYes=[];
arrMaNo=[];
arrThetaBNYes=[];
arrThetaBNNo=[];
%
arrPhaseSpeedSC=[];
arrUnPhaseSpeedSC=[];
arrWaveNormal=[];
arrUnWaveNormal=[];
arrWavenumber=[];
arrMgntdWavenumber=[];
arrUnWavenumber=[];
vphSC=[];
arrThetaKN=[];
arrWaveAmplitude=[];
arrBUp=[];
arrBRamp=[];
arrVphSC=[];
arrVshSC=[];
arrDeltaVover=[];
arrDeltaVdot=[];
arrAmpByBo=[];
arrAmpByRamp=[];
arrDeltaVphSh=[];
arrDeltaVgSh=[];

testFT=[];
for ft=1:30
    matList=listFT{ft,1};
    load([dataPath,matList],'-mat');
    arrTest=[arrTest;structFTData.PrecursorLabel];
    trange=structFTData.trange;
    %颜色借助ft的值来区分
    if structFTData.PrecursorLabel==0
        nnoo=structFTData.PrecursorLabel;
        arrPrecursorNo=[arrPrecursorNo;nnoo];
        ma=structFTData.FTShockMaUpstream;
        arrMaNo=[arrMaNo;ma];
        thetaBN=structFTData.FTShockThetaBnUp;
        arrThetaBNNo=[arrThetaBNNo;thetaBN];
    end
    if structFTData.PrecursorLabel==1
        yyeess=structFTData.PrecursorLabel;
        arrPrecursorYes=[arrPrecursorYes;yyeess];
        ma=structFTData.FTShockMaUpstream;
        arrMaYes=[arrMaYes;ma];
        thetaBN=structFTData.FTShockThetaBnUp;
        arrThetaBNYes=[arrThetaBNYes;thetaBN];
        speedShSC=structFTData.FTShockSpeedScTiming;
        normShSC=structFTData.FTShockNormalTiming;
        velSW=structFTData.FTShockVelocityUpstream;
        %------------------------------------------------------------------
        valuePhaseSpeedSC    =structFTData.vphSCTiming;
        waveNormal           =structFTData.kDirTiming;
        %
        arrPhaseSpeedSC      =[arrPhaseSpeedSC;valuePhaseSpeedSC];
        arrWaveNormal        =[arrWaveNormal;waveNormal];
        %
        freSC=structFTData.frequencyHzSCPeak;
        vphPRF=valuePhaseSpeedSC-(waveNormal(1)*velSW(1)+waveNormal(2)*velSW(2)+waveNormal(3)*velSW(3));
        %------------------------------------------------------------------
        cosThetaKN=(waveNormal(1)*normShSC(1)+waveNormal(2)*normShSC(2)+waveNormal(3)*normShSC(3))/(norm(waveNormal)*norm(normShSC));
        thetaKN=acos(cosThetaKN)/pi*180;
        arrThetaKN=[arrThetaKN;thetaKN];
        %------------------------------------------------------------------
        U1=velSW-speedShSC*normShSC;%upstream sw in the SRF
        cosThetaVN=(normShSC(1)*velSW(1)+normShSC(2)*velSW(2)+normShSC(3)*velSW(3))/(norm(normShSC)*norm(velSW));
        deltaVgSh=2*abs(vphPRF)*cosThetaKN-norm(U1)*cosThetaVN;
        arrDeltaVgSh=[arrDeltaVgSh;deltaVgSh];
        %------------------------------------------------------------------
        %vShPRF=speedShSC*normShSC-velSW;
        %vShPRF=norm(U1);
        vShPRF=speedShSC-(normShSC(1)*velSW(1)+normShSC(2)*velSW(2)+normShSC(3)*velSW(3));
        %deltaVphSh=norm(vShPRF)/cosThetaKN-abs(vphPRF);
        deltaVphSh=abs(vphPRF)*cosThetaKN-abs(vShPRF);
        %deltaVphSh=abs(vphPRF)*cosThetaKN-norm(U1)*cosThetaVN;%%%%on 2023-05-18, for Terry's comments
        arrDeltaVphSh=[arrDeltaVphSh;deltaVphSh];
        %------------------------------------------------------------------
        waveAmplitude=structFTData.PrecursorsAmplitude;
        arrWaveAmplitude=[arrWaveAmplitude;waveAmplitude];
        bUp=structFTData.upstreamB;
        arrBUp=[arrBUp;bUp];
        bRamp=structFTData.FTShockRampAmplitude;
        arrBRamp=[arrBRamp;bRamp];
        ampNormByBup=waveAmplitude/bUp(4);
        ampNormByRamp=waveAmplitude/bRamp;
        arrAmpByBo=[arrAmpByBo;ampNormByBup];
        arrAmpByRamp=[arrAmpByRamp;ampNormByRamp];
        %arrVphSC=[];
        %arrVshSC=[];        
        testFT=[testFT;ft];
    end
end


%%
figC=figure;
set(figC,'unit','centimeter','position',[0.0,0.0,16,16]);
widthSub=0.35;
heightSub=0.35;
figBN=subplot(2,2,1);
set(figBN,'position',[0.13 0.53 widthSub heightSub]);
x2=scatter(figBN,arrMaYes,arrThetaBNYes,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
hold on;
%xline(3,'--k');
arrYY=linspace(0,90,100);
arrMw =abs(cos(arrYY./180.*pi))./(2.*sqrt(1./1836));
arrMw =0.5*sqrt(1836).*abs(cos(arrYY./180.*pi));
arrMnw=abs(cos(arrYY./180.*pi))./sqrt(2.*(1/1836));
arrMnw=sqrt(0.5)*sqrt(1836).*abs(cos(arrYY./180.*pi));
arrMgr=abs(cos(arrYY./180.*pi))./8.*sqrt(27/(1/1836));
arrMgr=sqrt(27/64*1836).*abs(cos(arrYY./180.*pi));
%plot(arrMw, arrYY,'r');
%plot(arrMnw,arrYY,'g');
%plot(arrMgr,arrYY,'r-');
x1=scatter(figBN,arrMaNo,arrThetaBNNo,'MarkerEdgeColor',edgeColor, 'MarkerFaceColor',[1 1 1], 'LineWidth',LineWidth);
hold on;
ylim([0,90]);
xlim([0,7]);
yline(45,'--k');
ylabel(['\theta_{Bn} (°)'],'FontSize',wmmFontSize);
legend([x1,x2],'Precursors absent','Precursors present','Location','southwest','box','on','fontsize',9);%,'Orientation','horizontal');
box on
set(gca,'xticklabel',[]);
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(a)','fontweight','Bold','fontsize',wmmFontSize)
%--------------------------------------------------------------------------
colorBlue=ones(length(arrMaYes),1)*[0,0.4470,0.7410];
colorOrange=ones(length(arrMaYes),1)*[0.8500,0.3250,0.0980];
%%-------------------------------------------------------------------------
figAmp=subplot(2,2,2);
set(figAmp,'position',[0.6 0.53 widthSub heightSub]);
figAmpS=scatter(figAmp,arrMaYes,arrAmpByRamp, 25, colorBlue, 'filled');
figAmpS.MarkerFaceColor=[255,22,93]/256;
figAmpS.MarkerEdgeColor=[246,65,108]/256;

hold on;
figAmpB=scatter(figAmp,arrMaYes,arrAmpByBo,25,colorOrange,'filled');

figAmpB.MarkerFaceColor=[111,231,221]/256;
figAmpB.MarkerEdgeColor=[62,193,211]/256;
xlim([0,7]);
ylim([0,4]);
yline(0.1,'--k');
xlabel('M_{A}','FontSize',wmmFontSize);
ylabel('Amplitude','FontSize',wmmFontSize);
box on;
%set(gca,'xtick',[],'xticklabel',[]);

set(gca,'xticklabel',[]);
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.87*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize)
legendAmp=legend([figAmpS,figAmpB],{'\delta B/B_{ramp}','\delta B/B_{up}'},'Location','none','Orientation','vertical','Interpreter','tex','box','off','fontsize',9);
legendAmp.Position=[0.55,0.77,0.3,0.1];
%%-------------------------------------------------------------------------
%%
figKN=subplot(2,2,3);
set(figKN,'position',[0.13 0.17 widthSub heightSub]);
scatter(figKN,arrMaYes,arrThetaKN,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
ylabel(['\theta_{kn} (°)'],'FontSize',wmmFontSize);
xlabel(['M_{A}'],'FontSize',wmmFontSize);
ylim([0,90]);
xlim([0,7]);
yline(45,'--k');
%set(gca,'xticklabel',[]);
box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize)
%--------------------------------------------------------------------------
figPh=subplot(2,2,4);
set(figPh,'position',[0.6 0.17 widthSub heightSub]);
axGr=scatter(figPh,arrMaYes,arrDeltaVgSh,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
hold on;
axPh=scatter(figPh,arrMaYes,arrDeltaVphSh,'d','k');
ylabel(['\Delta V (km/s)'],'FontSize',wmmFontSize);

xlabel(['M_{A}'],'FontSize',wmmFontSize);
ylim([-320,320]);
xlim([0,7]);
yline(0,'--k');
%xline(3,'--k');
box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.87*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)
legendDv=legend([axGr,axPh],{'\Delta V_{1}=V_{gr}^{prf}cos \theta_{kn}-V_{sw}^{srf}cos \theta_{vn}',...
    '\Delta V_{2}=V_{ph}^{prf}cos \theta_{kn}-V_{sh}^{prf}'},...
'Location','none','Orientation','vertical','Interpreter','tex','box','off','fontsize',9);
legendDv.Position=[0.62,0.17,0.3,0.1];


print(figC,'figure3','-dpdf','-r0');
print(figC,'figure3','-dpng','-r600');



