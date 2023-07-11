%{
read the upstream condition data for dispersion relation
%}
% %
me=9.10938188*1e-31;
mi=1.672621158*1e-27;
cc=2.99792458*1e8;
% %
clear all;
clc;
% %
%dataPath='C:\Users\20171\OneDrive - mail.sdu.edu.cn\AAA_worklog_2023\allFTDatabasePaper20230512\';
%xlsxName='C:\Users\20171\OneDrive - mail.sdu.edu.cn\AAA_worklog_2023\database\on2023May12_whistler_precursors_FT.xlsx';
%
%dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\';
%xlsxName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\database\on2023June15_whistler_precursors_FT.xlsx';
%
% dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\';
% xlsxName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\database\on2023June19_whistler_precursors_FT.xlsx';
%
dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230626\';
xlsxName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\database\on2023June26_whistler_precursors_FT.xlsx';
%%
if exist(dataPath)==0 %%判断文件夹是否存在
    mkdir(dataPath);  %%不存在时候，创建文件夹
else
    disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
end
%%
cellTrangeList          =readcell(xlsxName,'Sheet','ShockStatistics','Range','A1:A30');
cellTrangeShockList     =readcell(xlsxName,'Sheet','ShockStatistics','Range','B1:B30');
cellFTTypeList          =readcell(xlsxName,'Sheet','ShockStatistics','Range','C1:C30');
%%%parameters for size of FT--->
arrDurationFT           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','D1:D30');
arrVxDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','E1:E30');
arrVyDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','F1:F30');
arrVzDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','G1:G30');
arrVtDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','H1:H30');
%%%parameters for size of FT<---
%%%timing method for shock normal and speed--->
arrSpeedShockSc         =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','J1:J30');
arrErrSpeedShockSc      =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','K1:K30');
arrNxShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','L1:L30');
arrNyShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','M1:M30');
arrNzShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','N1:N30');
arrErrNormalShock       =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','O1:O30');
%%%timing method<---
%%%coplanarity--->
arrNxShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Q1:Q30');
arrNyShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','R1:R30');
arrNzShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','S1:S30');
%%%coplanarity<---
arrDurationShock        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','U1:U30');
arrAmpRamp              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','X1:X30');
%%
arrDensity              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Y1:Y30');
arrErrDensity           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Z1:Z30');
arrTe                   =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AA1:AA30');
arrBetaEle              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AB1:AB30');
%
arrBxUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AC1:AC30');
arrByUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AD1:AD30');
arrBzUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AE1:AE30');
arrBtUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AF1:AF30');

arrThetaBnUpstream      =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AG1:AG30');
arrErrThetaBnUp         =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AH1:AH30');
arrVaUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AI1:AI30');
arrMaUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AJ1:AJ30');
arrErrMaUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AK1:AK30');
arrMaxBramp             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AL1:AL30');
arrBratio               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AM1:AM30');
arrVxUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AN1:AN30');
arrVyUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AO1:AO30');
arrVzUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AP1:AP30');
arrErrVxUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AQ1:AQ30');
arrErrVyUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AR1:AR30');
arrErrVzUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AS1:AS30');
%
%%
arrYesOrNoPrecursor     =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BA1:BA30');
cellPolarization        =readcell(xlsxName,'Sheet','ShockStatistics','Range','BB1:BB30');
arrFrequencyHzSCPeak    =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BC1:BC30');%%%FFT,Hz
arrFrequencyHzSCLow     =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BD1:BD30');%%%FFT,Hz
arrFrequencyHzSCHigh    =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BE1:BE30');%%%FFT,Hz
%
arrVphSCTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BF1:BF30');%%%timing
arrKxDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BG1:BG30');%%%timing
arrKyDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BH1:BH30');%%%timing
arrKzDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BI1:BI30');%%%timing
%%timing analysis information--------------------------------------------->
%%%
%%%
cellTrangeAnalysis      =readcell(xlsxName,'Sheet','ShockStatistics','Range','BK1:BK30');%%%
arrThetaKBTiming        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BO1:BO30');
arrThetaKBSVD           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BP1:BP30');
%%timing analysis information<---------------------------------------------
%
%
arrAmplitude            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BQ1:BQ30');
arrAmpByRamp              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BR1:BR30');
arrAmpByUpBt              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BS1:BS30');
%
arrSepa21               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BT1:BT30');
arrSepa31               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BU1:BU30');
arrSepa41               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BV1:BV30');
arrSepaMean             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BW1:BW30');
%%
cellAll=cell(size(cellTrangeList,1),100);
for ft=1:size(cellTrangeList,1)
    cellTrange=cellTrangeList(ft);
    strTrange=cellTrange{1};
    YYYYMMDDStr=strTrange(10:19);
    StartYYYYMMDDStr=YYYYMMDDStr;
    HHMMSSStr  =strTrange(21:28);
    StartHHMMSSStr=HHMMSSStr;
    YYYYMMDDStr=strTrange(32:41);
    EndYYYYMMDDStr=YYYYMMDDStr;
    HHMMSSStr=strTrange(43:50);
    EndHHMMSSStr=HHMMSSStr;
    trangeStr=[StartYYYYMMDDStr,'T',StartHHMMSSStr,'.000Z/',EndYYYYMMDDStr,'T',EndHHMMSSStr,'.000Z'];
    Tint = irf.tint(trangeStr);
    % %
    unixStart=EpochUnix(Tint);
    epochStart=unixStart.epoch;
    structFTData=struct('t',epochStart(1));
    cellAll{ft,1}=structFTData.t;
    
    %
    cell=cellTrangeList(ft);
    structFTData.trange=cell{1};
    cellAll{ft,2}=structFTData.trange;
    cell=cellTrangeShockList(ft);
    structFTData.trangeFTPrecursor=cell{1};
    cellAll{ft,3}=structFTData.trangeFTPrecursor;
    cell=cellFTTypeList(ft);
    structFTData.FTType=cell{1};
    cellAll{ft,4}=structFTData.FTType;
    structFTData.durationOfFT=arrDurationFT(ft);
    cellAll{ft,5}=structFTData.durationOfFT;
    structFTData.FTDownstreamVelocity=[arrVxDownFT(ft),arrVyDownFT(ft),arrVzDownFT(ft),arrVtDownFT(ft)];
    cellAll{ft,6}=structFTData.FTDownstreamVelocity;
    %
    structFTData.FTShockSpeedScTiming=arrSpeedShockSc(ft);
    cellAll{ft,7}=structFTData.FTShockSpeedScTiming;
    structFTData.FTShockSpeedScUncertain=arrErrSpeedShockSc(ft);
    cellAll{ft,8}=structFTData.FTShockSpeedScUncertain;
    structFTData.FTShockNormalTiming=[arrNxShock(ft),arrNyShock(ft),arrNzShock(ft)];
    cellAll{ft,9}=structFTData.FTShockNormalTiming;
    structFTData.FTShockNomarlUncertain=arrErrNormalShock(ft);
    cellAll{ft,10}=structFTData.FTShockNomarlUncertain;

    %
    structFTData.FTShockNormalCopanarity=[arrNxShockCo(ft),arrNyShockCo(ft),arrNzShockCo(ft)];
    cellAll{ft,11}=structFTData.FTShockNormalCopanarity;
    %
    structFTData.durationOfFTShock=arrDurationShock(ft);
    cellAll{ft,12}=structFTData.durationOfFTShock;
    %
    structFTData.AmpShockRamp=arrAmpRamp(ft);
    cellAll{ft,13}=structFTData.AmpShockRamp;
    
    structFTData.upstreamDensity=arrDensity(ft);
    cellAll{ft,14}=structFTData.upstreamDensity;
    structFTData.upstreamDensityUncertain=arrErrDensity(ft);
    cellAll{ft,15}=structFTData.upstreamDensityUncertain;
    structFTData.TeUp=arrTe(ft);
    cellAll{ft,16}=structFTData.TeUp;
    structFTData.electronBetaUp=arrBetaEle(ft);
    cellAll{ft,17}=structFTData.electronBetaUp;
    structFTData.upstreamB=[arrBxUpstream(ft), arrByUpstream(ft), arrBzUpstream(ft),arrBtUpstream(ft)];
    cellAll{ft,18}=structFTData.upstreamB;
    
    %
    structFTData.FTShockThetaBnUp=arrThetaBnUpstream(ft);
    cellAll{ft,19}=structFTData.FTShockThetaBnUp;
    structFTData.FTShockThetaBnUpUncertain=arrErrThetaBnUp(ft);
    cellAll{ft,20}=structFTData.FTShockThetaBnUpUncertain;
    structFTData.FTShockUpstreamVa=arrVaUpstream(ft);
    cellAll{ft,21}=structFTData.FTShockUpstreamVa;
    structFTData.FTShockUpstreamMa=arrMaUpstream(ft);
    cellAll{ft,22}=structFTData.FTShockUpstreamMa;
    structFTData.FTShockUpstreamMaUncertain=arrErrMaUpstream(ft);
    cellAll{ft,23}=structFTData.FTShockUpstreamMaUncertain;
    %
    structFTData.FTShockRampMaxB=arrMaxBramp(ft);
    cellAll{ft,24}=structFTData.FTShockRampMaxB;
    structFTData.compressRatioB=arrBratio(ft);
    cellAll{ft,25}=structFTData.compressRatioB;

    %
    structFTData.FTShockUpstreamVelocity=[arrVxUpstream(ft),arrVyUpstream(ft),arrVzUpstream(ft)];
    cellAll{ft,26}=structFTData.FTShockUpstreamVelocity;
    structFTData.FTShockUpstreamVelocityUncertain=[arrErrVxUpstream(ft),arrErrVyUpstream(ft),arrErrVzUpstream(ft)];
    cellAll{ft,27}=structFTData.FTShockUpstreamVelocityUncertain;
    %
    %
    structFTData.PrecursorLabel=arrYesOrNoPrecursor(ft);%%1: present; 0: absent
    cellAll{ft,31}=structFTData.PrecursorLabel;
    cell=cellPolarization(ft);
    structFTData.polarizationInSC=cell{1};
    cellAll{ft,32}=structFTData.polarizationInSC;
    structFTData.frequencyHzSCPeak=arrFrequencyHzSCPeak(ft);
    cellAll{ft,33}=structFTData.frequencyHzSCPeak;
    structFTData.frequencyHzSCLow=arrFrequencyHzSCLow(ft);
    cellAll{ft,34}=structFTData.frequencyHzSCLow;
    structFTData.frequencyHzSCHigh=arrFrequencyHzSCHigh(ft);
    cellAll{ft,35}=structFTData.frequencyHzSCHigh;

    %
    structFTData.vphSCTiming=arrVphSCTiming(ft);
    cellAll{ft,36}=structFTData.vphSCTiming;
    structFTData.kDirTiming=[arrKxDirTiming(ft),arrKyDirTiming(ft),arrKzDirTiming(ft)];
    cellAll{ft,37}=structFTData.kDirTiming;
    %
    cell=cellTrangeAnalysis(ft);
    structFTData.trangeAnaTiming=cell{1};
    cellAll{ft,38}=structFTData.trangeAnaTiming;
    structFTData.thetaKBTiming=arrThetaKBTiming(ft);
    cellAll{ft,39}=structFTData.thetaKBTiming;
    structFTData.thetaKBSVD=arrThetaKBSVD(ft);
    cellAll{ft,40}=structFTData.thetaKBSVD;
    %
    structFTData.Amplitude=arrAmplitude(ft);
    cellAll{ft,41}=structFTData.Amplitude;
%     structFTData.AmplitudeByRamp=arrAmpByRamp(ft);
%     cellAll{ft,42}=structFTData.AmplitudeByRamp;
%     structFTData.AmplitudeByUpBt=arrAmpByUpBt(ft);
%     cellAll{ft,43}=structFTData.AmplitudeByUpBt;


    %
    structFTData.spacecraftSeparations=[arrSepa21(ft),arrSepa31(ft),arrSepa41(ft),arrSepaMean(ft)];
    cellAll{ft,44}=structFTData.spacecraftSeparations;

    %
    %
    % %
    strCaseTime=datestr(epochStart(1)/(60*60*24)+datenum('1970-01-01'),'yyyy-mm-dd HH:MM:SS');
    dataName=sprintf('%s\\FT_%s%s%s_%s%s00',...
        dataPath,strCaseTime(1:4),strCaseTime(6:7),strCaseTime(9:10),strCaseTime(12:13),strCaseTime(15:16));%可以修改文件名
    save([dataName,'.mat'],'structFTData');
end
%%
headLine=ft+1;
cellAll{headLine,1}='unixepoch';
cellAll{headLine,2}='trangeForeshockTransient';
cellAll{headLine,3}='trangeFTShock&Upstream';
cellAll{headLine,4}='TypeOfFT';
cellAll{headLine,5}='DurationOfFT';
cellAll{headLine,6}='DownstreamVelocityOfFT';
cellAll{headLine,7}='SpeedByTiming';
cellAll{headLine,8}='SpeedByTimingErr';
cellAll{headLine,9}='NormalByTiming';
cellAll{headLine,10}='NormalByTimingErr';
cellAll{headLine,11}='NormalByCopanarity';
cellAll{headLine,12}='DurationOfFTShock';
cellAll{headLine,13}='AmplitudeOfShockRamp';
%
cellAll{headLine,14}='UpstreamNe';
cellAll{headLine,15}='UpstreamNeErr';
cellAll{headLine,16}='UpstreamTe';
cellAll{headLine,17}='UpstreamBetaElectron';
cellAll{headLine,18}='UpstreamBxyzt';
cellAll{headLine,19}='UpstreamThetaBn';
cellAll{headLine,20}='UpstreamThetaBnErr';
cellAll{headLine,21}='UpstreamVa';
cellAll{headLine,22}='UpstreamMa';
cellAll{headLine,23}='UpstreamMaErr';
cellAll{headLine,24}='RampMaxB';
cellAll{headLine,25}='CompressRatioB';
cellAll{headLine,26}='UpstreamVelocity';
cellAll{headLine,27}='UpstreamVelocityErr';
% %
% %
cellAll{headLine,31}='PrecursorYesOrNo';
cellAll{headLine,32}='PolarizationInSC';
cellAll{headLine,33}='FrequencyHzSCPeak';
cellAll{headLine,34}='FrequencyHzSCLow';
cellAll{headLine,35}='FrequencyHzSCHigh';
cellAll{headLine,36}='PhaseSpeedByTiming';
cellAll{headLine,37}='WaveVectorDirectionByTiming';
cellAll{headLine,38}='DurationAnalyzedByTiming';
cellAll{headLine,39}='WaveNormalAngleByTiming';
cellAll{headLine,40}='WaveNormalAngleBySVD';
cellAll{headLine,41}='Amplitude';
% cellAll{headLine,42}='AmplitudeNormByRamp';
% cellAll{headLine,43}='AmplitudeNormByUpBt';
cellAll{headLine,44}='SeparationsOfSpacecraft';
cellAll{headLine,45}='CaseID';
for no=1:8%%%%%CaseID line
    cellAll{no,45}=no;
end
for yes=9:30
    cellAll{yes,45}=yes-8;
end
%{
cellAll{headLine,45}='trangeLoadDataData';
cellAll{headLine,46}='TintEBSP';
cellAll{headLine,47}='TintShow';
cellAll{headLine,48}='tShock';
cellAll{headLine,49}='TintAll';
cellAll{headLine,50}='TintSW';
cellAll{headLine,51}='TintFT';
cellAll{headLine,52}='TintFS';
cellAll{headLine,53}='caseCutBrst';
cellAll{headLine,54}='cdfFPIFile1';
cellAll{headLine,55}='cdfFPIFile2';
cellAll{headLine,56}='TintInterested';
cellAll{4+8,41}='2017-12-18T12:56:51.000Z/2017-12-18T12:56:52.000Z'
%}

dateToday=date;
strFig=['AllData-',dateToday];
save([strFig,'.mat'],'cellAll');
%
%load('AllData.mat');

warn = ['Check: Is the field data number of struct equal to cellAll columns'];
error(warn);
%%
arrAngle=[];
for ft=9:30
    ft
    b1=cellAll{ft,18}(1:3);
    b2=cellAll{ft,46};
    cosAngle=(b1(1)*b2(1)+b1(2)*b2(2)+b1(3)*b2(3))/(norm(b1)*norm(b2));
    angle=acos(cosAngle)/pi*180;
    arrAngle=[arrAngle;angle];
end