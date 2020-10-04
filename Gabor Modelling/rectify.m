%Rectify Function:
function [inp_mat] = rectify(inp_mat)
%the inputs of this function is a matrix called inp_mat 
inp_mat(inp_mat < 0) = 0; %converts any value in the input matrix less than zero to zero
disp (inp_mat)%returns the same input_matrix but with the negative values converted to zero
end 
 