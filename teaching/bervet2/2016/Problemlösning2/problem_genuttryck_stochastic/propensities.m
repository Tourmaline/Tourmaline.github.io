function prop = propensities(x, p)
% Input: x - the current state
%        p - list of parameters 
%
% The current state variables (u) are ordered as:
%    mRNA protein
% The parameters (in p) are ordered as:
%   kR kP gR gP 

% Return reaction propensities given current state x
mRNA    = x(1);
protein = x(2);

kR = p(1);
kP = p(2);
gR = p(3);
gP = p(4);

prop = [kR;         %transcription
        kP*mRNA;       %translation
        gR*mRNA;       %mRNA decay
        gP*protein];   %protein decay
 
end