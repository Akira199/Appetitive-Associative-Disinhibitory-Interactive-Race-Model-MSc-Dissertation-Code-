%% Overview of Raw Data
load ('ALLDATAfixed2.mat') % load raw data
Summary_rawData = summary (ALLDATAfixed2); 
% rt_hist = histogram(ALLDATAfixed2.key_resp_2rt,1000); %Scales are not set properly (check)

% Data not included of Ss_29, 30, 31 and 32 (check paper-possibly the Ss
% with outlier RT vals)
% Ss_63 has 93 trials missing--only 483 trials in total

% Segregate the data participantwise retaining only relevant cols

% Relevant Cols
% participant = ALLDATAfixed2(1)
% key_resp_2corr = ALLDATAfixed2(2)
% key_resp_2rt = ALLDATAfixed2(3)
% pic = ALLDATAfixed2(4)
% signalcolour = ALLDATAfixed2(11)
% reward = ALLDATAfixed2(14)
% trailsthisN = ALLDATAfixed2(15)
% stime6 = ALLDATAfixed2(23)

jj = [1:4, 11,14,15,23];
kk = ALLDATAfixed2(1:32256, jj);

t = array2table(kk); 
num_trials = 576;
num_participants = 56;
grps = repelem((1:num_participants)',num_trials,1);
splitParticipant_data = splitapply(@(varargin) {[varargin{:}]}, t, grps);

%% Participantwise data segregation and plotting the histogram of the overall RT
%%%% (slightly inefficient code-- ask on forum to better it) %%%%

k = nan ();
for ii = 1:length(splitParticipant_data)
    k = splitParticipant_data{ii,1};
figure
histogram(k.key_resp_2rt,100)

title ('Primary Task Reaction Time of Participant') % how can we add the participant's number 
end

%%





