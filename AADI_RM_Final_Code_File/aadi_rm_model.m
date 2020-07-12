%% Select cues to activate model type
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
%=======================================================================================%
% NUMBER OF TRIALS:
% NUMB_TR = number of trials to simulate at each SSD and NSS.  This is the minimum
% number of trials that will be simulated.  The simulation runs until the
% minimum number of RTs are produced (NSS trials or noncanceled trials) or
% the number of trials equals 2.5 times this minimum.
%=======================================================================%
NUMB_TR = 4000;  % ran 4000 trials similar to the Boucher et.al., (2007) paper
%=======================================================================%
%% SPECIFYING PARAMETERS:
% for Neu_Cue: Interactive Race Model Params:[meanGo, stdGo, meanSTOP, stdSTOP, inhibGO, inhibSTOP, DStop]
% for App_Cue: AADI-Race Model Params:[meanGo, stdGo, meanSTOP, stdSTOP, inhibGO, inhibSTOP, ...
%                                           lambdaGO, lambdaSTOP, DStop]

param = [5.6221, 20.4270, 5.6221, 20.4060, 0.0104,0.0104, 3, 0.5, 70]; % --> mock values for cueType = 1 AADI_RM variant 
%param = [4.6023, 20.2234, 4.6023, 20.2234, 0.0104,0.04336,70];%mock vals for cueType = 0 interactive variant

%param_interactive = [4.6221, 20.4270, 4.6221, 20.4060, 0.0104,0.4336,67];...
%--> best fitting values used in Boucher et el.,
%% ======================================================================
% SPECIFY SSDs:
% these are the times when a stop signal is presented
% =======================================================================
SSDall = [100,150,200,250,300,350];  % in ms - these are taken from Monkey C from Boucher et.al.,2007--> mock values but 250 and 300 added by AkB:

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
    HostCMSimulation_Public(param, SSDall, NUMB_TR, cueType, 0, 0);

for x = 1:1:length(ALLSS_rtSim)
    SS_rtSim(x).rt = ALLSS_rtSim(x).rt(find(ALLSS_rtSim(x).dec==1));  % only count noncanceled RTs
end

meanIntSSRT = SSRT(1);
meanSSRT = SSRT(2);
overallMeanSSRT = SSRT(3);
SSRT_by_SSD = SSRT(4:end);

%%
% =======================================================================
% PLOT DATA
% =======================================================================
PlotCM_Public;

toc