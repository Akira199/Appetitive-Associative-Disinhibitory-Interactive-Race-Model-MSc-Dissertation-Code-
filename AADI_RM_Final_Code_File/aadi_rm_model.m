
%Code to run versions of models -- AADI-RM and Interactive Model (Boucher
%et.al.,2007) based on Cue-Type presented.
% In addition to this file, you need to download the following files from
% this same directory
% READ-ME-FILE.pdf
% Unit_AppetitiveActivationCode.m
% Unit_NeutralActivationCode.m
% CalcSSRT_Public.m
% cdfFunc.m
% getActFunc_Public.m
% HostCMSimulation_Public.m
% InhCumWeib.m
% LatMatch_Public.m
% OneTrial_Public.m
% PlotCM_Public.m
% SetParams_Public.m
% SSRT_LB_bestfit.m
% ttest_LB.m
% ======================================================================= %

% ======================================================================= %
close all;
format
warning off all;
tic
% =======================================================================
% MODEL TYPES activated to cueType input:
% Neu_Cue = 0 % Neutral Cue (activate the Interactive Race Model)
% App_Cue = 1 % Appetitive Cue (activate the AADI-RM Model)
%=======================================================================================%
cueType = 1;
% ======================================================================================%
% NUMBER OF TRIALS:
% NUMB_TR = number of trials to simulate at each SSD and NSS.  This is the minimum
% number of trials that will be simulated.  The simulation runs until the
% minimum number of RTs are produced (NSS trials or noncanceled trials) or
% the number of trials equals 2.5 times this minimum.
% =======================================================================
NUMB_TR = 4000;  % ran 4000 trials in the Boucher et.al., (2007) paper
% =======================================================================
%% SPECIFYING PARAMETERS:
% for Neu_Cue: Interactive Race Model Params:[meanGo, stdGo, meanSTOP, stdSTOP, inhibGO, inhibSTOP, DStop]
% for App_Cue: AADI-Race Model Params:[meanGo, stdGo, meanSTOP, stdSTOP, inhibGO, inhibSTOP, ...
%                                           lambdaGO, lambdaSTOP, DStop]

param_AADI = [4.6221, 20.4060, 4.6221, 20.4060, 0.0104,0.4336, 3, 0.5,67]; % --> mock values 
%param_interactive = [4.6221, 20.4270, 4.6221, 20.4060, 0.0104,0.4336,67];...
%--> best fitting values taken from Boucher et el., (for mock vals)

%param_interactive = [4.6221, 20.4270, 4.6221, 20.4060, 0.0104,0.4336,67];...
%--> best fitting values taken from Boucher et el., (for mock vals)
%% ======================================================================
% SPECIFY SSDs:
% these are the times when a stop signal is presented
% =======================================================================
SSDall = [69   117   169   217  250  300];  % in ms - these are taken from Monkey C from Boucher et.al.,2007--> mock values but 250 and 300 added by AkB:

%%
% =======================================================================
% RUN MODEL:
% inputs: 
%       [parameters, SSDs, number of trials, cueTypr, seed, iteration]
%       - seed and iteration set to 0 for full run of model
% outputs: 
%       [NSS RTs, inhibition function, noncanceled RTs, SSRT (via the integration method,
%       the difference method, the overall SSRT, the mean of the inhibition function), 
%       cancel times for GO and STOP processes, and activation functions]
% =======================================================================
[dataSim, inhibSim, ALLSS_rtSim, SSRT, ActFunc] = ...
    HostCMSimulation_Public(param_AADI, SSDall, NUMB_TR, cueType, 0, 0);

for x = 1:1:length(ALLSS_rtSim)
    SS_rtSim(x).rt = ALLSS_rtSim(x).rt(find(ALLSS_rtSim(x).dec==1));  % only count noncanceled RTs
end

meanIntSSRT = SSRT(1);
meanSSRT = SSRT(2);
overallMeanSSRT = SSRT(3);
SSRT_by_SSD = SSRT(4:end);

%%
% =======================================================================
% subsample model many times 
% =======================================================================
 NUMB_TR = 30;       % set to 20 in paper
for x = 1:1:500     % set to 500 in paper
     rand('state',x);
     master_seed = ceil(rand(1,1)*100);

    % =======================================================================
    % RUN MODEL many times:
    % inputs: [parameters, SSDs, number of trials, model number, seed,
    %   iteration]
    %       - seed and iteration set to > 0 for subset run of model
    % outputs: [NSS RTs, inhibition function, noncanceled RTs, SSRT (via the integration method,
    %   the difference method, the overall SSRT, the mean of the inhibition function)and activation functions]
    % =======================================================================
    [dataSim_temp, inhibSim_temp, ALLSS_rtSim_temp, SSRT_temp] = ...
        HostCMSimulation_Public(param_AADI, SSDall, NUMB_TR, cueType, master_seed, x);
end

%%
% =======================================================================
% PLOT DATA
% =======================================================================
PlotCM_Public;

toc