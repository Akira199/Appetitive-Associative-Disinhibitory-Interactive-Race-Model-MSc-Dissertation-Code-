function [vec_y] = lowpass_filter(vec_x,k)
% A low-filter pass function that takes as input a vector x (like lfp) 
% and an integer number k. The function should return a new 
% vector y in which element i is the average of the corresponding 
% i:i+k elements in x. For example, for k=5 the first element of y 
% should be the average of the first 5 elements of x; the second element 
% of y should be the average of elements 2,3,4,5, and 6; and so on.


vec_y = nan(); % pre-allocation (i.e., making space for storing the variable)
for ii = 1:length(vec_x)-k 
    vec_y (ii) = mean(vec_x(ii:ii+k));
end
end

% Line 11: essentially what we are doing here is that we are creating the 
% flexible index that can be used for the newly created vector y. This is
% always going to be a value lesser than the original size of the given
% input vector x because we are essentially clubing in k value of elements
% from the given input vector to calculate the mean and then storing that
% value

%Line 12: we are basically calculating the mean of the number of elements
% that our k value defines for the whole data set 


