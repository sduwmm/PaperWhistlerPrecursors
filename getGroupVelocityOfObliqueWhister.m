function structOutput=getGroupVelocityOfObliqueWhister(ampVph, dirWavenormal, upBxyz, shockSpeed, dirShockNormal,vswSC,trangeFT)
% % % init
wmmFontSize=16;
colorVphDir=[204 0 0]/256;%colordirWavenormal=[255 0 0]/256;
colorVgr=[255 102 0]/256;
colorBdir=[0 153 0]/256;
colorWavePlane=[255 153 51]/256;
colorShockNormal=[51 51 51]/256;
colorShockPlane=[255 204 0]/256;
colorVsw=[17 17 17]/256;
%%
dirVsw=vswSC/norm(vswSC);

%% get the angle(k,vgr), the angle(b,vgr)
thetaKB=(upBxyz(1)*dirWavenormal(1)+upBxyz(2)*dirWavenormal(2)+upBxyz(3)*dirWavenormal(3))/(sqrt(upBxyz(1)^2+upBxyz(2)^2+upBxyz(3)^2)*sqrt(dirWavenormal(1)^2+dirWavenormal(2)^2+dirWavenormal(3)^2));
thetaKB=acos(thetaKB)/pi*180;
%%
twoAmpVph=2*ampVph;
if thetaKB < 90
    n=1;
elseif thetaKB >90
    n=-1;
end
%
switch n
    case 1
        disp('Wave normal angle is smaller than 90 degree')
        %
        tanThetaKB=tan(thetaKB/180*pi);
        auxAngle=atan(tanThetaKB/2)/pi*180;
        %
        thetaVgrB=thetaKB-auxAngle;
        ampB=sqrt(upBxyz(1)^2+upBxyz(2)^2+upBxyz(3)^2);
        ampVgrA=twoAmpVph/cos(auxAngle/180*pi);
        ampVgr=sqrt(twoAmpVph^2+(ampVph*tanThetaKB)^2);
    case -1
        disp('Wave normal angle is larger than 90 degree')
        tanSupAngleOfThetaKB=tan((180-thetaKB)/180*pi);
        auxAngle=atan(tanSupAngleOfThetaKB/2)/pi*180;
        thetaVgrBAnti=(180-thetaKB)-auxAngle;
        ampVgr=sqrt(twoAmpVph^2+(ampVph*tanSupAngleOfThetaKB)^2);
        %
        thetaVgrB=thetaKB+auxAngle;
end
%{
%
tanThetaKB=tan(thetaKB/180*pi);
auxAngle=atan(tanThetaKB/2)/pi*180;
%
thetaVgrB=thetaKB-auxAngle;
ampVgr=sqrt(twoAmpVph^2+(ampVph*tanThetaKB)^2);
%}
%%
figDirs=figure;
set(figDirs,'PaperUnits','centimeters')
set(figDirs,'paperpositionmode','auto') % to get the same printing as on screen
set(gcf,'PaperUnits','centimeters')
xSize = 20; ySize = xSize;
xSize = 36; ySize =xSize/2;
xLeft = (21-xSize)/2; yTop = (30-ySize)/2;
set(figDirs,'PaperPosition',[xLeft yTop xSize ySize])
set(figDirs,'Position',[18 18 xSize*50 ySize*50])
set(figDirs,'paperpositionmode','auto') % to get the same printing as on screen
clear xLeft xSize sLeft ySize yTop
%%
axPolar=polaraxes;
axPolar.Position=[0.05 0.2 0.3 0.6];
hold on
axPolar.ThetaDir='counterclockwise';
axPolarFontSize=wmmFontSize;
%
axPolarBdir=polarplot(axPolar,[0,0],[0,1]);
axPolarBdir.LineWidth=3;
axPolarBdir.Color=colorBdir;
% % % normalized the vph and vgr by vph
ampVphPlot=ampVph/ampVph;
twoAmpVphPlot=twoAmpVph/ampVph;
ampVgrPlot=ampVgr/ampVph;
%
axPolarVph=polarplot(axPolar,[0,thetaKB/180*pi],[0,ampVphPlot]);
axPolarVph.LineWidth=3;
axPolarVph.Color=colorVphDir;
%
axPolar2Vph=polarplot(axPolar,[0,thetaKB/180*pi],[0,twoAmpVphPlot]);
axPolar2Vph.LineWidth=1;
axPolar2Vph.Color=colorVphDir;
axPolar2Vph.LineStyle=':';
%
%%
axPolarVgr=polarplot(axPolar,[0,thetaVgrB/180*pi],[0,ampVgrPlot]);
axPolarVgr.Color=colorVgr;
axPolarVgr.LineWidth=2;
%% to view the polar axes
axPolar.RLim=[0,3];
axPolar.ThetaLim=[0,180];
%
%
axRPositive=polarplot(axPolar,[thetaKB/180*pi,thetaKB/180*pi],[2,3]);
axRPositive.Color=[1 0 0];
axRPositive.LineWidth=1.5;
axRPositive.LineStyle='--';
%
resAngle=90-thetaKB;
r00=2*ampVphPlot/cos(thetaKB/180*pi);
r90=2*ampVphPlot/cos(resAngle/180*pi);
axTanThetaNegative=polarplot(axPolar,[thetaKB/180*pi,0],[2, r00]);
axTanThetaPositive=polarplot(axPolar,[thetaKB/180*pi,1/2*pi],[2, r90]);
%
%
axTanThetaPositive.Color=[0 0 0];
axTanThetaPositive.LineWidth=1.5;
axTanThetaPositive.LineStyle='-.';
axTanThetaNegative.Color=[0 0 0];
axTanThetaNegative.LineWidth=1;
axTanThetaNegative.LineStyle=':';
%
lgdPolar=legend('Magnetic Field Direction','Phase Velocity','Vph Direction',...
    'Group Velocity','+e_{k}','- e_{\theta}','+ e_{\theta}','\theta');
% % %gamma: the angle between group velocity and phase velocity
%axPolar=gca;]
strTtl={'Olique whistler waves',['\theta_{kB}=',num2str(thetaKB,'%.0f'),'\circ'],'|V_{ph}^{prf}|=1'};
ttl=title(strTtl);
ttl.FontSize=20;
thetaticks(0:15:345)
rticks([1 2 3 ])
rticklabels({'|Vph|','2|Vph|','3|Vph|'});

axPolar.GridColor='red';
%%
ax3D=axes('position',[0.55  0.1 0.45 0.9]);
%
%axDirSW=quiver3(ax3D,0,0,0,dirVsw(1),dirVsw(2),dirVsw(3));
axDirSW=quiver3(ax3D,0,0,0,dirVsw(1),dirVsw(2),dirVsw(3));
hold on
axDirSW.Color=colorVsw;
axDirSW.LineWidth=2;
axDirSW.LineStyle='-.';
%
axDirSW2=quiver3(ax3D,0,0,0,(-1)*dirVsw(1),(-1)*dirVsw(2),(-1)*dirVsw(3));
axDirSW2.Color=colorVsw;
axDirSW2.LineWidth=1;
axDirSW2.LineStyle='-.';
%
%
axX=quiver3(ax3D,-1,0,0,2,0,0,'LineWidth',1.5,'Color','b');%x-axis
axY=quiver3(ax3D,0,-1,0,0,2,0,'LineWidth',1.5,'Color','c');%y-axis
axZ=quiver3(ax3D,0,0,-1,0,0,2,'LineWidth',1.5,'Color','m');%z-axis
axOGSE=plot3([0,0],[0,0],[0,0],'+','Color','k');%o-GSE
grid on
axis equal
%
xlabel('X-GSE')
ylabel('Y-GSE')
zlabel('Z-GSE')
%
xlim([-1,1])
ylim([-1,1])
zlim([-1,1])
%
ax3D.XRuler.FirstCrossoverValue  = 0; % X crossover with Y axis
ax3D.XRuler.SecondCrossoverValue  = 0; % X crossover with Z axis
ax3D.YRuler.FirstCrossoverValue  = 0; % Y crossover with X axis
ax3D.YRuler.SecondCrossoverValue  = 0; % Y crossover with Z axis
ax3D.ZRuler.FirstCrossoverValue  = 0; % Z crossover with X axis
ax3D.ZRuler.SecondCrossoverValue = 0; % Z crossover with Y axis
%ax3D.XRuler.LineWidth= 1;
%ax3D.YRuler.LineWidth= 2;
%ax3D.XRuler.LineWidth= 3;
%
%

% % %----------------------------------------------------------------------
dirBx=upBxyz(1)/norm(upBxyz(1:3));
dirBy=upBxyz(2)/norm(upBxyz(1:3));
dirBz=upBxyz(3)/norm(upBxyz(1:3));
%
axMagneticField=quiver3(ax3D,0,0,0,dirBx,dirBy,dirBz);
axMagneticField.Color=colorBdir;
axMagneticField.LineWidth=2;
%
axDirWavenormal=quiver3(ax3D,0,0,0,dirWavenormal(1),dirWavenormal(2),dirWavenormal(3));
axDirWavenormal.Color=colorVphDir;
axDirWavenormal.LineWidth=2;
%
% to get the direction of group velocity
% to get the wave propagation plane
% % % % !!!!凸多边形的三个顶点
xxx1=0;
yyy1=0;
zzz1=0;
%
xxx2=dirBx;
yyy2=dirBy;
zzz2=dirBz;
dirBxyz=[dirBx,dirBy,dirBz];
%
xxx3=dirWavenormal(1);
yyy3=dirWavenormal(2);
zzz3=dirWavenormal(3);
%
AAA=1*(yyy2*zzz3-zzz2*yyy3)   -yyy1*(1*zzz3-zzz2*1)      +zzz1*(1*yyy3-yyy2*1);
BBB=xxx1*(1*zzz3-zzz2*1)      -1*(xxx2*zzz3-zzz2*xxx3)   +zzz1*(xxx2*1-1*xxx3);
CCC=xxx1*(yyy2*1-1*yyy3)      -yyy1*(xxx2*1-1*xxx3)      +1*(xxx2*yyy3-yyy2*xxx3);
DDD=xxx1*(yyy2*zzz3-zzz2*yyy3)-yyy1*(xxx2*zzz3-zzz2*xxx3)+zzz1*(xxx2*yyy3-yyy2*xxx3);
DDD=(-1)*DDD;
%
xxx=[-1:0.01:1];
yyy=[-1:0.01:1];
[X3,Y3]=meshgrid(xxx,yyy);
color3=ones(size(X3));
Z3=(0-AAA*X3-BBB*Y3-DDD)/CCC;
axWavePlane=surf(ax3D,X3,Y3,Z3,color3);
shading(ax3D, 'flat')
alpha 0.5
axWavePlane.FaceColor=colorWavePlane;
%mesh(X3,Y3,Z3)
%
ttt=cross(dirBxyz,dirWavenormal);
dirT3=ttt/norm(ttt);
%
%quiver3(ax3D,0,0,0,1,1,1)
%
% % %Solve systems of linear equations Ax = B for x
% % % A Vgr=B for Vgr
matriceA=[dirWavenormal;dirBxyz;dirT3];
matriceB=[cos(auxAngle/180*pi);cos(thetaVgrB/180*pi);0];
dirVgr=matriceA\matriceB;
%
axVgr=quiver3(ax3D,0,0,0,dirVgr(1),dirVgr(2),dirVgr(3));
axVgr.Color=colorVgr;
axVgr.LineWidth=2;
angleVgrToB=acos(dirVgr(1)*dirBxyz(1)+dirVgr(2)*dirBxyz(2)+dirVgr(3)*dirBxyz(3))/pi*180;
%
% % % to determine the FT shock plane
dirNx=dirShockNormal(1);
dirNy=dirShockNormal(2);
dirNz=dirShockNormal(3);
axShockNormal=quiver3(ax3D,0,0,0,dirNx, dirNy, dirNz);
axShockNormal.Color=colorShockNormal;
axShockNormal.LineWidth=2;
%
coefX=dirNx;
coefY=dirNy;
coefZ=dirNz;
%
%clear xxx yyy X3 Y3 color3 Z3
xxx=[-1:0.01:1];
yyy=[-1:0.01:1];
[X3Scnd,Y3Scnd]=meshgrid(xxx,yyy);
color3Scnd=ones(size(X3Scnd));
Z3Scnd=(-1)*(coefX*X3Scnd+coefY*Y3Scnd)/coefZ;
axShockPlane=surf(ax3D,X3Scnd,Y3Scnd,Z3Scnd,color3Scnd);
shading(ax3D, 'flat')
alpha 0.5
axShockPlane.FaceColor=colorShockPlane;
%

%
title(ax3D,'The relationship ...');
ldg3D=legend('Solar Wind Velocity',...
    'Line of SW',...
    'X-GSE','Y-GSE','Z-GSE',...
    'O-GSE',...
    'Magnetic Field Direction',...
    'Phase Velocity',...
    'Propagation Plane',...
    'Group Velocity',...
    'FT Shock Normal',...
    'FT Shock Plane');
ldg3D.Position=[0.4,0.20,0.15, 0.4];
ldg3D.FontSize=wmmFontSize;
lgdPolar.Position=[0.4,0.66,0.15,0.2];
lgdPolar.FontSize=wmmFontSize;
%%
cosThetaGN=(dirVgr(1)*dirShockNormal(1)+dirVgr(2)*dirShockNormal(2)+dirVgr(3)*dirShockNormal(3))/(norm(dirVgr)*norm(dirShockNormal));
thetaGN=acos(cosThetaGN)/pi*180;
%
cosThetaKN=(dirWavenormal(1)*dirShockNormal(1)+dirWavenormal(2)*dirShockNormal(2)+dirWavenormal(3)*dirShockNormal(3))/(norm(dirVgr)*norm(dirShockNormal));
thetaKN=acos(cosThetaKN)/pi*180;
%%
%{
both variable part1 and variable part 2 should be larger than zero.
We want to know who is larger, the group velocity or the solar wind
velocity.
%}
% % % the last part
dirShockNormalUp=dirShockNormal;
dirShockNormalDown=dirShockNormal*(-1);
vsw_srf=vswSC-shockSpeed*dirShockNormalDown;
part1=ampVgr*(dirVgr(1)*dirShockNormalUp(1)+dirVgr(2)*dirShockNormalUp(2)+dirVgr(3)*dirShockNormalUp(3));
part2=(vsw_srf(1)*dirShockNormalDown(1)+ vsw_srf(2)*dirShockNormalDown(2)+vsw_srf(2)*dirShockNormalDown(3));
deltaV1=part1-part2;
% % % regardless of the wave normal angle
deltaV1NoTheta=2*abs(ampVph)*cosThetaKN-part2;
% % % the relative motion of phase velocity
vShPrf=shockSpeed-(dirShockNormalDown(1)*vswSC(1)+dirShockNormalDown(2)*vswSC(2)+dirShockNormalDown(3)*vswSC(3));
deltaV2=abs(ampVph)*cosThetaKN-abs(vShPrf);
%%
structDir=struct('Name', 'different direction');
structDir.GroupVelocityDirection=dirVgr;
structDir.GroupVelocityValue=ampVgr;
structDir.thetaGN=thetaGN;
structDir.cosThetaGN=cosThetaGN;
structDir.VgrSrfOblique=deltaV1;
structDir.VgrSrfNoOblique=deltaV1NoTheta;
structDir.thetaVgrToB=angleVgrToB;
% % %phase velocity
structDir.thetaKN=thetaKN;
structDir.VphSrf=deltaV2;
structDir.thetaKB=thetaKB;

%
structOutput=structDir;
%%
%delete(axText)
axText=axes('position',[0.03 0.05 0.35 0.25]);
%axis equal
xlim([0,35]);
ylim([0.,25]);
xticks([])
yticks([])
xticklabels({})
yticklabels({})
box on;
text(1,22,trangeFT);
text(20,22,'\theta_{Bn}=');
text(25,22,'M_{A}=');
text(1,17, ['V_{sw}^{sc}=','(',num2str(vswSC(1),'%.0f'),', ',num2str(vswSC(2),'%.0f'),', ',num2str(vswSC(3),'%.0f'),')',' km/s'])
text(20,17, ['V_{sw}^{srf}=','(',num2str(vsw_srf(1),'%.0f'),', ',num2str(vsw_srf(2),'%.0f'),', ',num2str(vsw_srf(3),'%.0f'),')',' km/s'])
%
text(20,12,['V_{ph}^{prf}=',num2str(ampVph,'%.0f'), '* ','(',num2str(dirWavenormal(1),'%.1f'),', ',num2str(dirWavenormal(2),'%.1f'),', ',num2str(dirWavenormal(3),'%.0f'),')',  ' km/s '])
text(1,12,['V_{gr}^{prf}=', num2str(ampVgr,'%.0f'),'*','(',num2str(dirVgr(1),'%.1f'),', ',num2str(dirVgr(2),'%.1f'),', ',num2str(dirVgr(3),'%.0f'),')',  'km/s '])
text(20,7,['\theta_{k,n}=',num2str(thetaKN,'%.0f'),'\circ'])
text(1,7,['\theta_{vgr,n}=',num2str(thetaGN,'%.0f'),'\circ'])
text(1,2,['\Delta V_{1, considering \theta_{kB} }=', num2str(deltaV1,'%.0f'),'km/s'])
text(15,2,['\Delta V_{1, no \theta_{kB}}=', num2str(deltaV1NoTheta,'%.0f'),'km/s'])
text(25,2,['\Delta V_{2}=', num2str(deltaV2,'%.0f'),'km/s'])

%
a='test'
%%
return
end