
% 5

% the variable naming has to be better
a = lowpass_filter(lfp, 100);
b = lowpass_filter (lfp, 150);
c = lowpass_filter (lfp, 200);
d = lowpass_filter (lfp, 250);
e = lowpass_filter (lfp, 300);
f = lowpass_filter (lfp, 400);
hold 
%figure
xlabel ('Time')
ylabel ('Theta Oscilations')
plot (a, 'r') 
plot (b,'k' )
plot (c , 'g')
plot (d, 'm')
plot (e, 'b')
plot (f , 'c')
title ('Local Field Potential data')
%hold off 

% 6
% Ans:
