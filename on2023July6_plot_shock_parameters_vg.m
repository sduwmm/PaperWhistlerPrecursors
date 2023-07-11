%
%colorBlue=ones(length(arrMaYes),1)*[0,0.4470,0.7410];
%colorOrange=ones(length(arrMaYes),1)*[0.8500,0.3250,0.0980];
%figAmpS.MarkerFaceColor=[255,22,93]/256;
%figAmpS.MarkerEdgeColor=[246,65,108]/256;
%close all;
clear all;
colorBlue=[30,144,255]/256;
colorRed=[255,22,93]/256;
colorBlue=[115 155 255]/256;
colorRed=[255 115 115]/256;
%
wmmDotSize=80;%70
wmmLineWidth=0.6;
wmmFontSize=14;
legendSize=13;
%
edgeColorGrey=[51 51 51]/256;
faceColorGrey=[136 136 136]/256;
%
faceColorRed=[255 115 115]/256;
edgeColorRed=[255 51 102]/256;
edgeColorBlue=[115 115 255]/256;
faceColorBlue=[115 0 255]/256;
%
edgeColor=[255 102 0]/256;
faceColor=[255 204 0]/256;
% Define binary colormap
%bgrcmap = [[0 0 1]; [1 0 0]];
arrBlue=[0 153 255]/256;
arrOrange=[255 102 0]/256;
trpCmap = [arrBlue;arrOrange];
%%-------------------------------------------------------------------------
edgeColorWarm=[255 102 0]/256;
faceColorWarm=[255 153 51]/256;
%
%faceColorOrange=[255 204 0]/256;
%edgeColorOrange=[255 102 0]/256;
%
faceColorCold=[0 204 255]/256;
edgeColorCold=[0 102 255]/256;
%
edgeColorGrey=[51 51 51]/256;
faceColorGrey=[136 136 136]/256;
%
allDatabase=load('AllData-05-Jul-2023.mat');
cellAll=allDatabase.database;
%%
arrPrecursorYes=[];
arrPrecursorNo=[];
arrMaYes=[];
arrMaNo=[];
arrThetaBNYes=[];
arrThetaBNNo=[];
%
arrLambda=[];
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
arrFreSRF=[];
arrDeltaVgrSh=[];
%
arrDeltaVphSh=[];
%
testFT=[];
%
for ft=1:30
    precursorLabel=cellAll{ft,31};
    %trange=structFTData.trange;
    %颜色借助ft的值来区分
    if precursorLabel==0
        nnoo=precursorLabel;
        arrPrecursorNo=[arrPrecursorNo;nnoo];
        ma=cellAll{ft,22};
        arrMaNo=[arrMaNo;ma];
        thetaBN=cellAll{ft,19};
        arrThetaBNNo=[arrThetaBNNo;thetaBN];
    end
    if precursorLabel==1
        yyeess=precursorLabel;
        arrPrecursorYes=[arrPrecursorYes;yyeess];
        ma=cellAll{ft,22};
        arrMaYes=[arrMaYes;ma];
        thetaBN=cellAll{ft,19};
        arrThetaBNYes=[arrThetaBNYes;thetaBN];
        %
        speedShSC=cellAll{ft,7};
        normShSC=cellAll{ft,9};
        velSW=cellAll{ft,26};
        %------------------------------------------------------------------
        freSC=cellAll{ft,33};
        valuePhaseSpeedSC=cellAll{ft,36};
        waveNormal=cellAll{ft,37};
        lambda=valuePhaseSpeedSC/freSC;
        %
        arrLambda=[arrLambda;lambda];
        arrPhaseSpeedSC      =[arrPhaseSpeedSC;valuePhaseSpeedSC];
        arrWaveNormal        =[arrWaveNormal;waveNormal];
        %
        vphPRF=valuePhaseSpeedSC-(waveNormal(1)*velSW(1)+waveNormal(2)*velSW(2)+waveNormal(3)*velSW(3));
        %------------------------------------------------------------------
        cosThetaKN=(waveNormal(1)*normShSC(1)+waveNormal(2)*normShSC(2)+waveNormal(3)*normShSC(3))/(norm(waveNormal)*norm(normShSC));
        thetaKN=acos(cosThetaKN)/pi*180;
        arrThetaKN=[arrThetaKN;thetaKN];
        %------------------------------------------------------------------
        waveAmplitude=cellAll{ft,41};
        arrWaveAmplitude=[arrWaveAmplitude;waveAmplitude];
        bxyzUp=cellAll{ft,18};
        bRamp=cellAll{ft,13};
        ampNormByBup=waveAmplitude/bxyzUp(4);
        ampNormByRamp=waveAmplitude/bRamp;
        arrAmpByBo=[arrAmpByBo;ampNormByBup];
        arrAmpByRamp=[arrAmpByRamp;ampNormByRamp];
        testFT=[testFT;ft];
        %
        %
        deltaVgrSh=cellAll{ft,53};
        arrDeltaVgrSh=[arrDeltaVgrSh;deltaVgrSh];
        %
        deltaVphSh=cellAll{ft,49};
        arrDeltaVphSh=[arrDeltaVphSh;deltaVphSh];
    end
end

%%
figC=figure;
set(figC,'unit','centimeter','position',[0.0,0.0,20,20]);
widthSub=0.35;
heightSub=0.35;
%
axBN=axes('position',[0.13 0.53 widthSub heightSub]);
box on;
hold on;
%grid on;
ylim([0,90]);
xlim([0,8]);
yline(45,'--k');
ylabel(['\theta_{Bn} (°)'],'FontSize',wmmFontSize);
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
%
axYes=scatter(axBN,arrMaYes,arrThetaBNYes);
axYes.MarkerFaceColor=faceColorGrey;
axYes.MarkerEdgeColor=edgeColorGrey;
axYes.LineWidth=wmmLineWidth;
axYes.SizeData=wmmDotSize;
%xline(3,'--k');
%{
arrYY=linspace(0,90,100);
arrMw =abs(cos(arrYY./180.*pi))./(2.*sqrt(1./1836));
arrMw =0.5*sqrt(1836).*abs(cos(arrYY./180.*pi));
arrMnw=abs(cos(arrYY./180.*pi))./sqrt(2.*(1/1836));
arrMnw=sqrt(0.5)*sqrt(1836).*abs(cos(arrYY./180.*pi));
arrMgr=abs(cos(arrYY./180.*pi))./8.*sqrt(27/(1/1836));
arrMgr=sqrt(27/64*1836).*abs(cos(arrYY./180.*pi));
plot(arrMw, arrYY,'r');
plot(arrMnw,arrYY,'g');
plot(arrMgr,arrYY,'r-');
%}
axNo=scatter(axBN,arrMaNo,arrThetaBNNo,'MarkerEdgeColor',edgeColor, 'MarkerFaceColor',[1 1 1], 'LineWidth',wmmLineWidth);
axNo.MarkerEdgeColor=edgeColorGrey;
axNo.MarkerFaceColor=[1 1 1];
axNo.SizeData=wmmDotSize;
axNo.LineWidth=wmmLineWidth;
%
ldgBnMa=legend([axNo,axYes],'Precursors absent','Precursors present','Location','southwest','box','off','fontsize',9);%,'Orientation','horizontal');
set(gca,'xticklabel',[]);
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(a)','fontweight','Bold','fontsize',wmmFontSize)
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');


%--------------------------------------------------------------------------
colorArr=ones(length(arrMaYes),1)*[0 0 0];
%colorOrange=ones(length(arrMaYes),1)*colorRed;
%%-------------------------------------------------------------------------
%%
axesAmp=axes('position',[0.63 0.53 widthSub heightSub]);
%grid on;
box on;
hold on;
yline(0.1,'--k');
xlabel('M_{A}','FontSize',wmmFontSize);
ylabel('Amplitude','FontSize',wmmFontSize);
xlim([0,8]);
ylim([0,3]);
%
set(gca,'xticklabel',[]);
yticks([0,1,2,3])
yticklabels({'0','1','2','3'})
%
axAmpS=scatter(axesAmp,arrMaYes,arrAmpByRamp, 25, colorArr, 'filled');
%axAmpS.Marker='d';
axAmpS.MarkerFaceColor=faceColorRed;
axAmpS.MarkerEdgeColor=edgeColorRed;
axAmpS.SizeData=wmmDotSize;
axAmpS.LineWidth=wmmLineWidth;
%
axAmpB=scatter(axesAmp,arrMaYes,arrAmpByBo);
%axAmpB.Marker='^';
axAmpB.MarkerFaceColor=faceColorCold;
axAmpB.MarkerEdgeColor=edgeColorCold;
axAmpB.SizeData=wmmDotSize;
axAmpB.LineWidth=wmmLineWidth;
%
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.87*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize)
legendAmp=legend([axAmpS,axAmpB],{'\delta B/B_{ramp}','\delta B/B_{up}'},'Location','none','Orientation','vertical','Interpreter','tex','box','off','fontsize',9);
legendAmp.Position=[0.6,0.8,0.2,0.05];
%
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
%%-------------------------------------------------------------------------
%%
axexKN=axes('position',[0.13 0.16 widthSub heightSub]);
hold on;
box on;
%grid on
ylabel(['\theta_{kn} (°)'],'FontSize',wmmFontSize);
xlabel(['M_{A}'],'FontSize',wmmFontSize);
ylim([0,90]);
xlim([0,8]);
yline(45,'--k');
%set(gca,'xticklabel',[]);
%xticks([0,2,4,6,7])
%xticklabels({'0','2','4','6','7'})
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
%
axKN=scatter(axexKN,arrMaYes,arrThetaKN);
axKN.MarkerEdgeColor=edgeColorGrey;
axKN.MarkerFaceColor=faceColorGrey;
axKN.LineWidth=wmmLineWidth;
axKN.SizeData=wmmDotSize;
%
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize)
%
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');

%--------------------------------------------------------------------------
axesPh=axes('position',[0.63 0.16 widthSub heightSub]);
box on
hold on
%grid on
%{
axesPh.XGrid='on'
axesPh.GridAlpha=0.1;
axesPh.YGrid='on'
%}
%xticks([0,2,4,6,7])
%xticklabels({'0','2','4','6','7'})
yticks([-200,0,200,400])
yticklabels({'-200','0','200','400'})
ylabel(['\Delta V (km/s)'],'FontSize',wmmFontSize);
xlabel(['M_{A}'],'FontSize',wmmFontSize);
ylim([-200,400]);
xlim([0,8]);
yline(0,'--k');
%xline(3,'--k');
%
axPh=scatter(axesPh,arrMaYes,arrDeltaVphSh);
axPh.MarkerEdgeColor=edgeColorGrey;
axPh.MarkerFaceColor=[1 1 1];
axPh.LineWidth=wmmLineWidth;
axPh.SizeData=wmmDotSize;
axPh.Marker='d';
%
axGr=scatter(axesPh,arrMaYes,arrDeltaVgrSh);
axGr.MarkerEdgeColor=edgeColorGrey;
axGr.MarkerFaceColor=faceColorGrey;
axGr.SizeData=wmmDotSize;
axGr.LineWidth=wmmLineWidth;
%axGr.Marker='^';

%
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.87*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)
legendDv=legend([axGr,axPh],{'\Delta V_{1}=V_{gr}^{prf}cos \theta_{gr,n}-V_{sw}^{srf}cos \theta_{vn}',...
    '\Delta V_{2}=V_{ph}^{prf}cos \theta_{kn}-V_{sh}^{prf}'},...
    'Location','none','Orientation','vertical','Interpreter','tex','box','off','fontsize',9);
legendDv.Position=[0.62,0.152,0.3,0.1];
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2,'layer','top');

%% -----------------------------------------------------------------
dateToday=date;
strFig=['figure3-',dateToday];
exportgraphics(gcf,[strFig,'.png'],'Resolution',300)

exportgraphics(gcf,[strFig,'.pdf'],'ContentType','vector')%vector

%exportgraphics(gcf,'figure1s.pdf','ContentType','image')%vector

exportgraphics(gcf,[strFig,'.emf'])

