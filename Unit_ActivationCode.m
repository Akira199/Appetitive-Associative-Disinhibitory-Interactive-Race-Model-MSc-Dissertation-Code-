%% Unit_Activation.m
% simulate GO_unit and STOP_unit 

% ---------original activation diff. eq. from Interactive Race Model----- %
% da (t) = [feedforward_input - decay + recurr_excitation - inhib_influences] + noise

% ---------augmented activation diff. eq. from AADI-RM---- %
% da (t) = [feedforward_input - decay + recurr_excitation - (inhib_influences * lambda)] + noise

%% Setting time

endTime1 = fixResp; % only when time 0
endTime2 = trialGo; % accum. starts in go process

% when stop signal presented
if aSTOPtrial == 1
    endTime3 = SSDResp + timeDelay; % accumulation in stop process starts
    endTime4 = trialLen;
else
    endTime3 = trialLen;        % no-stop signal presented so stop process accumulation never starts
    endTime4 = trialLen + 1;
end

%% Input being accumulated in Go and Stop units

randDist1 = [];
randDist1 = (normmrnd(meanGo, stdStop, trialLen, 1)); % GO Unit input
randDist2 = [];
randDist2 = (normmrnd(meanStop, stdStop, trialLen, 1)); %STOP Unit input

%% Which process is active: 
for trlen = 2:1:trialLen
    % begin by picking a random increment for each time step 
    levelGo = randDist1(trlen);
    levelStop = randDist2(trlen);
    %Which process is active:
% GOunitActive/STOPunitActive = 1 % active
% GOunitActive/STOPunitActive = 0 % not active

if trlen == 1
elseif trlen <= endTime1 % at time 0
    GOunitActive = 0;
    STOPunitActive = 0;
elseif trlen <= endTime2 % before go process started
    GOunitActive = 0;
    STOPunitActive = 0;
elseif trlen <= endTime3 % after go process started, before SSD+Dstop
    GOunitActive = 1;
    STOPunitActive = 0;
elseif trlen <= endTime4 % after SSD+Dstop
    GOunitActive = 1;
    STOPunitActive = 1;
end

%Current Activity Level

currActGO = GOUnit(trlen-1);
currActSTOP = GOUnit(trlen-1);

% Noise added
% Kept same as Boucher et.al.,(2007)
% Original Inter. RM calc. Noise using vector approach and not
% trial-by-trial approach
% AADI-RM uses same way to calc Nois
GOnoise = 0;
STOPnoise = 0;

% Associative Memory Recall free param
% LamdaGO & LambdaSTOP
% Model lambda parameter value setting -- LamdaGO >> LambdaSTOP = BetaGO >>  BetaSTOP -- associative bias


% GO Unit Activation diff eq.
GOUnit (trlen) = ((currActGO*GOunitActive + levelGo*GOunitActive))-(kGO*GOunitActive) - ...
    ((BetaSTOP*STOPunitActive*LambdaSTOP))+ GOnoise;

% STOP Unit Activation diff eq.
STOPUnit(trlen) = ((currActSTOP*STOPunitActive + levelStop*STOPunitActive))-(kSTOP*STOPunitActive) - ...
    ((BetaGO*GOunitActive*LambdaGO))+ STOPnoise;

    % reticfy activations below 0
    if GOUnit(trlen) <0 
        GOUnit (trlen) = 0;
    end 
    if STOPUnit(trlen) <0
        STOPUnit (trlen) = 0;
    end 
end 
    
    