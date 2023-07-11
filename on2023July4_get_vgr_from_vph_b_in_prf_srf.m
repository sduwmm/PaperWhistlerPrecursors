close all
clear
clc
% % % % !!!!凸多边形的三个顶点

%%
allDatabase=load('AllData-03-Jul-2023.mat');
%%
database=allDatabase.cellAll;
numCase=size(database,1);
%numCase=18
%numCase=9
% numCase=16
%%
for ft=1:numCase
    %ft=17
    yesNo=database{ft,31};
    if yesNo==1
        trangeFT=database{ft,2};
        vphSC=database{ft,36};
        kkk=database{ft,37};
        nnn=database{ft,9};
        upBxyzt=database{ft,46};
        vswSC=database{ft,26};
        shockSpeed=database{ft,7};
        %%
        vphPRF=vphSC-(vswSC(1)*kkk(1)+vswSC(2)*kkk(2)+vswSC(3)*kkk(3));
        
        %%
        ampVph=abs(vphPRF);%%%the value of phase velocity in plasma rest frame
        %ampVph=1;
        dirWavenormal=kkk*(-1);
        upBxyz=upBxyzt(1:3);
        shockSpeed=shockSpeed;
        dirShockNormal=nnn*(-1);
        %%%
        dirStruct=getGroupVelocityOfObliqueWhister(ampVph, dirWavenormal, upBxyz, shockSpeed, dirShockNormal,vswSC,trangeFT);
        % % % add new data to cellAll, then re-store it
        database{ft,47}=dirStruct.thetaKB;
        %
        database{ft,48}=dirStruct.thetaKN;
        database{ft,49}=dirStruct.VphSrf;
        %
        database{ft,50}=dirStruct.GroupVelocityDirection;
        database{ft,51}=dirStruct.GroupVelocityValue;
        database{ft,52}=dirStruct.thetaGN;
        database{ft,53}=dirStruct.VgrSrfOblique;
        database{ft,54}=dirStruct.VgrSrfNoOblique;
        %
        database{31,47}='Wave normal angle';
        database{31,48}='The angle between wave normal and FT shock normal';
        database{31,49}='The relative phase velocity';
        database{31,50}='The direction of group velocity';
        database{31,51}='The value of group velocity in the PRF';
        database{31,52}='The angle between group velocityand FT shock normal';
        database{31,53}='The relative group velocity with wave normal angle';
        database{31,54}='The relative group velocity without wave normal angle';        
    end
end


%%

dateToday=date;
strFig=['AllData-',dateToday];
save([strFig,'.mat'],'database');
%
%load('AllData.mat');

warn = ['Check: Is the field data number of struct equal to cellAll columns'];
error(warn);

% ampVph=1;%%%improve with data
% kkk={[-0.970000000000000,0.0100000000000000,0.210000000000000]};
% nnn={[-0.972845000000000,0.0417690000000000,0.227660000000000]};
% upBxyzt={[3.42631000000000,1.11177000000000,3.06158000000000,5.48170000000000]};
%
%
% dirWavenormal=kkk{1}*(-1);
% upBxyz=upBxyzt{1}(1:3);
% dirShockNormal=nnn{1}*(-1);
%
% dirStruct=getGroupVelocityOfObliqueWhister(ampVph, dirWavenormal, upBxyz, dirShockNormal);

a='test';