%% ==================================== Assumption 2: Run parametric test(Linear Regression) for checking relative speed errors ============================================%%%%%%
% Preparing data for Assumption 2 linear reg
% Segregate data based on set and then task type 
load('Final_RightSkew_repeatData_SwitchingPictorial.mat')
%% SET_2 and task_2: 
% Indexing out Set_2 Task_2 for Correct RT Data: 
SET_3 = Final_SwitchPicData_repeat(Final_SwitchPicData_repeat.set == 'sports_color',:);
task_1Set3 = SET_3(SET_3.task == 'sports',:);

%% Calculating meanRTs - correct RT's dataset:
idxSs = table();
idxRT = table();
meanRTCor_St3Task1 = cell(4,31);
for mm = 1:31
       idxSs = task_1Set3(task_1Set3.code == mm,:);
       for zz = 9:12 % this idx vals corresponds with the session idx
       idxRT = idxSs(idxSs.session == zz,{'rt'});
       rt = table2array(idxRT);
       calcMean = mean(rt);
       meanRTCor_St3Task1{zz,mm} = calcMean;
       end
end
%% Indexing out Incorrect RT Data - from task "fruit" set - 2:
repeatDataIncorr = trimRTrepeat_Incor(switchingpictorial);
SET_3Incorr = repeatDataIncorr(repeatDataIncorr.set == 'sports_color',:);
task_1Set3Incor = SET_3Incorr(SET_3Incorr.task == 'sports',:);

%% Calculating meanRTs - Incorrect RT's dataset:
idxSsIncor_St1Task1 = table();
idxRTIncor_St1Task1 = table();
meanRTIncor_St3Task1= cell(4,31);
for m = 1:31
       idxSsIncor_St1Task1 = task_1Set3Incor(task_1Set3Incor.code == m,:);
       for z = 9:12 % this idx vals corresponds with the session idx
       idxRTIncor_St1Task1= idxSsIncor_St1Task1(idxSsIncor_St1Task1.session == z,{'rt'});
       rtIncor = table2array(idxRTIncor_St1Task1);
       calcMeanIncorr = mean(rtIncor);
       meanRTIncor_St3Task1{z,m} = calcMeanIncorr;
       end
end

%% Convert all Incor MEAN RT values to NaN if the corresponding values for Cor MEAN RT is NaN:

meanRTCor_St3Task1 = cell2mat(meanRTCor_St3Task1);
meanRTIncor_St3Task1 = cell2mat(meanRTIncor_St3Task1);
for hh = 1:124 %the idx range has to be 4*31  
  if isnan(meanRTCor_St3Task1(hh))
     meanRTIncor_St3Task1(hh) = NaN;
  end 
end

%% Compile mean rt data from correct and incorrect set:
compile_MeanRts = [meanRTCor_St3Task1;meanRTIncor_St3Task1];
%compile_MeanRts = compile_MeanRts(~cellfun('isempty',compile_MeanRts));
%%  remove Ss 

% No Ss Removed based on RT Calculation
%  compile_MeanRts(:,29) = [];
%  compile_MeanRts(:,27) = [];
%  compile_MeanRts(:,20) = [];
%  compile_MeanRts(:,7) = [];
%  compile_MeanRts(:,6) = [];
%  compile_MeanRts(:,3) = [];

 Fin_MeanRt = compile_MeanRts(:);
 %% 
 %% Define the variables for the final dataset: 

SS_1 = repmat({1,1,1,1,1,1,1,1,...
               2,2,2,2,2,2,2,2,...
               3,3,3,3,3,3,3,3,...
               4,4,4,4,4,4,4,4,...
               5,5,5,5,5,5,5,5,...
               6,6,6,6,6,6,6,6,...
               7,7,7,7,7,7,7,7,...
               8,8,8,8,8,8,8,8,...
               9,9,9,9,9,9,9,9,...
               10,10,10,10,10,10,10,10,...
               11,11,11,11,11,11,11,11,...
               12,12,12,12,12,12,12,12,...
               13,13,13,13,13,13,13,13,...
               14,14,14,14,14,14,14,14,...
               15,15,15,15,15,15,15,15,...
               16,16,16,16,16,16,16,16,...
               17,17,17,17,17,17,17,17,...
               18,18,18,18,18,18,18,18,...
               19,19,19,19,19,19,19,19,...
               20,20,20,20,20,20,20,20,...
               21,21,21,21,21,21,21,21,...
               22,22,22,22,22,22,22,22,...
               23,23,23,23,23,23,23,23,...
               24,24,24,24,24,24,24,24,...
               25,25,25,25,25,25,25,25,...
               26,26,26,26,26,26,26,26,...
               27,27,27,27,27,27,27,27,...
               28,28,28,28,28,28,28,28,...
               29,29,29,29,29,29,29,29,...
               30,30,30,30,30,30,30,30,...
               31,31,31,31,31,31,31,31},1,1)';

code = cell2mat(SS_1);
 
sess = repmat({5,6,7,8,...
               5,6,7,8},1,31)';
session = cell2mat(sess);

resp = repmat({1,1,1,1,...
               2,2,2,2},1,31)'; 
response = cell2mat(resp);

%dumyResponse = dummyvar(response);
               
condition =  repmat({'switch','switch','switch','switch',...
                     'switch','switch','switch','switch'},1,31)';
 
set = repmat({'plane_number','plane_number','plane_number','plane_number',...
              'plane_number','plane_number','plane_number','plane_number'},1,31)';

task = repmat({'sports','sports','sports','sports',...
               'sports','sports','sports','sports',},1,31)';

stimuli = repmat({'pictorial','pictorial','pictorial','pictorial',...
                  'pictorial','pictorial','pictorial','pictorial',},1,31)';
              
MeanRT = Fin_MeanRt;

% Assemble the final dataset: 
Set3_task1_switchingPic = table(code,session,condition,set,task,stimuli,response,MeanRT,...
                          'VariableNames',{'code','session','condition','set',...
                          'task','stimuli','response','MeanRT'});

%% Linear Regression - speed errors check:

%Set-3: task-1:
%load ('switchingpictorial_RegData')
Set3_task1_switchingPic.Response = categorical(response);
model_5Set3Task1 = fitlm(Set3_task1_switchingPic,'MeanRT~session*Response')
model_5ANOVA_Set3Task1 = anova(model_5Set3Task1,'summary')

% Plotting the Residuals

figure (39)
sgtitle ({'Switching Pictorial','Set - Sports and Color','Task 1 - Number'})
subplot(2,4,1)
plotResiduals(model_5Set3Task1,'probability','Color','red')
subplot(2,4,2)
plotResiduals(model_5Set3Task1,'fitted','Color','green')
subplot(2,4,3)
plotResiduals(model_5Set3Task1,'lagged','Color','blue')
subplot(2,4,4)
plotResiduals(model_5Set3Task1,'caseorder')
subplot(2,4,5)
plotResiduals(model_5Set3Task1,'symmetry')
subplot(2,4,6)
%plotInteraction(model_1Set1Task1,'session','Response','predictions')
plotInteraction(model_5Set3Task1,'Response','session','predictions')
subplot(2,4,7)
plot(model_5Set3Task1)