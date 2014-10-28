function psiHYP = HYPpsi(u, cktuning)
%HYPpsi computes psi function for hyperbolic tangent estimator
%
%<a href="matlab: docsearchFS('hyppsi')">Link to the help function</a>
%
%  Required input arguments:
%
%    u:         n x 1 vector containing residuals or Mahalanobis distances
%               for the n units of the sample
%    cktuning :  vector of length 2 or of length 5 which specifies the value of the tuning
%                constant c (scalar greater than 0 which controls the
%                robustness/efficiency of the estimator)
%                and the prefixed value k (sup of the
%                change-of-variance sensitivity) and the values of
%                parameters A, B and d
%                cktuning(1) = c
%                cktuning(2) = k = supCVC(psi,x) x \in R
%                cktuning(3)=A;
%                cktuning(4)=B;
%                cktuning(5)=d;
%                Remark: if length(cktuning)==2 values of A, B and d will be
%                computed automatically
%
%
%  Output:
%
%
%   psiHYP :     n x 1 vector which contains the values of hyperbolic psi
%                function associated to the residuals or Mahalanobis
%                distances for the n units of the sample
%
% Remark: function HYPpsi transforms vector u as follows
%
% HYPpsi(u) = 	{ u,			                               |u| <= d,
%               {
%		        { \sqrt(A * (k - 1)) * tanh(sqrt((k - 1) * B^2/A)*(c -|u|)/2) .* sign(u)
%		        { 	                 d <= |u| <  c,
%               {
%		        { 0,			                         |u| >= c.
%
%	It is necessary to have 0 < A < B < 2 *normcdf(c)-1- 2*c*normpdf(c) <1
%
%
%
%
% References:
%
%
% Frank R. Hampel, Peter J. Rousseeuw and Elvezio Ronchetti (1981),
% The Change-of-Variance Curve and Optimal Redescending M-Estimators,
% Journal of the American Statistical Association , Vol. 76, No. 375,
% pp. 643-648 (HRR)
%
% Copyright 2008-2014.
% Written by FSDA team
%
%
%<a href="matlab: docsearchFS('hyppsi')">Link to the help page for this function</a>
% Last modified 08-Dec-2013
%
% Examples:

%{

    % Obtain Figure 2 of  p. 375 of HRR
    %
    x=-9:0.1:9;
    ctuning=6;
    ktuning=4.5;
    psiHYP=HYPpsi(x,[ctuning,ktuning]);
    plot(x,psiHYP)
    xlabel('x','Interpreter','Latex')
    ylabel(' Hyperbolic $\psi(x) $','Interpreter','Latex')

%}

%{
    % Parameters associated to a value of bdp=0.5
    c=2.158325031399727
    k=4;
    A=0.000162707412432;
    B=0.006991738279441   
    d=0.016982948780061
    x=-8:0.001:8;
    psiHYP=HYPpsi(x,[c,k,A,B,d]);
    plot(x,psiHYP)
    xlabel('x','Interpreter','Latex')
    ylabel(' Hyperbolic $\psi(x) $','Interpreter','Latex')

%}

%% Beginning of code

c = cktuning(1);
k = cktuning(2);
if length(cktuning)>2

        A=cktuning(3);
        B=cktuning(4);
        d=cktuning(5);

    if ((A < 0) || (B < A) || (B>1)),
        error([' Illegal choice of parameters in hyperbolic tangent estimator: ' ...
            num2str(param) ]')
    else   
    end
    
else
    % Find parameters A, B and d using routine HYPck
    [A,B,d]=HYPck(c,k);
    
    % For example if c=4 and k=5
    %     A = 0.857044;
    %     B = 0.911135;
    %     d =1.803134;
    % see Table 2 of HRR
end


psiHYP = zeros(size(u));
absu=abs(u);

%  u,		   |u| <=d
psiHYP(absu<=d) = u(absu<=d);


%                d <= |u| < c,
% \sqrt(A * (k - 1)) * tanh(sqrt((k - 1) * B^2/A)*(c -|u|)/2) .* sign(u)
psiHYP(absu > d & absu <=c) = sqrt(A * (k - 1)) * tanh(sqrt((k - 1) * B^2/A)...
    *(c - absu(absu > d & absu <=c ))/2) .* sign(u(absu > d & absu <=c));

% 0,			              |u| >= c.

end
