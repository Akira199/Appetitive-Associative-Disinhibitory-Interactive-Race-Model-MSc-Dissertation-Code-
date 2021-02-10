
%% =========================================Assumption 1: Skewness Test and Plotting -- Correct RT Data==============================================%%
% Initialisations of the variables before running the loops
switchData_tbl = cell2table(switchDataCor);
Skw_RtDataSwitch_Accept = cell(20,31);
Skw_RtDataSwitch_Reject = cell(20,31);
Skw_RtDataSwitch_Acc_RTs = cell(20,31);
Skw_RtDataSwitch_Rej_RTs = cell(20,31);
skewnessVal_switch = zeros(20,31);
hyp_Swcorr = zeros(20,31);
P = zeros(20,31);
H_corr = zeros(20,31);
%switchPicRgT_SKEWData = cell(31,1);
idxEmptySwitchPic = cell(20, 31);
store_size = nan(20,31); 

% ==================================================================== %

for kk = 1:height(switchData_tbl)
     idxSwtch = switchData_tbl.switchDataCor{kk,1};
     for pp = 1:20
     sessIdx_sw = idxSwtch(idxSwtch.session == pp,:);
     Idx_sw = idxSwtch(idxSwtch.session == pp,{'rt'});
     sw_chDt = table2array(Idx_sw);
     skewnessVal_switch (pp,kk)= skewness(sw_chDt); % Skewness Calculation 
     [H,P(pp,kk)] = JBtest(sw_chDt,0.05); % Jarque Bera Normality Test
     if P(pp,kk) < .10 & skewnessVal_switch (pp,kk) > 0 % conditional checking for right skewness
              
              Skw_RtDataSwitch_Accept (pp,kk) = {sessIdx_sw}';
              Skw_RtDataSwitch_Acc_RTs (pp,kk) = {sw_chDt}';
             % subplotting Participant data based on skewness
             figure (kk)
             sgtitle ({'Switching Pictorial Condition: Switch',...
                       ['Participant'  num2str(kk)]})
             subplot(5,4,pp)
             histogram(sw_chDt,35,'Facecolor','g')
             title(['Session' num2str(pp)])
             xlabel('RT')
    else 
             Skw_RtDataSwitch_Reject(pp,kk)= {sessIdx_sw}';
             Skw_RtDataSwitch_Rej_RTs (pp,kk) = {sw_chDt}';
             
             % subplotting Participant data based on skewness
             figure (kk)
             sgtitle ({'Switching Pictorial Condition: Switch',...
                        ['Participant'  num2str(kk)]})
             subplot(5,4,pp)
             histogram(sw_chDt,35,'Facecolor','r')
             title(['Session' num2str(pp)])
             xlabel('RT') 
     end
             idxEmptySwitchPic{pp,kk} = isempty(Skw_RtDataSwitch_Accept{pp,kk});
     end
     % This line brings togather all the data (no eliminations) i.e., all Ss
     % with right skewness test are compiled here:
      Final_SwitchPicData_switching = cat(1,Skw_RtDataSwitch_Accept{:});
end
%% Final Dataset for the Assumption 2 testing:

mtrx_idxEmptySwitchPic = cell2mat(idxEmptySwitchPic);          
idx_threshold = nan(20,31);
idx_keep = cell(31,1);
idx_remove = cell(31,1);

% Index out the participants with 10 or more sessions qualified the Right
% Skewness Test (Arbitrary Threshold set)

for kk = 1:31
   for pp = 1:20
     idx_threshold  = find(mtrx_idxEmptySwitchPic(:,kk) == 0);
        store_size = size(idx_threshold);
        idx_size = store_size(1);
           if  idx_size >= 10 
           idx_keep{kk,1} = idx_threshold;
           else
           idx_remove {kk,1} = idx_threshold;
           end 
   end
end

% Final Data Set:
for Ss_idxDel = [3,6,7,27,29]
    Ss_del = Final_SwitchPicData_switching.code == Ss_idxDel;
    Final_SwitchPicData_switching(Ss_del,:) = [];
end
    


