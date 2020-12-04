
              % ====================================PRE-PROCESSING CODE===================================== %%
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

                 %% ==================================Correct RT Data-Outlier Trimming================================= %%

% Running RT outlier function on single Ss data and saving it in a new Data
% set based on condition (i.e., Switch and/or Repeat condition) 

uu = cell(31,1); % initialise new cell array to run rtOutlierTrim function
switchData = cell(31,1); %initialise new cell array to save switch data after rtTrimming
repeatData = cell(31,1); %initialise new cell array to save repeate data after rtTrimming
ab = cell(31,1);
for ii = 1:length(split_Ss)
    uu(ii) = split_Ss(ii);
    switchData{ii} = trimRTswitch(uu{ii}); % Switch Condition Data
    for zx = 1:length(split_Ss)
        ab(zx) = split_Ss(zx);
        repeatData{zx} = trimRTrepeat(ab{zx}); % Repeat Condition Data
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        % DEBUGGING REQ: this is not producing the repeatData -- line 27
        % Debbugged -- but by changing the RT_Trimming function structure
        % -- check the effiency of the method?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%               
%% =========================================Skewness Test and Plotting -- Correct RT Data==============================================%%
% Initialisations of the variables before running the loops
switchData_tbl = cell2table(switchData);
Skw_RtDataSwitch_Accept = cell(20,31);
Skw_RtDataSwitch_Reject = cell(20,31);
skewnessVal_switch = zeros(20,31);
hyp_Swcorr = zeros(20,31);
P = zeros(20,31);
H_corr = zeros(20,31);

for kk = 1:height(switchData_tbl)
     swtch = switchData_tbl.switchData{kk,1};
     for pp = 1:20
     sessIdx_sw = swtch(swtch.session == pp,{'rt'}); 
     sw_chDt = table2array(sessIdx_sw);
     skewnessVal_switch (pp,kk)= skewness(sw_chDt); % Skewness Calculation 
     [H,P(pp,kk)] = JBtest(sw_chDt,0.05); % Jarque Bera Normality Test
    if P(pp,kk) < .10 & skewnessVal_switch (pp,kk) > 0 % conditional checking for right skewness
            Skw_RtDataSwitch_Accept (pp,kk) = {sw_chDt}';
            % subplotting Participant data based on skewness
            figure (kk)
            sgtitle ({'Switching Pictorial',['Participant'  num2str(kk)]})
            subplot(5,4,pp)
            histogram(sw_chDt,35,'Facecolor','g')
            title(['Session' num2str(pp)])
            xlabel('RT')
    else 
            Skw_RtDataSwitch_Reject(pp,kk)= {sw_chDt}';
            figure (kk)
            sgtitle ({'Switching Pictorial',['Participant'  num2str(kk)]})
            subplot(5,4,pp)
            histogram(sw_chDt,35,'Facecolor','r')
            title(['Session' num2str(pp)])
            xlabel('RT') 
    end 
    end
end

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
switchData_tblIncorr = cell2table(switchData);
Skw_RtDataSwitch_AcceptIncorr = cell(20,31);
Skw_RtDataSwitch_RejectIncorr = cell(20,31);
skewnessVal_switch_Incor = zeros(20,31);
hyp_Sw = zeros(20,31);
P_incor = zeros(20,31);
H = zeros(20,31);

for k = 1:height(switchData_tblIncorr)
     swtchIncor = switchData_tblIncorr.switchData{k,1};
     for p = 1:20
     sessIdx_swIncor = swtchIncor(swtchIncor.session == p,{'rt'}); 
     sw_chDt_Incor = table2array(sessIdx_swIncor);
     skewnessVal_switch_Incor (p,k)= skewness(sw_chDt_Incor); % Skewness Calculation 
     [H,P_incor(p,k)] = JBtest(sw_chDt_Incor,0.05); % Jarque Bera Normality Test
    if P_incor(p,k) < .10 & skewnessVal_switch_Incor (p,k) > 0 % conditional checking for right skewness
            Skw_RtDataSwitch_AcceptIncorr (p,k) = {sw_chDt_Incor}';
            % subplotting Participant data based on skewness
            figure (k)
            sgtitle ({'Switching Pictorial',['Participant'  num2str(k)]})
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

       %% =============================================Linear Reg for the Assumption 2===================================================%%

% 
% sz = Ss_table.split_Ss{1,1};
% lin_x = [1;2;3;4;5;
%         6;7;8;9;10;
%         11;12;13;14;15;
%         16;17;18;19;20];
% lin_y = zeros(20,1);
% fq = zeros();
% for rr = 1:height(sz)
%     for ll = 1:20
%         fq (ll) = (sz(sz.session == ll ,{'rt'}));
%         bv = table2array(fq);
%         lin_y (ll) = mean(bv);
%     end
% end
% 
% figure
% plot(lin_x,lin_y,'b.')
% xlabel('session')
% ylabel('Mean RT')
% 
% X = [ones(length(lin_x),1) lin_x];
% [~,~,~,STATS] = regress(lin_y,X);
% 
% grid on
% hold on 
% xplot = [min(lin_x), max(lin_x)];
% yplot = B(1) + B(2)*xplot;
% plot (xplot,yplot,'r')
% legend('Measured', 'Model')
