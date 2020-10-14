%% PCA to isolate the key features of sample neural data

load('waveforms.mat')

figure (1)
subplot(231)
plot(waveforms')
title('Original Dataset')
xlim([1 21])
xlabel ('Time')
ylabel ('Voltage')

% PCA
C = cov(waveforms); % cal cov matrix
[V,D] = eig(C); % cal eigendecomposition

[d,ii] = sort(diag(D), 'descend');
idx = find((cumsum(d)/sum(d))>0.9,1);

V1o = V(:,ii(1:idx));
proj = waveforms*V1o;

subplot (232)
plot(proj(:,1),proj(:,2),'o');
title('Projected Data')
xlabel ('PC 1')
ylabel ('PC 2')

thresh1 = 0.5;
thresh2 = 0.5;

subplot(232)
line ([thresh1 thresh1],[-3 thresh2],'color', 'k')
line ([-3 3], [thresh2 thresh2],'color', 'k')

neuron = zeros(1,size(waveforms,1));
neuron(proj(:,2)>thresh2)= 3;
neuron(proj(:,2)<thresh2 & proj(:,1)<thresh2) = 1;
neuron(proj(:,2)<thresh2 & proj(:,1)>thresh2) = 2;

subplot(233)
hold on
plot(waveforms(neuron==1,:)','r')
plot(waveforms(neuron==2,:)','g')
plot(waveforms(neuron==3,:)','b')
xlim([1 21])
title('Clustered Data')
xlabel('Time')
ylabel('Voltage')

subplot(234)
plot(waveforms(neuron==1,:)','r')
xlim([1 21])
title('Neuron 1')
xlabel('Time')
ylabel('Voltage')

subplot(235)
plot(waveforms(neuron==2,:)','g')
xlim([1 21])
title('Neuron 2')
xlabel('Time')
ylabel('Voltage')

subplot(236)
plot(waveforms(neuron==3,:)','b')
xlim([1 21])
title('Neuron 3')
xlabel('Time')
ylabel('Voltage')




