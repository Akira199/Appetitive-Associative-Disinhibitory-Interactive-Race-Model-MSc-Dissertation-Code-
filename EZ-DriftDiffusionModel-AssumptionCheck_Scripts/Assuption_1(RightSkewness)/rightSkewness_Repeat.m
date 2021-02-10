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
repeatDataCor = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
ab = cell(31,1);

for zx = 1:length(split_Ss)
        ab(zx) = split_Ss(zx);
        repeatDataCor{zx} = trimRTrepeat(ab{zx}); % Repeat Condition Data
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
repeatDataIncorr = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
bb = cell(31,1);

for x = 1:length(split_Ss)
        bb(x) = split_Ss(x);
        repeatDataIncorr{x} = trimRTrepeat_Incor(bb{x}); % Repeat Condition Data 
end

%% =========================================Assumption 1: Skewness Test and Plotting -- Correct RT Data==============================================%%
% Initialisations of the variables before running the loops
repeatData_tbl = cell2table(repeatDataCor);
Skw_RtDataRepeat_Accept = cell(20,31);
Skw_RtDataRepeat_Reject = cell(20,31);
Skw_RtDataRepeat_Acc_RTs = cell(20,31);
Skw_RtDataRepeat_Rej_RTs = cell(20,31);
skewnessVal_Repeat = zeros(20,31);
hyp_Swcorr = zeros(20,31);
P = zeros(20,31);
H_corr = zeros(20,31);
Final_SwitchPicData_repeat = cell(31,1);
idxEmptySwitchPic_Repeat = cell(20, 31);
store_size = nan(20,31);

% ==================================================================== %
for kk = 1:height(repeatData_tbl)
     idxRepeat = repeatData_tbl.repeatDataCor{kk,1};
     for pp = 1:20
     sessIdx_Repeat = idxRepeat(idxRepeat.session == pp,:);
     Idx_repeat = idxRepeat(idxRepeat.session == pp,{'rt'});
     repeat_chDt = table2array(Idx_repeat);
     skewnessVal_Repeat (pp,kk)= skewness(repeat_chDt); % Skewness Calculation 
     [H,P(pp,kk)] = JBtest(repeat_chDt,0.05); % Jarque Bera Normality Test
     if P(pp,kk) < .10 & skewnessVal_Repeat (pp,kk) > 0 % conditional checking for right skewness
              
              Skw_RtDataRepeat_Accept (pp,kk) = {sessIdx_Repeat}';
              Skw_RtDataRepeat_Acc_RTs (pp,kk) = {repeat_chDt}';
             % subplotting Participant data based on skewness
             figure (kk)
             sgtitle ({'Switching Pictorial Condition:Repeat',['Participant'  num2str(kk)]})
             subplot(5,4,pp)
             histogram(repeat_chDt,35,'Facecolor','g')
             title(['Session' num2str(pp)])
             xlabel('RT')
    else 
             Skw_RtDataRepeat_Reject(pp,kk)= {sessIdx_Repeat}';
             Skw_RtDataRepeat_Rej_RTs (pp,kk) = {repeat_chDt}';
             
             % subplotting Participant data based on skewness
             figure (kk)
             sgtitle ({'Switching Pictorial Condition:Repeat',['Participant'  num2str(kk)]})
             subplot(5,4,pp)
             histogram(repeat_chDt,35,'Facecolor','r')
             title(['Session' num2str(pp)])
             xlabel('RT') 
     end 
     end
             idxEmptySwitchPic_Repeat{pp,kk} = isempty(Skw_RtDataRepeat_Accept{pp,kk});
     
    % This line brings togather all the data (no eliminations) i.e., all Ss
    % with right skewness test are compiled here:
    
    % Final Dataset for the Assumption 2 testing:
    Final_SwitchPicData_repeat = cat(1,Skw_RtDataRepeat_Accept{:});
end

% Note: that we did not need to remove any Ss -- only the sessions that
% did not pass the Right Skewness. All Ss had the 10 or >10 sessions in the
% final data set so we dont remove any Ss
