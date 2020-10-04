%% Given Input Matrix 
A = [-1 0 3; 4.5 6 Inf];

A=rectify(A);
%% Given Input Matrix 
[X]=meshgrid(-5:.2:5,-5:.2:5);
cos_wave = cosine2D(X,2);

%% Given Input Matrix 
[X,Y]=meshgrid(-5:.2:5,-5:.2:5);
sig_x = 2;
sig_y = 1;

probability_density = gauss2D(2,1,X,Y);

%% Gabor Filter

%Creating the Gabor Filter by elementwise multiplying the cosine2D function
%input and gauss2D function input
gabor_filt = cos_wave.*probability_density;

%Plotting the Gabor Filter
figure
imagesc (gabor_filt)
title('Gabor Filter')
xlabel('x-axis')
ylabel('y-axis')

%Initializing the variables

%ii = 1:length(ms);
firing_rate(ii) = 0;

for ii = 1:length(ms)
    model_neuron_output = squeeze(ms(ii,:,:)).*gabor_filt;
    firing_rate(ii) = sum(model_neuron_output,'all');
end

%Plotting the Tuning Curve of the model_neuron_output
figure
plot(theta,firing_rate,'r')
title ('Firing Rate Tuning Curve')
xlabel('Theta')
ylabel('Firing Rate')
gabor_filt = cos_wave.*probability_density;
%Reshaping the the gabor_filt to 1D vector of 51*51 (so 2601x1)
reshaped_gabfilt = reshape(gabor_filter,2601,1);
reshaped_ms = reshape(ms,72,2601);

%Matrix Multiplication for calculating the model_neuron_response 
model_neuron_response = (reshaped_ms*reshaped_gabfilt)';

%Plotting the firing rate of the model_neuron which is calculate using the
%Matrix Multiplication Method
figure
plot (theta, model_neuron_response)
title ('Figure:5. Firing Rate Tuning Curve (Matrix Multiplication Method)')
xlabel('Theta')
ylabel('Firing Rate') 
