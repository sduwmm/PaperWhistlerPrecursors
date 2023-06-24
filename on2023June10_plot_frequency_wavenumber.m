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
edgeColor=[51 51 51]/256;
faceColor=[136 136 136]/256;
sizeB=8;
LineWidth=0.8;
wmmFontSize=14;
%%%init<-------------------------------------------------------------------
%figPath='C:\Users\20171\OneDrive - mail.sdu.edu.cn\AAA_worklog_2023\paper_whistler_figure\';
% listName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\_list.txt';
% dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\';
listName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\_list.txt';
dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\';
%
fileID = fopen(listName);
cellList=textscan(fileID,'%s');%%%
fclose(fileID);
%
listFT=cellList{1,1};
%%%empty array or cell to store data-------------------------------------->
arrTest              =[];
arrPhaseSpeedSC      =[];
arrUnPhaseSpeedSC    =[];
arrWaveNormal        =[];
arrUnWaveNormal      =[];
arrPhaseSpeedPRFnorm =[];
arrFrePRFnorm        =[];
%
arrFreSC             =[];
arrFrePRF            =[];
arrPhaseSpeedPRF     =[];
arrWavenumber        =[];
arrOmegaPRF          =[];
arrLambda            =[];
arrThetaKB           =[];
arrOmegaNorm         =[];
arrOmegaNormKB       =[];
arrWavenumberNorm    =[];
arrThetaKV           =[];
arrThetaKBSVD        =[];
arrSeparation        =[];
%%%<--------------------------------------empty array or cell to store data
testFT=[];
arr_lambda_i=[];
for ft=1:30
    matList=listFT{ft,1};
    load([dataPath,matList],'-mat');
    arrTest=[arrTest;structFTData.PrecursorLabel];
    %颜色借助ft的值来区分
    if structFTData.PrecursorLabel==1
        %
        testFT=[testFT;ft];
        trange               =structFTData.trange;
        valuePhaseSpeedSC    =structFTData.vphSCTiming;
        waveNormal           =structFTData.kDirTiming;
        %
        arrPhaseSpeedSC      =[arrPhaseSpeedSC;valuePhaseSpeedSC];
        arrWaveNormal        =[arrWaveNormal;waveNormal];
        %
        freSC=structFTData.frequencyHzSCPeak;
        velSW=structFTData.FTShockVelocityUpstream;
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
        Bxyzt=structFTData.upstreamB;
        Bxyz=Bxyzt(1:3);
        Bt=norm(Bxyz);
        Vxyz=structFTData.FTShockVelocityUpstream;
        N=structFTData.upstreamDensity;
        %
        cosThetaKB=(waveNormal(1)*Bxyz(1)+waveNormal(2)*Bxyz(2)+waveNormal(3)*Bxyz(3))/(norm(waveNormal)*norm(Bxyz));
        thetaKB=acos(cosThetaKB)/pi*180;
        if thetaKB > 90
            thetaKB=180-thetaKB;
        end
        arrThetaKB=[arrThetaKB;thetaKB];
        thetaKBSVD=structFTData.thetaKBSVD;
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
        omegaNormKB=omegaNorm/abs(cosThetaKB);
        arrOmegaNormKB=[arrOmegaNormKB;omegaNormKB];
        wavenumberNorm=norm(wavenumber*lambda_i);
        arrWavenumberNorm=[arrWavenumberNorm;wavenumberNorm];
        phaseSpeedPRFnorm=abs(valuePhaseSpeedPRF)/structPlasmaParas.va;
        arrPhaseSpeedPRFnorm=[arrPhaseSpeedPRFnorm;phaseSpeedPRFnorm];
        frePRFnorm=abs(fprf)/structPlasmaParas.f_lh;
        arrFrePRFnorm=[arrFrePRFnorm;frePRFnorm];
        %
        separation=structFTData.spacecraftSeparations;
        separation=separation(4);
        arrSeparation=[arrSeparation;separation];
    end
end
%%
figB=figure;
set(figB,'unit','centimeter','position',[0.0,0.0,16,16]);
%set(figB,'position',[0.0,0.0,800*0.6,800*0.6]);
widthSub=0.35;
heightSub=0.35;
%
%%
figFre=subplot(2,2,1);
set(figFre,'position',[0.13 0.62 widthSub heightSub]);
scatter(arrThetaKV,arrFreSC, 'MarkerEdgeColor',colorRed,'MarkerFaceColor',[1 1 1], 'LineWidth',LineWidth);
hold on;
xlim([0,50]);
ylim([-5,5]);
xticks([0,15,30,45])
xticklabels({'0','15','30','45'})
yticks([-4,-2,0,2,4])
yticklabels({'-4','-2','0','2','4'})
xlabel(['$\theta_{kV}$','(deg)'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
ylabel('$f (Hz)$', 'FontSize',wmmFontSize,'Interpreter','latex');%'FontName','Lelvetica');

scatter(arrThetaKV,arrFrePRF, 'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
xline(45,'LineStyle','--');
yline(0,'LineStyle','--');
%text(47,2,'Right-handed in PRF frame','Color','blue','FontSize',wmmFontSize);%,'Interpreter','latex');%,'FontName','Lelvetica');
%text(47,-2,'Left-handed in SC frame','Color','red','FontSize',wmmFontSize);%,'Interpreter','latex');%,'FontName','Lelvetica');
%
box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(a)','fontweight','Bold','fontsize',wmmFontSize-2)
%%
%%
figKB=subplot(2,2,2);
%set(figKB,'position',[0.1 0.13 widthSub heightSub]);
set(figKB,'position',[0.6 0.62 widthSub heightSub]);
scatter(arrThetaKB,arrThetaKBSVD,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
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
x=linspace(0,90,100);
y=x;
plot(x,y,'Color',colorBlue,'LineStyle','--','LineWidth',0.7);
text(60,85,'y=x','Color',colorBlue,'Fontsize',wmmFontSize);

%
box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize-2)
%text(0.85*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize)
%%
figVphFre=subplot(2,2,3);
%set(figDisper,'position',[0.6 0.62 widthSub heightSub]);
set(figVphFre,'position',[0.13 0.13 widthSub heightSub]);
scatter(abs(arrPhaseSpeedPRF),abs(arrFrePRF),'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);

scatter(arrFrePRFnorm,arrPhaseSpeedPRFnorm,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
ylim([0,10]);
xlim([0,2]);
%xlabel(['$V_{ph}^{PRF} (km/s)$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
%ylabel(['$f_{PRF} (Hz)$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');

xlabel(['$$\mathsf{\omega/\omega_{LH}}$$'],'FontSize',18,'Interpreter','latex');
ylabel(['$V_{ph}^{prf}/V_{A}$'],'FontSize',18,'Interpreter','latex');%,'FontName','Lelvetica');


box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(c)','fontweight','Bold','fontsize',wmmFontSize-2)

%%
figDisper=subplot(2,2,4);
%set(figDisper,'position',[0.6 0.62 widthSub heightSub]);
set(figDisper,'position',[0.6 0.13 widthSub heightSub]);
scatter(arrWavenumberNorm,arrOmegaNormKB,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
hold on;
xx=linspace(0,20,100);
yy=xx.^2.*sqrt(1/1836);
plot(xx,yy,'color',colorBlue,'LineStyle','-');

text(4.4,1.3,'*1','color','r')
text(11.8,1.6,'*2','color','r');
%%
% plot(x1,y2,'c-.');
hold off;
%xlabel(['$\omega/\omega_{LH}$'],'FontSize',18,'Interpreter','latex');
ylabel(['$$\mathsf{\omega/\omega_{LH} \cos\theta_{kB}}$$'],'FontSize',wmmFontSize,'Interpreter','latex');
xlabel(['$k\lambda_i$'],'FontSize',wmmFontSize,'Interpreter','latex');%,'FontName','Lelvetica');
textEqu=['$$\mathrm{\frac{\omega_{prf}}{\omega_{lh}\cos\theta_{kB}}=42{k^{2}\lambda_{i}^{2}}}$$'];
text(0.2,2.3,textEqu,'Interpreter','latex','color',colorBlue,'FontSize',10,'FontName','Lelvetica');
%
xlim([0,13]);
ylim([0,3]);
xline(1,'LineStyle','--');

%
box on
set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
    'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
gcaxlim=get(gca,'Xlim');
gcaylim=get(gca,'Ylim');
text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize-2)
%text(0.85*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(b)','fontweight','Bold','fontsize',wmmFontSize)


%%
%%-------------------------------------------------------------------------
% figC=figure;
% set(figC,...%'defaultAxesColorOrder',[left_color; right_color],...
%     'unit','normalized','position',[0.0,0.0,0.1600*6,0.2560*3]);



%%%------------------------------------------------------------------------
%{
figSep=subplot(2,2,4);
set(figSep,'position',[0.6 0.13 widthSub heightSub]);
scatter(arrSeparation,arrLambda,'MarkerEdgeColor',edgeColor,'MarkerFaceColor',faceColor, 'LineWidth',LineWidth);
hold on;
xlim([0,35]);
ylim([0,350]);
s=linspace(0,40,100);
twiceS=2*s;
tenthS=10*s;
plot(s,twiceS,'Color',colorBlue,'LineStyle','--','LineWidth',0.7);
%plot(s,tenthS,'Color','red','LineStyle','--','LineWidth',0.7);
xlabel('Average \Delta (km)','FontSize',wmmFontSize);%,'Interpreter','latex');%,'FontName','Lelvetica');
ylabel('Wavelength (km)','Fontsize',wmmFontSize);%,'Interpreter','latex');%'FontName','Lelvetica');
%text(20,300,'y=10x','Color',colorRed,'Fontsize',wmmFontSize);
text(20,20,'y=2x','Color',colorBlue,'Fontsize',wmmFontSize);
%}
%
% box on
% set(gca,'Fontweight','Bold','Fontsize',wmmFontSize,...
%     'ticklength',[0.02 0.01],'tickdir','in','LineWidth',1.0,'layer','top');
% gcaxlim=get(gca,'Xlim');
% gcaylim=get(gca,'Ylim');
% text(0.02*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)
% %text(0.85*(gcaxlim(2)-gcaxlim(1))+gcaxlim(1),0.95*(gcaylim(2)-gcaylim(1))+gcaylim(1),'(d)','fontweight','Bold','fontsize',wmmFontSize)

print(figB,'figure2','-dpdf','-r0');
print(figB,'figure2','-dpng','-r600');
print(figB,'figure2','-dmeta','-r600');