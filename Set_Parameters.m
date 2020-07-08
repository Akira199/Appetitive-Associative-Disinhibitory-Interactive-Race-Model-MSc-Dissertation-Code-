%% Setting parameters
%==========================================================================%
%                                set parameters                            %   
%==========================================================================%

meanGo = param (1); 
stdGO = param (2);
modelActivated = '';

if cueType == 0 % activate Interactive Race Model
    meanSTOP = param (3);
    stdSTOP = param (4);
    BetaGO = param (5);
    BetaSTOP = param (6);
    timeDelay = ceil(param(7));
    modelActivated = 'Interactive Race Model';
end

if cueType == 1 % activate AADI-RM model
    meanSTOP = param (3);
    stdSTOP = param (4);
    BetaGO = param (5);
    BetaSTOP = param (6);
    lambdaGO = param (7);
    lambdaSTOP = param (8);
    timeDelay = ceil(param(9));
    modelActivated = 'Appetitive Associative Disinhibitory Interactive Race Model';
end

% Set time delay

if timeDelay < 0
    timeDelay = 0;
end

% Set inhib influences to abs val
BetaGO = abs(BetaGO);
BetaSTOP = abs(BetaSTOP);

% Leakage terms (kept same as Boucher et.al.,2007)
kGO = 0; 
kSTOP = 0; 

TrGO = 35; % this value is basically the vaule the time when Ss starts responding (in ms) - vals can change

% Output values 
% Cue Type -> Neutral 
if nt == 0 && iteration == 0
    cueType
    meanGO;
    stdGO;
    meanSTOP;
    stdSTOP;
    BetaGO;
    BetaSTOP;
    TrGO;
    timeDelay;
end 

% Cue Type -> Appetitive

if nt == 1 && iteration == 0
    cueType
    meanGO;
    stdGO;
    meanSTOP;
    stdSTOP;
    BetaGO;
    BetaSTOP;
    lambdaGO;
    lambdaSTOP;
    TrGO;
    timeDelay;
end 



    