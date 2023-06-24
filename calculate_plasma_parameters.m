function [structPlasmaParas]=calculate_plasma_parameters(Bt,N)
%Bt in nT
%N  in cm^-3
Bin_T   = Bt*1e-9;
Nin_m3  = N*1e6;
%
electronCyclotronFrequencyRads = 1.759*1e11*Bin_T;%%%in rad/s
electronCyclotronFrequencyHz   = 2.800*1e10*Bin_T;%%%in Hz
ionCyclotronFrequencyRads      = 9.577*1e7*Bin_T;%%%in rad/s
ionCyclotronFrequencyHz        = 1.524*1e7*Bin_T;%%%in Hz
lowerHybridFrequencyRads       = sqrt(electronCyclotronFrequencyRads*ionCyclotronFrequencyRads);
lowerHybridFrequencyHz         = sqrt(electronCyclotronFrequencyHz*ionCyclotronFrequencyHz);
% %
lightSpeed = 299792458;
electronPlasmaFrequencyRads    = 5.641*10*sqrt(Nin_m3);%%%in rad/s
electronPlasmaFrequencyHz      = 8.978*sqrt(Nin_m3);%%%in Hz
electronInertialLength          = lightSpeed/electronPlasmaFrequencyRads;%%%m
% %
ionPlasmaFrequencyRads         = 1.316*sqrt(Nin_m3);%%%in rad/s
ionPlasmaFrequencyHz           = 2.094*1e-1*sqrt(Nin_m3);%%%in Hz
ionInertialLength              = lightSpeed/ionPlasmaFrequencyRads;%%%in m
% %
AlfvenSpeed                    = 2.181*1e16*Bin_T/sqrt(Nin_m3);%%%in m/s
%%
structPlasmaParas=struct('magneticField',Bt);
structPlasmaParas.density=N;
structPlasmaParas.omega_ce=electronCyclotronFrequencyRads;%%%in rad/s
structPlasmaParas.f_ce    =electronCyclotronFrequencyHz;%%%in Hz
structPlasmaParas.omega_ci=ionCyclotronFrequencyRads;%%%in rad/s
structPlasmaParas.f_ci    =ionCyclotronFrequencyHz;%%%in Hz
structPlasmaParas.omega_lh=lowerHybridFrequencyRads;
structPlasmaParas.f_lh    =lowerHybridFrequencyHz;
% %
structPlasmaParas.omega_pe=electronPlasmaFrequencyRads;%%%in rad/s
structPlasmaParas.f_pe    =electronPlasmaFrequencyHz;%%%in Hz
structPlasmaParas.lambda_e=electronInertialLength*1e-3;%%%km
% %
structPlasmaParas.omega_pi=ionPlasmaFrequencyRads;%%%in rad/s
structPlasmaParas.f_pi    =ionPlasmaFrequencyHz;%%%in Hz
structPlasmaParas.lambda_i=ionInertialLength*1e-3;%%%in km
% %
structPlasmaParas.va      =AlfvenSpeed*1e-3;%%%in km/s

end