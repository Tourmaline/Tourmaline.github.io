% KemiSim
% Kommandofil som simulerar kemiska reaktioner

% Sätt start- och sluttid för simuleringen
starttid = 0;
sluttid = 10;
tidsintervall = [starttid sluttid];

% Sätt parametrarna
global s q w;
%s = 1;
s = 77.27;
%q = 1;
q = 8.375e-6;
w = 0.1610;

% Sätt begynnelsevärden på koncentrationerna vid
% tidpunkten starttid
alfa = 30;
beta = 1;
gamma = 30;

y0 = [alfa;beta;gamma]; % placera i vektor y0. Obs ordningen 
                           % måste st�mma med ordningen i rov_bytesdjur


% Sätt olika v�rden som styr Matlabs odelösare. Observera att detta 
% ej nödvändigt utan används enbart då man vill ändra på standardvärden
% som är inbyggda i odelösarna (raden 'val=odeset' medför att inget ändras).
%val = odeset;
val = odeset('OutputFcn','odeplot','RelTol', 1e-2);


% Lös ode:n genom anrop av ode45. Parametern val kan uteslutas om man inte 
% vill ändra standardvärden i ode45.
[t, y] = ode45(@KemiODE, tidsintervall, y0, val);
%[t, y] = ode15s(@KemiODE, tidsintervall, y0, val);

% Rita upp lösningen
if isempty(val.OutputFcn)  % Plotta enbart om 'odeplot' inte är
  plot(t,y);               % satt i 'val' (då plottar ode45 automatiskt)
end  
  xlabel('tid')
  ylabel('Koncentrationer');
  title('Simulering av reaktion');
  legend('\alpha','\beta', '\gamma');