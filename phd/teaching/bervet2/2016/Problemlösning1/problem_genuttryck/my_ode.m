function dy = my_ode(t, y)
% y = [M; P]

M = y(1);
P = y(2);

% try different parameters
kR = 0.01;   % transcription rate  
kP = 0.01;      % translation rate              
gR = 0.01;    % mRNP decay         
gP = 0.2;  % protein decay 

dy = [kR-gR*M;
     -gP*P+kP*M];
