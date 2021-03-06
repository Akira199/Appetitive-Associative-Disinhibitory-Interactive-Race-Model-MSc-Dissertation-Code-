%% Unit_Appetitive_Activation.m
% simulate GO_unit and STOP_unit 

% ---------original activation diff. eq. from Interactive Race Model----- %
% da (t) = [feedforward_input - decay + recurr_excitation - inhib_influences] + noise

%% Setting time

endTime1 = fixRespond; % only when time 0
endTime2 = TrGO; % accum. starts in go process

% when stop signal presented
if aSTOPtrial == 1      
    endTime3 = SSDRespond+time_delay;    % time = SSD+Dstop (accumulation in the STOP process starts)
    endTime4 = trialLength;              % time = end of trial
else
    endTime3 = trialLength;              % no stop signal trial - accumulation in STOP never starts
    endTime4 = trialLength+1;
end

%% Input being accumulated in Go and Stop units

randDist1 = [];randDist1 = (normrnd(meanGO, stdSTOP, trialLength, 1)); % GO Unit input
randDist2 = [];randDist2 = (normrnd(meanSTOP, stdSTOP, trialLength, 1)); %STOP Unit input

%% Which process is active: 
for trlen = 2:1:trialLength
    % begin by picking a random increment for each time step 
    level_pGo = randDist1(trlen);
    level_pStop = randDist2(trlen);
    %Which process is active:
% GOunitActive/STOPunitActive = 1 % active
% GOunitActive/STOPunitActive = 0 % not active

if trlen == 1
elseif trlen <= endTime1 % at time 0
    GOUnitActive = 0;
    STOPUnitActive = 0;
elseif trlen <= endTime2 % before go process started
    GOUnitActive = 0;
    STOPUnitActive = 0;
elseif trlen <= endTime3 % after go process started, before SSD+Dstop
    GOUnitActive = 1;
    STOPUnitActive = 0;
elseif trlen <= endTime4 % after SSD+Dstop
    GOUnitActive = 1;
    STOPUnitActive = 1;
end

%Current Activity Level

currActGO = GOUnit(trlen-1);
currActSTOP = STOPUnit(trlen-1);

% Noise added
% Kept same as Boucher et.al.,(2007)
% Original Inter. RM calc. Noise using vector approach and not
% trial-by-trial approach
% AADI-RM uses same way to calc Nois
noiseGo = 0;
noiseStop = 0;


% GO Unit Activation diff eq.
GOUnit (trlen) = ((currActGO*GOUnitActive + level_pGo*GOUnitActive) - ...
                (kGo*currActGO) - ((BStop*STOPUnitActive)*currActSTOP))+ noiseGo;

% STOP Unit Activation diff eq.
STOPUnit(trlen) = ((currActSTOP*STOPUnitActive + level_pStop*STOPUnitActive) - ...
              (kStop*currActSTOP) - ((BGo*GOUnitActive)*currActGO))+ noiseStop;


    % reticfy activations below 0
    if GOUnit(trlen) <0 
        GOUnit (trlen) = 0;
    end 
    if STOPUnit(trlen) <0
        STOPUnit (trlen) = 0;
    end 
end 
    
    