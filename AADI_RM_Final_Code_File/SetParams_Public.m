%% SetParams_Public.m
% =========================================================================
%                               set parameters
% =========================================================================

meanGO = param(1);
stdGO = param(2);
modelActivated = ' ';

if  cueType == 0  % activate Interactive Race Model
    meanSTOP = param(3); 
    stdSTOP = param(4); 
    BGo = param(5);
    BStop = param(6);
    time_delay = ceil(param(7));
    modelActivated = 'Interactive Race Model';
end

if cueType == 1 % activate AADI-RM model
    meanSTOP = param(3); 
    stdSTOP = param(4); 
    BGo = param(5);
    BStop = param(6);
    lambdaGO = param (7);
    lambdaSTOP = param (8);
    time_delay = ceil(param(9));
    modelActivated = 'Appetitive Associative Disinhibitory Interactive Race Model';
end

if time_delay < 0
    time_delay = 0;
end
 

BGo = abs(BGo);
BStop = abs(BStop);

% leakage terms
kGo = 0;
kStop = 0;

TrGO = 35;  % set to Monkey C's value taken from Boucher et.al.,

% output values once
if cueType == 0
if nt == 1 && iteration == 0
    cueType
    meanGO;       
    stdGO;
    meanSTOP;
    stdSTOP;
    BGo
    BStop
    TrGO;
    time_delay;
end
end

if cueType == 1
if nt == 1 && iteration == 0
    cueType
    meanGO;       
    stdGO;
    meanSTOP;
    stdSTOP;
    BGo
    BStop
    lambdaGO
    lambdaSTOP
    TrGO;
    time_delay;
end
end

