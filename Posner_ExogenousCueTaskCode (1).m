%% Posners Cueing Task - Endogenous Cue version 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Posner Cueing task %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Basic Instructions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Running the current task will need downloading - Psychtoolbox
% Download Psychtoolbox from the Psychtoolbox Website: http://psychtoolbox.org/download/)
% To check if Psychtoolbox is properly downloaded type ver in the command window
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Clearing all screens and variables

close all;
clearvars;
sca; 


% Entering basic Subject information before task 
participantID = input('Please enter your Subject Code'); % Subject ID code information
participantAge = input('Please enter your Age'); % Subject Age information
participantGender = input('Please enter your Gender', 's'); % Subject Gender information

% Default setting for Psychtoolbox
PsychDefaultSetup(2);

% Get screens
screens = Screen('Screens');
screenNumber = max(screens);

% Define Colors
white = WhiteIndex(screenNumber);
black= BlackIndex(screenNumber);
grey = white/2;

% Welcome screen and Instructions
[w1, rect] = PsychImaging('OpenWindow', screenNumber, black);
[xCenter, yCenter] = RectCenter(rect);
Priority(MaxPriority(w1));
HideCursor();

Screen('TextFont', w1, 'Times');
Screen('TextSize', w1, 40);
% Welcome screen
Screen('DrawText',w1,'Welcome to the Attention Task',...
       xCenter-280, yCenter-20,255); % dummy task name
Screen('Flip',w1),WaitSecs(2.5);

% Instructions screen (dummy instructions - can change based on the task
% instructions)
Screen('DrawText',w1,'Press any key for Instructions',...
       xCenter-280, yCenter-20,200);
Screen('Flip',w1);
Screen('DrawText',w1,'Instructions - Pay attention to the frames of the squaures',...
        xCenter-530, yCenter-20,255);
Screen('Flip',w1);WaitSecs(3);
Screen('DrawText',w1,'Instructions - Press the Right and Left buttons to respond',...
       xCenter-530, yCenter-20,255);
Screen('Flip',w1);WaitSecs(3);
Screen('DrawText',w1,'Instructions - Press any button Right or Left to proceed to next trial',...
       xCenter-530, yCenter-20,255);
Screen('Flip',w1);WaitSecs(3);

% Key Task info - Initialisations
nTrials = 30;
validCue_trials = 18;
targetTime = zeros(nTrials,1); 
rt = zeros(nTrials,1); 
Responses = zeros(nTrials,1); 

% Setting conditions in the task
conditions = [repmat(1,1,validCue_trials), ...
              repmat(2,1,nTrials - validCue_trials)];
rng('Shuffle');
conditionsRand = conditions(randperm(length(conditions)));

% Random cue set-up
setUp1Valid = 1; setUp2Valid = 2; setUp3Invalid = 3; setUp4Invalid = 4;
setUp = [repmat(1,1,validCue_trials),...
                repmat(2,1,validCue_trials),...
                repmat(3,1,nTrials - validCue_trials),...
                repmat(4,1,nTrials - validCue_trials)];

rng('Shuffle')
a = setUp(randperm(length(setUp)));
a(:,[nTrials+1:end]) = [];
trialSetUp = a;

% Continuing 
Screen('DrawText',w1,'Press any key to begin',...
        xCenter-280, yCenter-20,255);
Screen('Flip',w1);
pause;
Screen('Flip',w1);
WaitSecs(1);

% Draw Fixation cross 

ifi = Screen('GetFlipInterval', w1);

Screen('BlendFunction', w1,'GL_SRC_ALPHA','GL_ONE_MINUS_SRC_ALPHA');

% Setup the text type for the window

[screenPixelsX, screenPixelsY] = Screen('WindowSize',w1);
fixCrossDimPix = 40;
xCoords = [-fixCrossDimPix fixCrossDimPix 0 0];
yCoords = [0 0 -fixCrossDimPix fixCrossDimPix];
allCoords = [xCoords; yCoords];
lineWidthPix = 100;

Screen('DrawLines',w1,allCoords,white,...
      lineWidthPix,[xCenter, yCenter],2);
Screen('Flip',w1);
WaitSecs(1);

% Defining and drawing stimuli 

% Make a base Rect of 200 by 200 pixels  
baseRect = [0 0 300 300];

% Screen X positions of our three rectangles
squareXpos = [screenPixelsX * 0.25, screenPixelsX * 0.75];
numSquares = length(squareXpos);

% Make our rectangle coordinates
allRects = nan(4, 2); 
for ii = 1:numSquares
    allRects(:, ii) = CenterRectOnPointd(baseRect, squareXpos(ii), yCenter);
end   

% Pen width for the frames
penWidthPixels = [6,30];
penWidthPixels2 =[30,6];


% Task Trial Block

for trialCount = 1:nTrials
    if conditionsRand (trialCount) == 1
        if trialSetUp(trialCount) == 1
        % Valid-cue set-up: 1
            Screen('FrameRect',w1,[0 255 0],allRects,penWidthPixels);
            Screen('Flip',w1);pause; 
            Screen('FillRect', w1, [0 255 0], allRects(:,1));
            Screen('Flip',w1); WaitSecs(0.5); 
    
        elseif trialSetUp (trialCount) == 2
        % Valid-cue set-up: 2
               Screen('FrameRect',w1,[255 0 0],allRects,penWidthPixels2);
               Screen('Flip',w1);pause; 
               Screen('FillRect', w1, [255 0 0], allRects(:,2));
               Screen('Flip',w1); WaitSecs(0.5);  
        end 
    elseif conditionsRand (trialCount)== 2
    % Non-Valid-cue set-up: 1
              if trialSetUp (trialCount) == 3
                 Screen('FrameRect', w1, [255 0 0], allRects, penWidthPixels2);
                 Screen('Flip',w1);pause;
                 Screen('FillRect', w1, [255 0 0], allRects(:,1));
                 Screen('Flip',w1); WaitSecs(0.5);  
    
    % Non-Valid-cue set-up: 2
             elseif trialSetUp (trialCount) == 4
                    Screen('FrameRect',w1,[0 255 0],allRects,penWidthPixels);
                    Screen('Flip',w1);pause; 
                    Screen('FillRect', w1, [0 255 0], allRects(:,2));
                    Screen('Flip',w1); WaitSecs(0.5); 
              end
    end  
      Screen('Flip',w1);
   
        % Response Recording
        targetTime(trialCount) = GetSecs;
        time = GetSecs;
        RightButton = KbName('RightArrow');
        LeftButton = KbName('LeftArrow');
       [keyIsDown,keysecs, keyCode] = KbCheck;
            while keyCode (RightButton) == 0 && ...
             keyCode (LeftButton) == 0
             [keyIsDown,keysecs, keyCode] = KbCheck;
            end
       Screen('Flip',w1);
       if keyCode(RightButton) == 1
           Responses(trialCount) = 1;
       end
     Screen('Flip',w1);
       % Reaction Time
       rt(trialCount) = keysecs - time;
end
finRT = rt*1000;
% End Task - close all screens
sca;
% Save participant data (saves in current CD) 
save(sprintf('%s_data_%dGo', participantID, validCue_trials));
