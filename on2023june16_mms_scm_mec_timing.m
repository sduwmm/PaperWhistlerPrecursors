%{
filter can be different for different case.
%--------------------------------------------------------------------------
If error message 'Time-series data have different length! Modify indexSliceM%dSameAsM1'
shows, which means that the index of data of MMSX is not equal to MMS1,
choose to delete or keep the first line to make length of MMSX data same with MMS1.
indexSliceMscSameAsM1(1)=[];
%--------------------------------------------------------------------------
Check: Is timeLag smaller than dataPointAhead?
Check: Is timeLag same with case in figure?
Check: Which component (xyz) are selected to analysis?
DataPointAhead need to be longer than the estimated time lag.
DataPointLagMax need to be twice longer than the estimated time lag.
dataPointAhead  = 2000;%%%time search start before the start of M1, in 1/8192 second
dataPointAhead is maxium timeLag in data point number, and dataPointLagMax
should be twice of dataPointAhead.
dataPointLagMax = 4000;%%%maxium timeLag in data point number, in 1/8192 second
%}
%{
Wang+2022
First, we perform the correlation analysis of the magnetic field using
measurements from four spacecraft, where the average spacecraft separation
is 22 km. The band‐pass fields at 0.1–0.3 Hz are used. A time delay is
obtained from the correlation analysis for each of MMS2, MMS3, and MMS4
with MMS1. Together with the positions of the four spacecraft, the amplitude
and direction of the wave propagation could be obtained from the
four‐spacecraft timing method (Schwartz, 1998).
bandpass------
%}
%{
Wilson+2009, 2012
Therefore, we applied multiple standard Fourier bandpass filters to each
waveform prior to using MVA on specific subintervals requiring that the ratio
of the intermediate-to-minimum eigenvalues be >10 to use a result.
The results are consistent with IDL pro.--wmm
%}
%{
Hull et al. 2020
10Hz pass-filtered components
x-components in GSE
t12=-1.83ms
t13=-15.0ms
t14=14.4ms
k_cross_correlation=[0.730, 0.024, 0.683] in GSE coordinates
vph_sc=447 km/s
k_mva=[0.720, 0.043, 0.693]

Results from this script
filter      = [8.5,11.5];
x-components in GSE
t21=3.8ms
t31=14.5ms
t41=-13.3ms
v_ph_sc=474.255301km/s in GSE coordinates
k_cross_correlation=[0.708620, 0.084084, 0.700562], 3.8061 degree from
Hull's result
k_mva=[0.718,0.0403,0.695],  acos(1.0003)*180/pi degree from Hull's result
%}
%component       = 1;%1:x;2:y;3:z
clear all;
%%%%Tint时间范围要长一些




%%case#1-------------------------------------------------------------------------
Tint=irf.tint('2017-12-01T14:40:30.000Z/2017-12-01T14:41:30.000Z');
TintFig=irf.tint('2017-12-01T14:40:58.00Z/2017-12-01T14:41:04.000Z');
TintInterested=irf.tint('2017-12-01T14:41:00.800Z/2017-12-01T14:41:01.800Z');
TintInterested=irf.tint('2017-12-01T14:41:00.100Z/2017-12-01T14:41:03.000Z');
filter = [1.5,2.5];
filter = [0.5,6];
%filter = [1,2];
dataPointAhead=2000;
dataPointLagMax=4000;
component       = 2;%1:x;2:y;3:z
%%case#2-------------------------------------------------------------------
Tint=irf.tint('2017-12-17T17:53:10.000Z/2017-12-17T17:53:30.000Z');
TintFig=irf.tint('2017-12-17T17:53:15.000Z/2017-12-17T17:53:25.000Z');
TintInterested=irf.tint('2017-12-17T17:53:19.500Z/2017-12-17T17:53:21.000Z');
filter=[0.5,3];
filter = [0.5,6];
dataPointAhead=3000;
dataPointLagMax=2*dataPointAhead;
component       = 2;%1:x;2:y;3:z
%%%case#3------------------------------------------------------------------
Tint=irf.tint('2017-12-18T12:56:40.000Z/2017-12-18T12:57:00.000Z');
TintFig=irf.tint('2017-12-18T12:56:45.000Z/2017-12-18T12:56:55.000Z');
TintInterested=irf.tint('2017-12-18T12:56:51.000Z/2017-12-18T12:56:52.000Z');
filter=[0.5,3];
filter = [0.5,6];
dataPointAhead=3000;
dataPointLagMax=2*dataPointAhead;
component       = 2;%1:x;2:y;3:z
%%%case#4------------------------------------------------------------------
Tint=irf.tint('2017-12-29T19:10:20.000Z/2017-12-29T19:12:00.000Z');
TintFig=irf.tint('2017-12-29T19:11:30.000Z/2017-12-29T19:11:45.000Z');
TintInterested=irf.tint('2017-12-29T19:11:36.000Z/2017-12-29T19:11:37.000Z');
filter=[0.5,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%case#5------------------------------------------------------------------
% Tint=irf.tint('2018-01-09T08:34:23.000Z/2018-01-09T08:35:03.000Z');
% TintFig=irf.tint('2018-01-09T08:34:50.000Z/2018-01-09T08:35:00.000Z');
% TintInterested=irf.tint('2018-01-09T08:34:51.800Z/2018-01-09T08:34:52.800Z');
% filter=[0.5,4];
% filter=[0.5,6];
% dataPointAhead=2000;
% dataPointLagMax=2*dataPointAhead;
% component=2;
%%%%case#6------------------------------------------------------------------
Tint=irf.tint('2018-02-04T10:37:20.000Z/2018-02-04T10:38:53.000Z');
TintFig=irf.tint('2018-02-04T10:38:10.000Z/2018-02-04T10:38:20.000Z');
TintInterested=irf.tint('2018-02-04T10:38:13.000Z/2018-02-04T10:38:15.000Z');
filter=[0.5,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#7------------------------------------------------------------------
Tint=irf.tint('2018-02-21T11:34:23.000Z/2018-02-21T11:37:23.000Z');
TintFig=irf.tint('2018-02-21T11:36:44.000Z/2018-02-21T11:36:47.000Z');
TintInterested=irf.tint('2018-02-21T11:36:44.000Z/2018-02-21T11:36:47.000Z');
TintInterested=irf.tint('2018-02-21T11:36:47.000Z/2018-02-21T11:36:50.000Z');
filter=[0.5,2];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#8------------------------------------------------------------------
Tint=irf.tint('2018-12-10T04:19:15.000Z/2018-12-10T04:20:53.000Z');
TintFig=irf.tint('2018-12-10T04:20:00.000Z/2018-12-10T04:20:06.000Z');
TintInterested=irf.tint('2018-12-10T04:20:02.000Z/2018-12-10T04:20:03.000Z');
TintInterested=irf.tint('2018-12-10T04:20:04.000Z/2018-12-10T04:20:05.000Z');
TintInterested=irf.tint('2018-12-10T04:20:03.000Z/2018-12-10T04:20:05.000Z');
filter=[2,6];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
% %%%%%case#9------------------------------------------------------------------
Tint=irf.tint('2018-12-10T04:40:23.000Z/2018-12-10T04:42:13.000Z');
TintFig=irf.tint('2018-12-10T04:41:45.000Z/2018-12-10T04:41:55.000Z');
TintInterested=irf.tint('2018-12-10T04:41:49.500Z/2018-12-10T04:41:50.000Z');
TintInterested=irf.tint('2018-12-10T04:41:50.000Z/2018-12-10T04:41:51.000Z');
filter=[1,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#10------------------------------------------------------------------
Tint=irf.tint('2018-12-10T05:49:44.000Z/2018-12-10T05:52:03.000Z');
TintFig=irf.tint('2018-12-10T05:49:45.000Z/2018-12-10T05:50:00.000Z');
TintInterested=irf.tint('2018-12-10T05:49:55.000Z/2018-12-10T05:49:56.000Z');
TintInterested=irf.tint('2018-12-10T05:49:56.000Z/2018-12-10T05:49:57.000Z');
filter=[0.5,6];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#11------------------------------------------------------------------
Tint=irf.tint('2018-12-10T06:28:53.500Z/2018-12-10T06:30:53.000Z');
TintFig=irf.tint('2018-12-10T06:28:55.000Z/2018-12-10T06:29:00.000Z');
TintInterested=irf.tint('2018-12-10T06:28:57.000Z/2018-12-10T06:28:58.300Z');
%filter=[2,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%Case#12--------------------------------------------------------------------
Tint=irf.tint('2019-01-18T21:03:50.000Z/2019-01-18T21:04:13.000Z');
TintFig=irf.tint('2019-01-18T21:03:50.000Z/2019-01-18T21:04:13.000Z');
TintInterested=irf.tint('2019-01-18T21:04:04.000Z/2019-01-18T21:04:07.000Z');
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#13------------------------------------------------------------------!!!!!!!!!
Tint=irf.tint('2019-12-06T05:13:00.000Z/2019-12-06T05:15:00.000Z');
TintFig=irf.tint('2019-12-06T05:13:55.000Z/2019-12-06T05:14:02.000Z');
TintInterested=irf.tint('2019-12-06T05:13:58.000Z/2019-12-06T05:13:59.000Z');
%TintInterested=irf.tint('2019-12-06T05:13:59.000Z/2019-12-06T05:14:00.000Z');
filter=[0.5,2.5];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#14------------------------------------------------------------------
Tint=irf.tint('2020-03-20T19:46:34.000Z/2020-03-20T19:47:50.000Z');
TintFig=irf.tint('2020-03-20T19:47:26.000Z/2020-03-20T19:47:35.000Z');
TintInterested=irf.tint('2020-03-20T19:47:29.000Z/2020-03-20T19:47:31.000Z');
filter=[0.5,2];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#15------------------------------------------------------------------
Tint=irf.tint('2021-01-12T01:19:34.000Z/2021-01-12T01:20:30.000Z');
TintFig=irf.tint('2021-01-12T01:19:55.000Z/2021-01-12T01:20:05.000Z');
TintInterested=irf.tint('2021-01-12T01:20:01.000Z/2021-01-12T01:20:03.000Z');
filter=[0.5,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#16------------------------------------------------------------------
Tint=irf.tint('2021-01-27T00:59:53.000Z/2021-01-27T01:02:13.000Z');
TintFig=irf.tint('2021-01-27T01:01:53.000Z/2021-01-27T01:01:56.000Z');
TintInterested=irf.tint('2021-01-27T01:01:54.000Z/2021-01-27T01:01:55.000Z');
filter=[0.5,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
% %
%%%%%case#17------------------------------------------------------------------
Tint=irf.tint('2021-02-27T12:56:05.000Z/2021-02-27T12:58:23.000Z');
TintFig=irf.tint('2021-02-27T12:57:49.000Z/2021-02-27T12:57:55.000Z');
TintInterested=irf.tint('2021-02-27T12:57:50.000Z/2021-02-27T12:57:52.000Z');
filter=[0.5,2];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#18------------------------------------------------------------------
Tint=irf.tint('2021-03-05T20:26:33.000Z/2021-03-05T20:27:43.000Z');
TintFig=irf.tint('2021-03-05T20:27:08.000Z/2021-03-05T20:27:11.000Z');
TintInterested=irf.tint('2021-03-05T20:27:08.500Z/2021-03-05T20:27:09.500Z');
filter=[0.5,5];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#19------------------------------------------------------------------!!!!!!!!!!!
Tint=irf.tint('2021-03-20T15:59:33.000Z/2021-03-20T16:01:53.000Z');
TintFig=irf.tint('2021-03-20T16:00:00.000Z/2021-03-20T16:01:00.000Z');
TintInterested=irf.tint('2021-03-20T16:00:03.000Z/2021-03-20T16:00:05.000Z');
filter=[0.5,5];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
%%%%%case#20------------------------------------------------------------------
Tint=irf.tint('2021-04-18T01:50:23.000Z/2021-04-18T01:54:03.000Z');
TintFig=irf.tint('2021-04-18T01:52:38.000Z/2021-04-18T01:52:45.000Z');
TintInterested=irf.tint('2021-04-18T01:52:42.000Z/2021-04-18T01:52:44.000Z');
filter=[1,4];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#21------------------------------------------------------------------
Tint=irf.tint('2021-12-07T13:23:43.000Z/2021-12-07T13:25:13.000Z');
TintFig=irf.tint('2021-12-07T13:24:17.000Z/2021-12-07T13:24:25.000Z');
TintInterested=irf.tint('2021-12-07T13:24:20.000Z/2021-12-07T13:24:23.000Z');
filter=[0.5,3];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
%%%%%case#22------------------------------------------------------------------
Tint=irf.tint('2021-12-18T05:06:00.000Z/2021-12-18T05:07:30.000Z');
TintFig=irf.tint('2021-12-18T05:06:27.000Z/2021-12-18T05:06:37.000Z');
TintInterested=irf.tint('2021-12-18T05:06:32.000Z/2021-12-18T05:06:34.000');
filter=[0.5,2];
filter=[0.5,6];
dataPointAhead=2000;
dataPointLagMax=2*dataPointAhead;
component=2;
% %%%--------------------------------------------------------------------------------------------------------------------------------------------------------------------

%%
%%%creat empty cells to store data of every MMS spacecraft---------------->
Bxyz4={};%Bxyz(FGM)
Rxyz4={};%Rxyz
Bscm4={};%Bxyz(SCM)
RxyzNew4={};%Rxyz with resolution the same with Bxyz(SCM)
bwwFilter4={};%component of Bxyz(SCM) filtered
bww4={};%component of Bxyz(SCM) without filtered
bbSCShifted4={};%component after shift of Bxyz(SCM) filtered
CCM4M1={};%correlation coefficient between MMS? data shifted and MMS1 data
posDiffM4={};%position difference between MMS? and MMS1
timeLagM4={};%time lag between MMS? and MMS1
%%%<----------------creat empty cells to store data of every MMS spacecraft
%%%calculate time lag, position difference, and correlation--------------->
for sc = 1:4%spacecraft number
    c_eval('Bxyz=mms.db_get_ts(''mms?_fgm_brst_l2'',''mms?_fgm_b_gse_brst_l2'',Tint);',sc);%load data
    c_eval('Rxyz=mms.db_get_ts(''mms?_mec_srvy_l2_epht89d'',''mms?_mec_r_gse'',Tint);',sc);%load data
    c_eval('Bscm=mms.db_get_ts(''mms?_scm_brst_l2_scb'',''mms?_scm_acb_gse_scb_brst_l2'',Tint);',sc);%load data
    %
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
    %
    Bxyz4{sc,1}=Bxyz;                    %store Bxyz (FGM) of four spacecraft as cell
    Rxyz4{sc,1}=Rxyz;                          %store Rxyz of four spacecraft as cell
    Bscm4{sc,1}=Bscm;                          %store Bscm of four spacecraft as cell
    RxyzNew=Rxyz.resample(Bscm);                 %resample Rxyz to resolution in Bscm
    RxyzNew4{sc,1}=RxyzNew;                       %store high resolution Rxyz as cell
    bwM1        = Bscm.data(:,component);   %which component (xyz) will be shifted? 1:x;2:y;3:z
    bwM1Filter  = bandpass(bwM1,filter,8192);                                 %filter  b?
    bwwFilter = TSeries(Bscm.time,bwM1Filter);%%create tseries data for b? after filter
    bww       = TSeries(Bscm.time,bwM1);     %create tseries data for b? without filter
    bwwFilter4{sc,1} = bwwFilter;       %store filtered b? of four spacecraft as cell
    bww4{sc,1}       = bww;                      %store b? of four spacecraft as cell
    %%
    %index slice
    %data slice
    %epoch slice
    if sc > 1
        bb1=bwwFilter4{1,1};%import MMS1 data
        TintM1=TintInterested;
        epochBB1= bb1.time.epoch;
        indexSliceM1 = find(epochBB1 >= TintM1.epoch(1) & epochBB1 <= TintM1.epoch(2));%get interested index slice of MMS1 data
        epochSliceM1 = bb1.time(indexSliceM1);%get interested epoch slice of MMS1
        dataSliceM1  = bb1.data(indexSliceM1);
        %%%import data to be shift-----------------------------------------
        bbSC=bwwFilter4{sc,1};
        %%%-----------------------------------------import data to be shift
        %%%claculate the time delay between M1 and M?----------------------
        nextPart=sprintf('Claculate the time delay between M1 and M%d ......',sc);
        fprintf(nextPart);
        epochBBsc=bbSC.time.epoch;
        indexSliceMscSameAsM1 = find(epochBBsc >= TintM1.epoch(1) & epochBBsc <= TintM1.epoch(2));%find the slice of MMS1 data to be analysis
        %%-----------------------------------------------------------------
        %%make slices of different spacecraft have the same length---------
        if  length(indexSliceMscSameAsM1) > length(indexSliceM1)
            fprintf('\nDelete first line---------------------------------');
            indexSliceMscSameAsM1(1,:)=[];
        elseif length(indexSliceMscSameAsM1) < length(indexSliceM1)
            fprintf('\nAdd a line at the end-----------------------------');
            addLine=indexSliceMscSameAsM1(1)-1;
            indexSliceMscSameAsM1=[addLine;indexSliceMscSameAsM1];
        else
        end%%<-----make slices of different spacecraft have the same length
        %%-----------------------------------------------------------------
        sumDiff = zeros(dataPointLagMax,1);%create an array to store the calculated difference
        for dd = 1 : dataPointLagMax
            %get different data slice and calculate the difference
            %Finally, find the minimum difference and corresponding data slice, data index, time lag
            %fprintf('tt %d\n', dd);
            indexSliceMsc = (indexSliceMscSameAsM1-dataPointAhead)+dd;%slice to be shifted
            dataSliceMsc = bbSC.data(indexSliceMsc);%get the bb data slice of M? to calculatethe difference between M? and M1
            if length(dataSliceMsc) == length(dataSliceM1)%%che k
                sumDiffNsc = 0;
                NN = length(dataSliceM1);
                for nn = 1 : NN
                    sumDiffNsc = sumDiffNsc +sqrt((dataSliceMsc(nn)-dataSliceM1(nn))^2/NN);%calculate the difference between M? and M1
                end
                %fprintf('sumD %f\n', sumDiffN21);
            end
            sumDiff(dd) = sumDiffNsc;
        end
        minSumDiffMsc_vs_M1 = min(sumDiff);%calculate the minimum difference
        if minSumDiffMsc_vs_M1 == 0
            fprintf('-----');
            error('Time-series data have different length!');
        end
        indexMinLagMscVSM1 = find(sumDiff == minSumDiffMsc_vs_M1);%find the index slice corresponding to the minimum difference
        timeLagMscVSM1 = (indexMinLagMscVSM1 - dataPointAhead)/8192;%%%calculate time lag between MMS？ and MMS1
        %indexSliceMscMostCorrWithM1 = indexSliceMscSameAsM1 + timeLagMscVSM1*8192;
        indexSliceMscMostCorrWithM1 = indexSliceMscSameAsM1 + (indexMinLagMscVSM1 - dataPointAhead);
        %------------------------------------------------------------------
        RxyzMscNew=RxyzNew4{sc,1};%get high resolution Rxyz data of MMS?
        RxyzM1New =RxyzNew4{1,1};%get high resolution Rxyz data of MMS?
        %------------------------------------------------------------------
        epochSliceMscMostCorrWithM1 = epochBBsc(indexSliceMscMostCorrWithM1);
        epochSliceRxyzMsc=epochSliceMscMostCorrWithM1;
        indexSliceRxyzMsc= find(RxyzMscNew.time.epoch >= epochSliceRxyzMsc(1) & RxyzMscNew.time.epoch <= epochSliceRxyzMsc(end));
        dataSliceRxyzMsc=RxyzMscNew.data(indexSliceRxyzMsc,:);%do not fix
        %------------------------------------------------------------------
        %dataSliceRxyzMsc=RxyzMscNew.data(indexSliceMscMostCorrWithM1,:);%This
        %line is instead of above four rows.
        dataSliceRxyzM1=RxyzM1New.data(indexSliceM1,:);%Assume geometry of 4 sc is invariable in TintInterested
        posDiffMscM1=dataSliceRxyzMsc(1,:)-dataSliceRxyzM1(1,:);%position difference between MMS? and MMS1
        %
        dataSliceMscMostCorrWithM1=bbSC.data(indexSliceMscMostCorrWithM1);
        endPart=sprintf('\nCorrelation coefficient between MMS1 and MMS%d-------',sc);
        fprintf(endPart);
        CCMscM1=corrcoef(dataSliceM1,dataSliceMscMostCorrWithM1)
        %-----------------------claculate the time delay between M1 and M？
        bbSCShifted  =TSeries(epochSliceM1,dataSliceMscMostCorrWithM1);
        bb1NoShifted =TSeries(epochSliceM1,dataSliceM1);
        bbSCShifted4{1,1}  =bb1NoShifted;
        bbSCShifted4{sc,1} =bbSCShifted;
        CCM4M1{sc,1}       =CCMscM1;
        posDiffM4{sc,1}    =posDiffMscM1;
        timeLagM4{sc,1}    =timeLagMscVSM1;
    end
end
%%%<---------------calculate time lag, position difference, and correlation
%%
%%get time lag and position difference from cell created on last part
%%perform Timing analysis
timeLag21=timeLagM4{2,1};
timeLag31=timeLagM4{3,1};
timeLag41=timeLagM4{4,1};
posDiff21=posDiffM4{2,1};
posDiff31=posDiffM4{3,1};
posDiff41=posDiffM4{4,1};
[vTiming,normal]=TIMING2(timeLag21,timeLag31,timeLag41,posDiff21,posDiff31,posDiff41);
fprintf('Timing results-------');
fprintf('Velocity %f\n', vTiming);
fprintf('Normal %f\n', normal);
%%
%%plot Btot of four MMS spacecraft,
%%plot B?   of four MMS spacecraft
%%plot B?   of four MMS spacecraft
h=irf_plot(3,'newfigure');
%h=irf_figure(540+ic,8);
xSize=700; ySize=400;
set(gcf,'Position',[50 50 xSize ySize]);
%xwidth = 0.80;
%ywidth = 0.10;
%set(h(1),'position',[0.15 0.975-1*ywidth xwidth ywidth]);
%set(h(2),'position',[0.15 0.975-2*ywidth xwidth ywidth]);
%--------------------------------------------------------------------------
ip=1;
h(ip)=irf_panel('Bt');
BxyzM1=Bxyz4{1,1};%get Bxyz(FGM) data from Bxyz4 cell created on last part.
BxyzM2=Bxyz4{2,1};
BxyzM3=Bxyz4{3,1};
BxyzM4=Bxyz4{4,1};
B1=BxyzM1.abs;%calculate Btot
B2=BxyzM2.abs;
B3=BxyzM3.abs;
B4=BxyzM4.abs;
irf_plot(h(ip), B1, 'k');
hold(h(ip),'on');
irf_plot(h(ip), B2, 'm');
irf_plot(h(ip), B3, 'c');
irf_plot(h(ip), B4, 'b');
irf_legend(h(ip),{'B1'},[0.95 0.95], 'color','k');
irf_legend(h(ip),{'B2'},[0.95 0.85], 'color','m');
irf_legend(h(ip),{'B3'},[0.95 0.75], 'color','c');
irf_legend(h(ip),{'B4'},[0.95 0.65], 'color','b');
set(h(ip),'ylim',[0,25]);
ylabel(h(ip),{'|B| FGM (nT)'},'Interpreter','tex');
%--------------------------------------------------------------------------
ip=ip+1;
irf_plot(h(ip),bww4{1,1}, 'color','k')
hold(h(ip),'on');
irf_plot(h(ip),bww4{2,1}, 'color','m');
irf_plot(h(ip),bww4{3,1}, 'color','c');
irf_plot(h(ip),bww4{4,1}, 'color','b');
irf_legend(h(ip),{'Bx1'},[0.95 0.95], 'color','k');
irf_legend(h(ip),{'Bx2'},[0.95 0.85], 'color','m');
irf_legend(h(ip),{'Bx3'},[0.95 0.75], 'color','c');
irf_legend(h(ip),{'Bx4'},[0.95 0.65], 'color','b');
ylabel(h(ip),{' ','B scm no filter(nT)'},'Interpreter','tex');
%--------------------------------------------------------------------------
ip=ip+1;
irf_plot(h(ip), bwwFilter4{1,1}, 'k');
hold(h(ip),'on');
irf_plot(h(ip), bwwFilter4{2,1}, 'm');
irf_plot(h(ip), bwwFilter4{3,1}, 'c');
irf_plot(h(ip), bwwFilter4{4,1}, 'b');
irf_legend(h(ip),{'Bx1'},[0.95 0.95], 'color','k');
irf_legend(h(ip),{'Bx2'},[0.95 0.85], 'color','m');
irf_legend(h(ip),{'Bx3'},[0.95 0.75], 'color','c');
irf_legend(h(ip),{'Bx4'},[0.95 0.65], 'color','b');
ylabel(h(ip),{' ','B scm filter (nT)'},'Interpreter','tex');
set(h(ip),'ylim',[-4,4]);
%
irf_plot_axis_align(h(1:3));
irf_zoom(h(1:3),'x',TintFig);
set(h(1:3),'fontsize',12);
%%
%%plot B?   of four MMS spacecraft interested
%%plot B?   of four MMS spacecraft interested
h=irf_plot(2,'newfigure');
%h=irf_figure(540+ic,8);
xSize=800; ySize=300;
set(gcf,'Position',[50 50 xSize ySize]);
%xwidth = 0.80;
%ywidth = 0.10;
%set(h(1),'position',[0.15 0.975-1*ywidth xwidth ywidth]);
%set(h(2),'position',[0.15 0.975-2*ywidth xwidth ywidth]);
%
ip=1;
irf_plot(h(ip),bww4{1,1}, 'color','k')
hold(h(ip),'on');
irf_plot(h(ip),bww4{2,1}, 'color','m');
irf_plot(h(ip),bww4{3,1}, 'color','c');
irf_plot(h(ip),bww4{4,1}, 'color','b');
irf_legend(h(ip),{'B?1'},[0.90 0.95], 'color','k');
irf_legend(h(ip),{'B?2'},[0.90 0.85], 'color','m');
irf_legend(h(ip),{'B?3'},[0.90 0.75], 'color','c');
irf_legend(h(ip),{'B?4'},[0.90 0.65], 'color','b');
ylabel(h(ip),{' ','B? no filter (nT)'},'Interpreter','tex');
%%------------------------------------------------------
ip=2;
irf_plot(h(ip), bwwFilter4{1,1}, 'k');
hold(h(ip),'on');
irf_plot(h(ip), bwwFilter4{2,1}, 'm');
irf_plot(h(ip), bwwFilter4{3,1}, 'c');
irf_plot(h(ip), bwwFilter4{4,1}, 'b');
irf_legend(h(ip),{'B?1 filter'},[0.90 0.95], 'color','k');
irf_legend(h(ip),{'B?2 filter'},[0.90 0.85], 'color','m');
irf_legend(h(ip),{'B?3 filter'},[0.90 0.75], 'color','c');
irf_legend(h(ip),{'B?4 filter'},[0.90 0.65], 'color','b');
%set(h(ip),'ylim',[0,20]);
ylabel(h(ip),{' ','B? (nT)'},'Interpreter','tex');
irf_plot_axis_align(h(1:2));
irf_zoom(h(1:2),'x',TintInterested);
set(h(1:2),'fontsize',12);
%%
%%-------------------------------------------------------------------------
h=irf_plot(1,'newfigure');
%h=irf_figure(540+ic,8);
xSize=800; ySize=400;
set(gcf,'Position',[50 50 xSize ySize]);
xwidth = 0.80;
ywidth = 0.80;
set(h(1),'position',[0.15 0.975-1*ywidth xwidth ywidth]);
%
ip=1;
bb1Shiftered=bbSCShifted4{1,1};
bb2Shiftered=bbSCShifted4{2,1};
bb3Shiftered=bbSCShifted4{3,1};
bb4Shiftered=bbSCShifted4{4,1};
irf_plot(h(ip),bb1Shiftered,'color','k');
hold on;
irf_plot(h(ip),bb2Shiftered,'color','m');
irf_plot(h(ip),bb3Shiftered,'color','c');
irf_plot(h(ip),bb4Shiftered,'color','b');

%{
%%
%%%I performed minimum variance analysis on data without filter.
%%%The results are consistent with IDL pro.--wmm
%%%As a result, irf_minvar function is reliable.
%%%Codes for MVA on data without no filter-------------------------------->
% indexM1 = find(Bxyz_m1.time.epoch >= trangeM1.epoch(1) & Bxyz_m1.time.epoch <= trangeM1.epoch(2));
% BxyzM1=Bxyz_m1(indexM1);
% irf_minvar(BxyzM1);
%%%<--------------------------------Codes for MVA on data without no filter
%%%MVA on data filtered--------------------------------------------------->
Bscm_m1=Bscm4{1,1};
bwM1        = Bscm_m1.data(:,1);
byM1        = Bscm_m1.data(:,2);
bzM1        = Bscm_m1.data(:,3);
bwM1Filter  = bandpass(bwM1,filter,8192);
byM1Filter  = bandpass(byM1,filter,8192);
bzM1Filter  = bandpass(bzM1,filter,8192);
bM1Filter   = [bwM1Filter byM1Filter bzM1Filter];
BscmM1Filter = TSeries(Bscm_m1.time,bM1Filter);%%%1: x component
%%%get data slice of BxyzM1 interested------------------------------------>
indexM1 = BscmM1Filter.time.epoch >= TintM1.epoch(1) & BscmM1Filter.time.epoch <= TintM1.epoch(2);
BxyzM1  = BscmM1Filter(indexM1);%<-----------------------------------------
[~,eigenvalues,eigenvectors]=irf_minvar(BxyzM1);
disp(strcat('Max    eigenvalue l1=',num2str(eigenvalues(1),3),'v1=[',num2str(eigenvectors(1,1),3),', ',num2str(eigenvectors(1,2),3),', ',num2str(eigenvectors(1,3),3),']'))
disp(strcat('Interm eigenvalue l2=',num2str(eigenvalues(2),3),'v2=[',num2str(eigenvectors(2,1),3),', ',num2str(eigenvectors(2,2),3),', ',num2str(eigenvectors(2,3),3),']'))
disp(strcat('Min    eigenvalue l3=',num2str(eigenvalues(3),3),'v3=[',num2str(eigenvectors(3,1),3),', ',num2str(eigenvectors(3,2),3),', ',num2str(eigenvectors(3,3),3),']'))
%%%--------filter
angleTM=acos(eigenvectors(3,1)*normal(1)+eigenvectors(3,2)*normal(2)+eigenvectors(3,3)*normal(3))*180/pi;
disp(strcat('Angle between k_timedelay and k_mva =',num2str(angleTM)));


Bxyz=BxyzM1.data;
k_mva=eigenvectors(3,:);
kMVAdotB=k_mva(1).*Bxyz(:,1)+k_mva(2).*Bxyz(:,2)+k_mva(3).*Bxyz(:,3);
k_timing=normal';
kTimingDotB=k_timing(1).*Bxyz(:,1)+k_timing(2).*Bxyz(:,2)+k_timing(3).*Bxyz(:,3);
%%
%}
warn = ('Check: Is timeLag smaller than dataPointAhead?');
warn = [warn newline 'Check: Is timeLag same with case in figure? '];
warn = [warn newline 'Check: Which component (xyz) are selected to analysis?'];
error(warn);

