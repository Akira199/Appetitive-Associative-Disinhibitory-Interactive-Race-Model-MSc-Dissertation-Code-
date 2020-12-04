    
%%
% Load data and separating the Ss_data
load('switchingpictorial')
d = switchingpictorial;
t = array2table(d);
num_trials = 10240;
num_par = 31;
grps = repelem((1:num_par)',num_trials,1);
split_Ss = splitapply(@(varargin){[varargin{:}]},t,grps);
Ss_table = cell2table(split_Ss);

%% ==================================Incorrect RT Data-Outlier Trimming================================= %%

% Running RT outlier function on single Ss data and saving it in a new Data
% set based on condition (i.e., Switch and/or Repeat condition) 

u = cell(31,1); % initialise new cell array to run rtOutlierTrim function
switchDataIncorr = cell(31,1); %initialise new cell array to save switch data after rtTrimming
repeatDataIncorr = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
bb = cell(31,1);
for q = 1:length(split_Ss)
    u(q) = split_Ss(q);
    switchDataIncorr{q} = trimRTswitch_Incor(u{q}); % Switch Condition Data
    for x = 1:length(split_Ss)
        bb(x) = split_Ss(x);
        repeatDataIncorr{x} = trimRTrepeat_Incor(bb{x}); % Repeat Condition Data
    end
end
%% =========================================Skewness Test and Plotting -- Incorrect RT Data==============================================%%

% Initialisations of the variables before running the loops
switchData_tblIncorr = cell2table(switchDataIncorr);
Skw_RtDataSwitch_AcceptIncorr = cell(20,31);
Skw_RtDataSwitch_RejectIncorr = cell(20,31);
skewnessVal_switch_Incor = zeros(20,31);
hyp_Sw = zeros(20,31);
P_incor = zeros(20,31);
H = zeros(20,31);

for k = 1:height(switchData_tblIncorr)
     swtchIncor = switchData_tblIncorr.switchDataIncorr{k,1};
     for p = 1:20
     sessIdx_swIncor = swtchIncor(swtchIncor.session == p,{'rt'}); 
     sw_chDt_Incor = table2array(sessIdx_swIncor);
     if length(sw_chDt_Incor) <= 1 % debugging req
         sw_chDt_Incor(:,:) = []; %debugging req
     else
     skewnessVal_switch_Incor (p,k)= skewness(sw_chDt_Incor); % Skewness Calculation 
     [H,P_incor(p,k)] = JBtest(sw_chDt_Incor,0.05); % Jarque Bera Normality Test
    if P_incor(p,k) < .10 & skewnessVal_switch_Incor (p,k) > 0 % conditional checking for right skewness
            Skw_RtDataSwitch_AcceptIncorr (p,k) = {sw_chDt_Incor}';
            % subplotting Participant data based on skewness
            figure (k)
            sgtitle ({'Switching Pictorial - Incorrect RT Distributions',['Participant'  num2str(k)]})
            subplot(5,4,p)
            histogram(sw_chDt_Incor,35,'Facecolor','g')
            title(['Session' num2str(p)])
            xlabel('RT')
    else 
            Skw_RtDataSwitch_RejectIncorr(p,k)= {sw_chDt_Incor}';
            figure (k)
            sgtitle ({'Switching Pictorial - Incorrect RT Distributions',['Participant'  num2str(k)]})
            subplot(5,4,p)
            histogram(sw_chDt_Incor,35,'Facecolor','r')
            title(['Session' num2str(p)])
            xlabel('RT') 
    end
    end
    end
end