%{
results from analysis with band-filter 0.5-5Hz
average and uncertain from results from Bx, By and Bz
B dir without uncertain
Vph and wave normal angle, uncertain
Moments, uncertain
%}
clear all;
%close all;
%%%init------------------------------------------------------------------->
colorBlue=[30,144,255]/256;
colorRed=[255,22,93]/256;
%
edgeColorGrey=[51 51 51]/256;
faceColorGrey=[136 136 136]/256;
%
edgeColorWarm=[255 115 115]/256;
faceColorWarm=[115 115 255]/256;
%
wmmDotSize=80;
wmmLineWidth=0.6;
wmmFontSize=14;
%%%init<-------------------------------------------------------------------
%%%empty array or cell to store data-------------------------------------->
arrTest              =[];
arrPrecursorYes      =[];
arrPhaseSpeedSC      =[];
arrWaveNormal        =[];
arrPhaseSpeedPRFnorm =[];
arrFrePRFnorm        =[];
%
arrFreSC             =[];
arrFrePRF            =[];
arrPhaseSpeedPRF     =[];
arrWavenumber        =[];
arrOmegaPRF          =[];
arrLambda            =[];
arrOmegaNorm         =[];
arrOmegaNormKB       =[];
arrWavenumberNorm    =[];
arrThetaKV           =[];
arrThetaKBTiming     =[];
arrThetaKBSVD        =[];
arrSeparation        =[];
testFT               =[];
arr_lambda_i         =[];
%%%<--------------------------------------empty array or cell to store data

%%
allDatabase=load('AllData-05-Jul-2023.mat');
cellAll=allDatabase.database;
%5

for ft=1:30
    precursorLabel=cellAll{ft,31};
    if precursorLabel==1
        yyeess=precursorLabel;
        arrPrecursorYes=[arrPrecursorYes;yyeess];
        %
        trange               =cellAll{ft,3};
        valuePhaseSpeedSC    =cellAll{ft,36};
        waveNormal           =cellAll{ft,37};
        %
        arrPhaseSpeedSC      =[arrPhaseSpeedSC;valuePhaseSpeedSC];
        arrWaveNormal        =[arrWaveNormal;waveNormal];
        %
        freSC=cellAll{ft,33};
        velSW=cellAll{ft,26};
        %
        lambda=valuePhaseSpeedSC/freSC;
        wavenumber=2*pi/lambda;
        lambda=valuePhaseSpeedSC/freSC;
        fprf=freSC-(waveNormal(1)*velSW(1)+waveNormal(2)*velSW(2)+waveNormal(3)*velSW(3))/lambda;
        omegaPRF=2*pi*fprf;
        arrLambda=[arrLambda;lambda];
        arrWavenumber=[arrWavenumber;wavenumber];
        arrFreSC=[arrFreSC;freSC];
        arrFrePRF=[arrFrePRF;fprf];
        arrOmegaPRF=[arrOmegaPRF;omegaPRF];
        
        %wavenumber=freSC/valuePhaseSpeedSC;%%%/km
        Bxyz=cellAll{ft,46};
        Bt=norm(Bxyz);
        Vxyz=cellAll{ft,26};
        N=cellAll{ft,14};
        %
        cosThetaKB=(waveNormal(1)*Bxyz(1)+waveNormal(2)*Bxyz(2)+waveNormal(3)*Bxyz(3))/(norm(waveNormal)*norm(Bxyz));
        thetaKBTiming=cellAll{ft,39};
        arrThetaKBTiming=[arrThetaKBTiming;thetaKBTiming];
        thetaKBSVD=cellAll{ft,40};
        arrThetaKBSVD=[arrThetaKBSVD;thetaKBSVD];
        %
        cosThetaKV=(waveNormal(1)*Vxyz(1)+waveNormal(2)*Vxyz(2)+waveNormal(3)*Vxyz(3))/(norm(waveNormal)*norm(Vxyz));
        thetaKV=acos(cosThetaKV)/pi*180;
        arrThetaKV=[arrThetaKV;thetaKV];
        %
        valuePhaseSpeedPRF=valuePhaseSpeedSC-norm(Vxyz)*cosThetaKV;
        arrPhaseSpeedPRF=[arrPhaseSpeedPRF;valuePhaseSpeedPRF];
        %
        %
        [structPlasmaParas]=calculate_plasma_parameters(Bt,N);
        %
        omega_lh=structPlasmaParas.omega_lh;
        lambda_i=structPlasmaParas.lambda_i;
        arr_lambda_i=[arr_lambda_i,lambda/lambda_i];
        omegaNorm=abs(omegaPRF)/omega_lh;
        arrOmegaNorm=[arrOmegaNorm;omegaNorm];
        omegaNormKB=omegaNorm/abs(cos(thetaKBTiming/180*pi));
        arrOmegaNormKB=[arrOmegaNormKB;omegaNormKB];
        wavenumberNorm=norm(wavenumber*lambda_i);
        arrWavenumberNorm=[arrWavenumberNorm;wavenumberNorm];
        phaseSpeedPRFnorm=abs(valuePhaseSpeedPRF)/structPlasmaParas.va;
        arrPhaseSpeedPRFnorm=[arrPhaseSpeedPRFnorm;phaseSpeedPRFnorm];
        frePRFnorm=abs(fprf)/structPlasmaParas.f_lh;
        arrFrePRFnorm=[arrFrePRFnorm;frePRFnorm];
        %
        separation=cellAll{ft,44};
        separation=separation(4);
        arrSeparation=[arrSeparation;separation];
    end
end
%%
figB=figure;
set(figB,'unit','centimeter','position',[0.0,0.0,20,20]);
%set(figB,'position',[0.0,0.0,800*0.6,800*0.6]);
widthSub=0.35;
heightSub=0.35;
%
%%
axesFre=axes('position',[0.13 0.62 widthSub heightSub]);
box on;
%grid on;
hold on;
xlim([0,45]);
ylim([-6,6]);
xticks([0,15,30,45])
xticklabels({'0','15','30','45'})
yticks([-6,-3,0,3,6])
yticklabels({'-6','-3','0','3','6'})
xlabel(['$\theta_{kV}$','(deg)'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
ylabel(['$$\mathsf{f (Hz)}$$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
%
axFreSCF=scatter(arrThetaKV,arrFreSC);
axFreSCF.MarkerEdgeColor=colorRed;
axFreSCF.MarkerFaceColor=[1 1 1];
axFreSCF.LineWidth=wmmLineWidth;
axFreSCF.SizeData=wmmDotSize;
%
axFrePRF=scatter(arrThetaKV,arrFrePRF);
axFrePRF.MarkerEdgeColor=edgeColorGrey;
axFrePRF.MarkerFaceColor=faceColorGrey;
axFrePRF.LineWidth=wmmLineWidth;
axFrePRF.SizeData=wmmDotSize;
%
%xline(45,'LineStyle','--');
yline(0,'LineStyle','--');
%text(47,2,'Right-handed in PRF frame','Color','blue','FontSize',wmmFontSize);%,'Interpreter','latex');%,'FontName','Lelvetica');
%text(47,-2,'Left-handed in SC frame','Color','red','FontSize',wmmFontSize);%,'Interpreter','latex');%,'FontName','Lelvetica');
%
% % % more beautiful
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(a)','fontweight','Bold','fontsize',wmmFontSize)
%%
axesKB=axes('position',[0.63 0.62 widthSub heightSub]);
%grid on;
box on;
hold on;
ylim([0,90]);
xlim([0,90]);
xline(45,'LineStyle','--');
yline(45,'LineStyle','--');
xticks([0,30,60,90])
xticklabels({'0','30','60','90'})
yticks([30,60,90])
yticklabels({'30','60','90'})
xlabel(['$\theta_{kB}$','-timing (deg)'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
ylabel(['$\theta_{kB}$','-SVD (deg)'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
%
axKB=scatter(arrThetaKBTiming,arrThetaKBSVD);
axKB.MarkerEdgeColor=edgeColorGrey;
axKB.MarkerFaceColor=faceColorGrey;
axKB.LineWidth=wmmLineWidth;
axKB.SizeData=wmmDotSize;
%
x=linspace(0,90,100);
y=x;
axYX=plot(x,y,'Color',colorBlue,'LineStyle','--','LineWidth',0.7);
text(axesKB,60,85,'y=x','Color',colorBlue,'Fontsize',wmmFontSize);
%
% % % more beautiful
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize)
%%
%set(figDisper,'position',[0.6 0.62 widthSub heightSub]);
axesVphFre=axes('position',[0.13 0.13 widthSub heightSub]);
box on;
hold on;
xlabel(['$$\mathsf{\omega/\omega_{lh}}$$'],'FontSize',wmmFontSize,'Interpreter','latex');
ylabel(['$$\mathsf{V_{ph}^{prf}/V_{A}}$$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
%
axVphFre=scatter(arrFrePRFnorm,arrPhaseSpeedPRFnorm);
axVphFre.MarkerEdgeColor=edgeColorGrey;
axVphFre.MarkerFaceColor=faceColorGrey;
axVphFre.LineWidth=wmmLineWidth;
axVphFre.SizeData=wmmDotSize;
ylim([0,8]);
xlim([0,1.5]);
% % % more beautiful
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize)
%%
axesDisper=axes('position',[0.63 0.13 widthSub heightSub]);
%grid on;
box on;
hold on;
ylabel(['$$\mathsf{\omega/\omega_{lh} \cos\theta_{kB}}$$'],'FontSize',wmmFontSize,'Interpreter','latex');
xlabel(['$k\lambda_i$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
%
axDot=scatter(arrWavenumberNorm,arrOmegaNormKB);
axDot.MarkerEdgeColor=edgeColorGrey;
axDot.MarkerFaceColor=faceColorGrey;
axDot.LineWidth=wmmLineWidth;
axDot.SizeData=wmmDotSize;
%
xx=linspace(0,15,100);
yy=xx.^2.*sqrt(1/1836);
axDR=plot(xx,yy,'color',colorBlue,'LineStyle','-');
%
axDotIons=scatter(4.7284,1.483);
axDotIons.MarkerEdgeColor=[1 0 0];
axDotIons.MarkerFaceColor=[1 0 0];
axDotIons.LineWidth=wmmLineWidth;
axDotIons.SizeData=wmmDotSize;
%}

axDotAlias=scatter(12.1,1.735);
axDotAlias.MarkerEdgeColor=[1 0 0];
axDotAlias.MarkerFaceColor=[1 0 0];
axDotAlias.LineWidth=wmmLineWidth;
axDotAlias.SizeData=wmmDotSize;
text(axesDisper,5,1.7,'1','color','r')
text(axesDisper,12.3,2.,'2','color','r');

%
xlim([0,15]);
ylim([0,5]);
%

set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','out','LineWidth',2.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)

%%
dateToday=date;
strFig=['figure2-',dateToday];
exportgraphics(gcf,[strFig,'.png'],'Resolution',300)
exportgraphics(gcf,[strFig,'.pdf'],'ContentType','vector')%vector
exportgraphics(gcf,[strFig,'.emf'])