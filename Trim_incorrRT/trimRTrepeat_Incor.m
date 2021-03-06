function [repeatData,finData] = trimRTrepeat_Incor(data)
%%%%%%%%%============================================================%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%=======================PRE-PROCESSING function=============%%%%%%%%%%%%%%%%%%%
%   This function removes RT outliers
%   Function calling instructions:
%   load ('data')
%   [percent_dataRemoved,trimmedData] = rtOutlierTrim(data);
%%%%%%%%%============================================================%%%%%%%%%%%%%%%%%%%

IncorRt_data = data(data.response ==2 | 0,{'code','session','set','task','condition'...,
                                                    'response','rt','stimuli','category'});
qq = IncorRt_data(IncorRt_data.rt >= 250,{'code','session','set','task','condition'...,
                                           'response','rt','stimuli','category'});
                                                
%Median Absolute Deviation +/-2.5
meDian = median (qq.rt);
MAD = mad(qq.rt,1);
cutoff_1 = median(qq.rt) + 2.5*mad(qq.rt,1);
cutoff_2 = median(qq.rt) - 2.5*mad(qq.rt,1); 
finData =qq(qq.rt<cutoff_1 & qq.rt>cutoff_2,{'code','session','set','task','condition'...,
                                           'response','rt','stimuli','category'});
%condi = findgroups(condition_finData);
% Switch Condition data:
% switchData = finData(finData.condition == 'switch',{'code','session','set','task','condition'...,
%                                            'response','rt','stimuli','category'});
% Repeat Condition data:
repeatData = finData(finData.condition == 'repetition',{'code','session','set','task','condition'...,
                                           'response','rt','stimuli','category'});
end