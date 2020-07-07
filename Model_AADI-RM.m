%Code to run versions of models presented in Boucher, Palmeri, Logan, and Schall (2007).
%Inhibitory control in mind and brain: An interactive race model of countermanding saccades (Boucher et.al.2007).

%=========================================================================================%
% model code includes code to test AADI-RM - modelNo 2 (addition made by AkB)
%=========================================================================================%
clear all; close all;
format
warning off all;
tic

% =======================================================================
% MODEL TYPES:
% 0 = independent
% 1 = interactive
% 2 = AADI-RM
% =======================================================================
modelNo = 1;
%==============================================================
% NUMBER OF TRIALS:
% NUMB_TR = number of trials to simulate at each SSD and NSS.  This is the minimum
% number of trials that will be simulated.  The simulation runs until the
% minimum number of RTs are produced (NSS trials or noncanceled trials) or
% the number of trials equals 2.5 times this minimum.
% =======================================================================
NUMB_TR = 4000;  % ran 4000 trials 

% =======================================================================
% SPECIFY PARAMETERS:
% for interactive model: [meanGO stdGO meanSTOP stdSTOP inhibGO inhibSTOP Dstop]
% for independent model: [meanGO stdGO meanSTOP stdSTOP Dstop]
% =======================================================================

%% best fitting parameters found for Monkey C in paper for INTERACTIVE model
% param = [4.6335   20.4270   4.6221   20.4060    0.0104    0.4336   67];
%% best fitting parameters found for Monkey C in paper for INDEPENDENT model
% param = [4.64   20.26   17.67   15.58   29];

%% ENTER your own params
 % Set by Boucher et.al.,(2007):
% For Independent Model, the order is :
%       [meanGO stdGO meanSTOP stdSTOP Dstop]
% For Interactive Model, the order is :
%       [meanGO stdGO meanSTOP stdSTOP inhibGO inhibSTOP Dstop]
 % Set by AkB:
% For AADI-RM :
%       [meanGO stdGO meanSTOP stdSTOP inhibGO inhibSTOP Dstop lambdaGO lambdaSTOP]
param_interactive = [4.6335   20.4270   4.6221   20.4060    0.0104    0.0104   67];
%param_independent = [5.6221  20.4270   5.6221   20.4060  67];
% ======================================================================= %
% SPECIFY SSDs:
% these are the times when a stop signal is presented
% =======================================================================
SSDall = [69   117   169   217  250 300];  % in ms - these are taken from Monkey C 
% AkB: I have changed the last SSD from 217 to 250 from the original paper

%%
% =======================================================================
% RUN MODEL:
% inputs: 
%       [parameters, SSDs, number of trials, model number, seed, iteration]
%       - seed and iteration set to 0 for full run of model
% outputs: 
%       [NSS RTs, inhibition function, noncanceled RTs, SSRT (via the integration method,
%       the difference method, the overall SSRT, the mean of the inhibition function), 
%       cancel times for GO and STOP processes, and activation functions]
% =======================================================================
[dataSim, inhibSim, ALLSS_rtSim, SSRT, cancelTimes, ActFunc] = ...
    HostCMSimulation_Public(param_interactive, SSDall, NUMB_TR, modelNo, 0, 0);

for x = 1:1:length(ALLSS_rtSim)
    SS_rtSim(x).rt = ALLSS_rtSim(x).rt(find(ALLSS_rtSim(x).dec==1));  % only count noncanceled RTs
end

meanIntSSRT = SSRT(1);
meanSSRT = SSRT(2);
overallMeanSSRT = SSRT(3);
SSRT_by_SSD = SSRT(4:end);

%%
% =======================================================================
% subsample model many times to get cancel times
% =======================================================================
NUMB_TR = 20;       % set to 20 in paper
for x = 1:1:500     % set to 500 in paper
    rand('state',x);
    master_seed = ceil(rand(1,1)*100);

    % =======================================================================
    % RUN MODEL many times:
    % inputs: [parameters, SSDs, number of trials, model number, seed,
    %   iteration]
    %       - seed and iteration set to > 0 for subset run of model
    % outputs: [NSS RTs, inhibition function, noncanceled RTs, SSRT (via the integration method,
    %   the difference method, the overall SSRT, the mean of the inhibition function), cancel times
    %   for GO and STOP processes, and activation functions]
    % =======================================================================
    [dataSim_temp, inhibSim_temp, ALLSS_rtSim_temp, SSRT_temp, cancelTimes] = ...
        HostCMSimulation_Public(param_interactive, SSDall, NUMB_TR, modelNo, master_seed, x);

     %GOunitCancelTime(x, :) = cancelTimes.AT(1, :) - (SSDall + SSRT_temp(4:end));
     %STOPunitCancelTime(x, :) = cancelTimes.TTstop(1, :) - (SSDall + SSRT_temp(4:end));
end

% ======= Cancel Time (Neural correlate measure (Boucher et.al.,2007) ===%
% Eliminated from AADI-RM:
%meanGOunitCancelTime = round(nanmean(GOunitCancelTime));
%meanSTOPunitCancelTime = round(nanmean(STOPunitCancelTime));

%%
% =======================================================================
% PLOT DATA
% =======================================================================
PlotCM_Public;

toc