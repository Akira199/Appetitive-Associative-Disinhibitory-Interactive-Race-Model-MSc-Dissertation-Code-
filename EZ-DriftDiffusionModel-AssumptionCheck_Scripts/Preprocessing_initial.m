 %% ====================================PRE-PROCESSING CODE===================================== %%
              % ============================Participant Data Separation for fast-DM========================= %%

% Load data and separating the Ss_data
load('switchingpictorial')
d = switchingpictorial;
t = array2table(d);
num_trials = 10240;
num_par = 31;
grps = repelem((1:num_par)',num_trials,1);
split_Ss = splitapply(@(varargin){[varargin{:}]},t,grps);
Ss_table = cell2table(split_Ss);

                 %% ==================================Data Trimming: Correct RT Data-Outlier Trimming================================= %%

% Running RT outlier function on single Ss data and saving it in a new Data
% set based on condition (i.e., Switch and/or Repeat condition) 

uu = cell(31,1); % initialise new cell array to run rtOutlierTrim function
switchDataCor = cell(31,1); %initialise new cell array to save switch data after rtTrimming
repeatData = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
ab = cell(31,1);
for ii = 1:length(split_Ss)
    uu(ii) = split_Ss(ii);
    switchDataCor{ii} = trimRTswitch(uu{ii}); % Switch Condition Data
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % DEBUGGING REQ: this is not producing the repeatData -- line 27
        % Debbugged -- but by changing the RT_Trimming function structure
        % -- check the effiency of the method?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
  %% ==================================Data Trimming: Incorrect RT Data-Outlier Trimming================================= %%

% Running RT outlier function on single Ss data and saving it in a new Data
% set based on condition (i.e., Switch and/or Repeat condition) 

u = cell(31,1); % initialise new cell array to run rtOutlierTrim function
switchDataIncorr = cell(31,1); %initialise new cell array to save switch data after rtTrimming
repeatDataIncorr = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
bb = cell(31,1);
for q = 1:length(split_Ss)
    u(q) = split_Ss(q);
    switchDataIncorr{q} = trimRTswitch_Incor(u{q}); % Switch Condition Data
end
