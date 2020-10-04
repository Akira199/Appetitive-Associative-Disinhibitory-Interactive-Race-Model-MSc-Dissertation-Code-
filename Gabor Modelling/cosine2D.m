%% Cosine 2D Funtion

function [cos_wave] = cosine2D(x,k)
%The cosine2D function inputs include a constant scalar quantity k and the
%input x is a meshgrid 2D matrix. 
[cos_wave] = cos(k*x);

%Plotting the Cosine Wave
figure
imagesc(cos_wave)
title('2-Dimensional Cosine Wave')
xlabel('x-axis')
ylabel('y-axis')
end