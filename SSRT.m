%% Calculating Stop Signal Reaction Time - SSRT

% Integration Method
% 1. rank order NSS RTs
% 2. mulitply the p(noncan) by total number of NSS trials to get
%    index 
% 3. find ranked ordered NSS at index above and subtract SSD
%===========================================================================%

%======================================================================
% rank NSS distribution
%======================================================================
if ~isempty(NSSDist)
    meanNSS = nanmean(NSSDist);
    stdNSS = nanstd(NSSDist);
    NNSS = length(find(~isnan(NSSDist)));
else
    meanNSS = NaN;
    stdNSS = NaN;
    NNSS = NaN;
end

% rank and get rid of NaNs in RT dist
rankedNSS_RT = sort(NSSDist);
rankedNSS_RT = rankedNSS_RT(find(~isnan(rankedNSS_RT));


% SSRT Calc

SSRT_intMeth = nan();
indSSRT = nan();
for x = 1:1:length(SSDall)
    indSSRT(x) = round(inhib_func(x)*NSS); % NNSS -- ranked No stop signal 
    if (isnan(indSSRT(x)) == 0) && (indSSRT(x) ~=0)
         SSRT_intMeth(x) = rankedNSS_RT(indSSRT(x)) - SSDall(x);
    else
          SSRT_intMeth(x) = NaN;
    end
end
meanIntSSRT = nanmean(SSRT_intMeth);

