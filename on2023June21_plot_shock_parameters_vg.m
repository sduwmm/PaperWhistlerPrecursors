%close all;
clear all;
colorBlue=[30,144,255]/256;
colorRed=[255,22,93]/256;
dotSize=70;
LineWidth=1.2;
wmmFontSize=14;
legendSize=13;
edgeColor=[51 51 51]/256;
faceColor=[136 136 136]/256;
% Define binary colormap
%bgrcmap = [[0 0 1]; [1 0 0]];
arrBlue=[0 153 255]/256;
arrOrange=[255 102 0]/256;
trpCmap = [arrBlue;arrOrange];
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
arrDeltaVgSh=[];
%
arrFrePRFnorm=[];
arrThetaKB=[];
%
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
        freSC=structFTData.frequencyHzSCPeak;
        valuePhaseSpeedSC    =structFTData.vphSCTiming;
        waveNormal           =structFTData.kDirTiming;
        lambda=valuePhaseSpeedSC/freSC;
        %
        arrLambda=[arrLambda;lambda];
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
        Bxyzt=structFTData.upstreamB;
        Bxyz=Bxyzt(1:3);
        Bt=norm(Bxyz);
        cosThetaKB=(waveNormal(1)*Bxyz(1)+waveNormal(2)*Bxyz(2)+waveNormal(3)*Bxyz(3))/(norm(waveNormal)*norm(Bxyz));
        thetaKB=acos(cosThetaKB)/pi*180;
        if thetaKB > 90
            thetaKB=180-thetaKB;
        end
        arrThetaKB=[arrThetaKB;thetaKB];
        % %----------------------------------------------------------------
        U1=velSW-speedShSC*normShSC;%upstream sw in the SRF
        cosThetaVN=(normShSC(1)*velSW(1)+normShSC(2)*velSW(2)+normShSC(3)*velSW(3))/(norm(normShSC)*norm(velSW));
        deltaVgSh=2*abs(vphPRF)*cosThetaKN-norm(U1)*cosThetaVN;
        arrDeltaVgSh=[arrDeltaVgSh;deltaVgSh];
        %------------------------------------------------------------------
        Bxyzt=structFTData.upstreamB;
        Bxyz=Bxyzt(1:3);
        Bt=norm(Bxyz);
        Vxyz=structFTData.FTShockVelocityUpstream;
        N=structFTData.upstreamDensity;
        [structPlasmaParas]=calculate_plasma_parameters(Bt,N);
        %--
        %vShPRF=speedShSC*normShSC-velSW;
        %vShPRF=norm(U1);
        vShPRF=speedShSC-(normShSC(1)*velSW(1)+normShSC(2)*velSW(2)+normShSC(3)*velSW(3));
        %deltaVphSh=norm(vShPRF)/cosThetaKN-abs(vphPRF);
        VphSh=abs(vphPRF)/cosThetaKN-abs(vShPRF);
        %deltaVphSh=abs(vphPRF)*cosThetaKN-norm(U1)*cosThetaVN;%%%%on 2023-05-18, for Terry's comments
        fSRF=VphSh/lambda;
        %arrFreSRF=[arrFreSRF;fSRF];
        %arrOmegaSRF=arrFreSRF*2*pi;
        frePRFnorm=fSRF/structPlasmaParas.f_lh;
        arrFrePRFnorm=[arrFrePRFnorm;frePRFnorm];
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
set(figC,'unit','centimeter','position',[0.0,0.0,18*2,12*2]);
widthSub=0.35*2/3;
heightSub=0.35;
%figBN=subplot(2,3,1);
%set(figBN,'position',[0.13 0.53 widthSub heightSub]);
axBN=axes('position',[0.10 0.53 widthSub heightSub]);
x2=scatter(axBN,arrMaYes,arrThetaBNYes,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
x2.SizeData=dotSize;
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
x1=scatter(axBN,arrMaNo,arrThetaBNNo,'MarkerEdgeColor',edgeColor, 'MarkerFaceColor',[1 1 1], 'LineWidth',LineWidth);
x1.SizeData=dotSize;
hold on;
ylim([0,90]);
xlim([0,7]);
yline(45,'--k');
ylabel(['\theta_{Bn} (deg)'],'FontSize',wmmFontSize);
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
legend([x1,x2],'Precursors absent','Precursors present','Location','southwest','box','off','fontsize',legendSize);%,'Orientation','horizontal');
box on
set(gca,'xticklabel',[]);
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(a)','fontweight','Bold','fontsize',wmmFontSize)
%--------------------------------------------------------------------------
colorBlue=ones(length(arrMaYes),1)*[0,0.4470,0.7410];
colorOrange=ones(length(arrMaYes),1)*[0.8500,0.3250,0.0980];
%%
axKN=axes('position',[0.4133-0.015 0.53 widthSub heightSub]);
box on;
hold on;
ylabel(['\theta_{kn} (deg)'],'FontSize',wmmFontSize);
ylim([0,90]);
xlim([0,7]);
yline(45,'--k');
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
set(gca,'xticklabel',[]);
kn=scatter(axKN,arrMaYes,arrThetaKN,dotSize,arrThetaBNYes,'filled');
%colormap(axKN,'jet');
colormap(axKN,trpCmap);
set(gca,'clim',[0 90]);%%%thetaBN不是[0,90],先设置成【0，90】
% cBN1=colorbar;
% cBN1.Limits=[0 90];
% cBN1.Ticks=[0 45 90];
% cBN1.Ticks=[];
% cBN1.Location='North';
% cBN1.Position=[0.4133 0.89 0.5167 0.04];
%ylabel(cBN1,'\theta_{Bn} (deg)','interpreter','tex','fontsize',wmmFontSize)
para=scatter(axKN,-1,30,1,arrOrange,'filled');
perp=scatter(axKN,-1,60,1,arrBlue,'filled');
lgdPP=legend([para,perp],'Quasi-parallel FT shock','Quasi-Perpendicular FT shock','Location','none','box','off','fontsize',legendSize+3,'Orientation','horizontal');
lgdPP.Position=[0.3983 0.895 0.5167+0.015 0.02];
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize)
%--------------------------------------------------------------------------
% %
figKB=axes('position',[0.6967 0.53 widthSub heightSub]);
box on;
hold on;
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
ylim([0,90]);
xlim([0,7]);
yline(45,'--k');
set(gca,'xticklabel',[]);
ylabel('\theta_{kB} (deg)','FontSize',wmmFontSize);
yticks([0,30,60,90])
yticklabels({'0','30','60','90'})
scatter(figKB,arrMaYes,arrThetaKB,dotSize,arrThetaBNYes,'filled');
% %
colormap(figKB,trpCmap);
set(gca,'clim',[0 90])
% %
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize)
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
%% -------------------------------------------------------------------------
axAmp=axes('position',[0.10 0.15 widthSub heightSub]);
box on;
hold on;
xticks([0,2,4,6,7])
xticklabels({'0','2','4','6','7'})
yticks([0,1,2,3])
yticklabels({'0','1','2','3'})
xlim([0,7]);
ylim([0,3]);
yline(0.1,'--k');
xlabel('M_{A}','FontSize',wmmFontSize);
ylabel('Amplitude','FontSize',wmmFontSize);
hold on;
figAmpS=scatter(axAmp,arrMaYes,arrAmpByRamp, dotSize, colorBlue, 'filled');
figAmpS.MarkerFaceColor=[255,22,93]/256;
figAmpS.MarkerEdgeColor=[246,65,108]/256;
%
figAmpB=scatter(axAmp,arrMaYes,arrAmpByBo,dotSize,colorOrange,'filled');
figAmpB.MarkerFaceColor=[111,231,221]/256;
figAmpB.MarkerEdgeColor=[62,193,211]/256;
%set(gca,'xtick',[],'xticklabel',[]);
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.87*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)
legendAmp=legend([figAmpS,figAmpB],{'\delta B/B_{ramp}','\delta B/B_{up}'},...
    'Location','northwest','Orientation','vertical',...
    'Interpreter','tex','box','off','fontsize',legendSize);
%legendAmp.Position=[0.03 0.37 0.3,0.1];
% % %-------------------------------------------------------------------------
%%
axVgr=axes('position',[0.4133-0.015 0.15 widthSub heightSub]);
box on;
hold on;
xticks([0,2,4,6,7]);
xticklabels({'0','2','4','6','7'});
xlabel('M_{A}','FontSize',wmmFontSize);
ylabel(['\Delta V (km/s)'],'FontSize',wmmFontSize);
%
ylim([-50,320]);
ylim([-320,320]);
xlim([0,7]);
yline(0,'--k');
text(axVgr,0.1,50,'\uparrow Upstream','Fontweight','Bold','FontSize',wmmFontSize);
text(axVgr,0.1,-50,'\downarrow Downstream','Fontweight','Bold','FontSize',wmmFontSize);
% %
%axGr=scatter(figVgr,arrMaYes,arrDeltaVgSh,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
scatter(axVgr,arrMaYes,arrDeltaVgSh,dotSize,arrThetaBNYes,'filled');
colormap(axVgr,trpCmap);
set(gca,'clim',[0 90]);%%%thetaBN不是[0,90],先设置成[0，90]

gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(e)','fontweight','Bold','fontsize',wmmFontSize)
set(axVgr,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
%%
% % %----------------------------------------------------------------------
axFsrf=axes('position',[0.6967 0.15 widthSub heightSub]);
box on;
hold on;
xticks([0,2,4,6,7]);
xticklabels({'0','2','4','6','7'});
xlabel('M_{A}','FontSize',wmmFontSize);
ylabel(['\omega_{srf}/\omega_{lh}'],'FontSize',wmmFontSize);
xlim([0,7]);
ylim([-0.6,0.6]);
phaseStanding=yline(0,'--k');
phaseStanding.Color=[255 22 93]/256;
strPhase=text(axFsrf,0.1,0.05,'Phase','Fontweight','Bold','FontSize',wmmFontSize);
strStanding=text(axFsrf,0.1,-0.05,'standing','Fontweight','Bold','FontSize',wmmFontSize);
strPhase.Color=[255 22 93]/256;
strStanding.Color=[255 22 93]/256;
%axPh=scatter(figFsrf,arrMaYes,arrFrePRFnorm,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
scatter(axFsrf,arrMaYes,arrFrePRFnorm,dotSize,arrThetaBNYes,'filled');
colormap(axFsrf,trpCmap);
set(gca,'clim',[0 90]);%%%thetaBN不是[0,90],先设置成[0，90]
% %
gcaxlim=get(axFsrf,'Xlim');
gcaylim=get(axFsrf,'Ylim');
text(0.03*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(f)','fontweight','Bold','fontsize',wmmFontSize)
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
%% -----------------------------------------------------------------
dateToday=date;
strFig=['figure3-',dateToday];
exportgraphics(gcf,[strFig,'.png'],'Resolution',300)

exportgraphics(gcf,[strFig,'.pdf'],'ContentType','vector')%vector

%exportgraphics(gcf,'figure1s.pdf','ContentType','image')%vector

exportgraphics(gcf,[strFig,'.emf'])


