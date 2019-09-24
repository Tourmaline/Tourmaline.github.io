function dy = EpidemiODE(t,y)
% dy = EpidemiODE(t, y);
% For a scalar t and a vector y, EpidemiODE(t, y) must return a column
% vector corresponding to y'(t) - requirement of Matlab

% y är en vektor med tre komponenter, y=[y1; y2; y3], 
% där y1 är S
% där y2 är I
% där y3 är R
% ( S = y(1), I = y(2), R = y(3) )

global N b d beta u v;

dy = zeros(3,1); % vektor med tre komponenter

% sätt komponenter
dy(1) = b*N - d*y(1) - beta/N*y(2)*y(1) - v*y(1);
dy(2) = beta/N*y(2)*y(1) - u*y(2) - d*y(2);
dy(3) = u*y(2) - d*y(3) + v*y(1);

end

