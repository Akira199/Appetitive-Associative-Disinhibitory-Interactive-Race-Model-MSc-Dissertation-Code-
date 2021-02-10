              %% ====================================PRE-PROCESSING CODE===================================== %%
% Functions: 
% switchpic_SwitchConditionFunc --> Switch Condition
% switchpic_RepeatConditionFunc --> Repeat Condition

% Key Outputs:

% 1.) The Separated Ss data
% 2.) Outlier Trimmed Data set for Correct and 
% Incorrect Switch Condition RT Data
% 3.) Subplot visualisation of All Sessions - for Correct Data
% 4.) Final Right Skewness Tested Data - for Correct Data (after trimming
% out the sessions that don't pass the skewness test and after trimming teh
% Ss who do not have 10 or <10 sessions qualified in the skewness test).
% 5.) Regression and ANOVA Models -- a.) Checking Speed Errors and b.) Checking 
% Starting Point Bias for every task type in each of the set type. 
% 6.) Sub-plot visualisations of Residuals and Linear Regression models        
                      
%% Load data and separating the Ss_data
load('switchingpictorial')
data = switchingpictorial;
%% Switch Condition: 

% We run the custom made function created to run all the three
% misspecification (and does all the required data trimming on the 
% entire Switch Condition of the Switching Pictorial dataset: 

[Ss_table,Trimmed_switchDataCor,...
Trimmed_switchDataIncorr,...
SkewnessTested_SwitchPicData_switching,...
Set1_task1_switchingPic,...
model_1Set1Task1_SpeedError,....
model_1ANOVA_Set1Task1_SpeedError,...
model_1Set1Task1_StartingPointBias,...
model_1ANOVA_Set1Task1_StartingPointBias] = switchpic_SwitchConditionFunc(data);
     
%% Repeat Condition:

% We run the custom made function created to run all the three
% misspecification (and does all the required data trimming on the 
% entire Repeat Condition of the Switching Pictorial dataset:


