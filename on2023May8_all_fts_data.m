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
%dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230615\';
dataPath='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\allFTDatabasePaper20230619\';
if exist(dataPath)==0 %%判断文件夹是否存在
    mkdir(dataPath);  %%不存在时候，创建文件夹
else
    disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
end

%xlsxName='C:\Users\20171\OneDrive - mail.sdu.edu.cn\AAA_worklog_2023\database\on2023May12_whistler_precursors_FT.xlsx';
%xlsxName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\database\on2023June15_whistler_precursors_FT.xlsx';
xlsxName='D:\OneDrive - mail.sdu.edu.cn\PaperWhistlerPrecursors\database\on2023June19_whistler_precursors_FT.xlsx';
cellTrangeList          =readcell(xlsxName,'Sheet','ShockStatistics','Range','E6:E35');
cellTrangeShockList     =readcell(xlsxName,'Sheet','ShockStatistics','Range','F6:F35');
cellFTTypeList          =readcell(xlsxName,'Sheet','ShockStatistics','Range','CM6:CM35');
arrYesOrNoPrecursor     =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AB6:AB35');
%%add on 2023-04-12------------------------------------------------------->
cellPolarization        =readcell(xlsxName,'Sheet','ShockStatistics','Range','AC6:AC35');
arrFrequencyHzSCPeak    =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AD6:AD35');%%%FFT,Hz
arrFrequencyHzSCLow     =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AE6:AE35');%%%FFT,Hz
arrFrequencyHzSCHigh    =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AF6:AF35');%%%FFT,Hz
%
arrVphSCTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AG6:AG35');%%%timing
arrKxDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AH6:AH35');%%%timing
arrKyDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AI6:AI35');%%%timing
arrKzDirTiming          =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AJ6:AJ35');%%%timing
%%timing analysis information--------------------------------------------->
%%%
%%%
cellTrangeAnalysis      =readcell(xlsxName,'Sheet','ShockStatistics','Range','AP6:AP35');%%%
arrCorrMMS12            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AU6:AU35');%%%coherence of pair of spacecraft
arrCorrMMS13            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AV6:AV35');%%%coherence of pair of spacecraft
arrCorrMMS14            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AW6:AW35');%%%coherence of pair of spacecraft
arrKxMVA                =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AX6:AX35');
arrKyMVA                =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AY6:AY35');
arrKzMVA                =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AZ6:AZ35');
arrDiffTimingMVA        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BA6:BA35');
arrMaxEigValueMVA       =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BB6:BB35');
arrIntermEigValueMVA    =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BC6:BC35');
arrMinEigValueMVA       =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BD6:BD35');
arrRatioInterOverMinMVA =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BE6:BE35');
arrThetaKBSVD           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BF6:BF35');
%%timing analysis information<---------------------------------------------
%%add on 2023-04-12<-------------------------------------------------------
%%
arrDensity              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','G6:G35');
arrErrDensity           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','H6:H35');
arrTe                   =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','I6:I35');
arrBetaEle              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','J6:J35');
%
arrBxUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','K6:K35');
arrByUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','L6:L35');
arrBzUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','M6:M35');
arrBtUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','N6:N35');
%
arrThetaBnUpstream      =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','O6:O35');
arrErrThetaBnUp         =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','P6:P35');
arrVaUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Q6:Q35');
arrMaUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','R6:R35');
arrErrMaUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','S6:S35');
arrMaxBramp             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','T6:T35');
arrBratio               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','U6:U35');
arrVxUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','V6:V35');
arrVyUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','W6:W35');
arrVzUpstream           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','X6:X35');
arrErrVxUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Y6:Y35');
arrErrVyUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','Z6:Z35');
arrErrVzUpstream        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AA6:AA35');
%
arrSepa21               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AK6:AK35');
arrSepa31               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AL6:AL35');
arrSepa41               =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AM6:AM35');
arrSepaMean             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','AN6:AN35');
%%%timing method for shock normal and speed--->
arrSpeedShockSc         =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BK6:BK35');
arrErrSpeedShockSc      =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BL6:BL35');
arrNxShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BM6:BM35');
arrNyShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BN6:BN35');
arrNzShock              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BO6:BO35');
arrErrNormalShock       =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BP6:BP35');
%%%timing method<---
arrSpeedShockSw         =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BQ6:BQ35');
arrErrSpeedShockSw      =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BR6:BR35');
%%%mva for shock analysis--->
%
arrDurationShock        =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CN6:CN35');
%
arrAmpWave              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','BZ6:BZ35');
arrAmpRamp              =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CA6:CA35');
%%%coplanarity--->
arrNxShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CE6:CE35');
arrNyShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CF6:CF35');
arrNzShockCo            =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CG6:CG35');
%%%coplanarity<---
%%%parameters for size of FT--->
arrDurationFT           =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CN6:CN35');
arrVxDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CO6:CO35');
arrVyDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CP6:CP35');
arrVzDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CQ6:CQ35');
arrVtDownFT             =readmatrix(xlsxName,'Sheet','ShockStatistics','Range','CR6:CR35');
%%%parameters for size of FT<---
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
    %
    cell=cellTrangeList(ft);
    structFTData.trange=cell{1};
    cell=cellTrangeShockList(ft);
    structFTData.trangeFTPrecursor=cell{1};
    cell=cellFTTypeList(ft);
    structFTData.FTType=cell{1};
    structFTData.PrecursorLabel=arrYesOrNoPrecursor(ft);%%1: present; 0: absent
    %
    %%%added on 2023-04-12------------------------------------------------>
    cell=cellPolarization(ft);
    structFTData.polarizationInSC=cell{1};
    structFTData.frequencyHzSCPeak=arrFrequencyHzSCPeak(ft);
    structFTData.frequencyHzSCLow=arrFrequencyHzSCLow(ft);
    structFTData.frequencyHzSCHigh=arrFrequencyHzSCHigh(ft);
    %
    structFTData.vphSCTiming=arrVphSCTiming(ft);
    structFTData.kDirTiming=[arrKxDirTiming(ft),arrKyDirTiming(ft),arrKzDirTiming(ft)];
    %
    cell=cellTrangeAnalysis(ft);
    structFTData.trangeAnaTiming=cell{1};
    structFTData.coherence12=arrCorrMMS12(ft);
    structFTData.coherence13=arrCorrMMS13(ft);
    structFTData.coherence14=arrCorrMMS14(ft);
    structFTData.kDirMVA=[arrKxMVA(ft),arrKyMVA(ft),arrKzMVA(ft)];
    structFTData.diffAngleTimingMVA=arrDiffTimingMVA(ft);
    structFTData.eigValuesMVA=[arrMaxEigValueMVA(ft),arrIntermEigValueMVA(ft),arrMinEigValueMVA(ft),arrRatioInterOverMinMVA(ft)];
    structFTData.thetaKBSVD=arrThetaKBSVD(ft);
    %%%added on 2023-04-12<------------------------------------------------

    
    structFTData.TeUp=arrTe(ft);
    structFTData.electronBetaUp=arrBetaEle(ft);
    structFTData.upstreamB=[arrBxUpstream(ft), arrByUpstream(ft), arrBzUpstream(ft),arrBtUpstream(ft)];
    structFTData.upstreamDensity=arrDensity(ft);
    structFTData.upstreamDensityUncertain=arrErrDensity(ft);
    %
    structFTData.FTShockNormalTiming=[arrNxShock(ft),arrNyShock(ft),arrNzShock(ft)];
    structFTData.FTShockNomarlUncertain=arrErrNormalShock(ft);
    structFTData.FTShockSpeedScTiming=arrSpeedShockSc(ft);
    structFTData.FTShockSpeedScUncertain=arrErrSpeedShockSc(ft);
    structFTData.FTShockSpeedSwTiming=arrSpeedShockSw(ft);
    structFTData.FTShockSpeedSwUncertain=arrErrSpeedShockSw(ft);
    structFTData.FTShockNormalCopanarity=[arrNxShockCo(ft),arrNyShockCo(ft),arrNzShockCo(ft)];
    structFTData.FTShockThetaBnUp=arrThetaBnUpstream(ft);
    structFTData.FTShockThetaBnUpUncertain=arrErrThetaBnUp(ft);
    structFTData.FTShockVelocityUpstream=[arrVxUpstream(ft),arrVyUpstream(ft),arrVzUpstream(ft)];
    structFTData.FTShockVelocityUpstreamUncertain=[arrErrVxUpstream(ft),arrErrVyUpstream(ft),arrErrVzUpstream(ft)];
    structFTData.FTShockMaUpstream=arrMaUpstream(ft);
    structFTData.FTShockMaUpstreamUncertain=arrErrMaUpstream(ft);
    structFTData.FTShockVaUpstream=arrVaUpstream(ft);
    structFTData.FTShockRampMaxB=arrMaxBramp(ft);
    structFTData.FTShockRampAmplitude=arrAmpRamp(ft);
    structFTData.PrecursorsAmplitude=arrAmpWave(ft);
    structFTData.compressRatioB=arrBratio(ft);
    structFTData.durationOfFTShock=arrDurationShock(ft);
    %
    structFTData.spacecraftSeparations=[arrSepa21(ft),arrSepa31(ft),arrSepa41(ft),arrSepaMean(ft)];
    %
    structFTData.durationOfFT=arrDurationFT(ft);
    structFTData.FTDownstreamVelocity=[arrVxDownFT(ft),arrVyDownFT(ft),arrVzDownFT(ft),arrVtDownFT(ft)];
    %
    % %
    strCaseTime=datestr(epochStart(1)/(60*60*24)+datenum('1970-01-01'),'yyyy-mm-dd HH:MM:SS');
    dataName=sprintf('%s\\FT_%s%s%s_%s%s00',...
        dataPath,strCaseTime(1:4),strCaseTime(6:7),strCaseTime(9:10),strCaseTime(12:13),strCaseTime(15:16));%可以修改文件名
    save([dataName,'.mat'],'structFTData');
end
