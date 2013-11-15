function addFSDA2path(FSDApath)
%% Add FSDA toolbox to path
%
%  Required input arguments:
%
%    FSDA:      A string containing the path which contains the root folder of FSDA toolbox
%
%
%    REMARK: Remember to save the added folders to path in the MATLAB window
%    set path, to be able to use FSDA in future sessions  
%
% Copyright 2008-2013.
% Written by Marco Riani, Domenico Perrotta, Francesca Torti
%
% Last modified 02-May-2013

% Examples:

%
%{
%      If FSDA has been installed in D:\matlab\FSDA 
%      in order to include the required subfolders of FSDA use the following sintax
 
       addFSDA2path('D:\matlab\FSDA')
%}

%% Beginning of code

addp=[FSDApath ';' FSDApath '\multivariate;'  FSDApath '\regression;',...
    FSDApath '\datasets\regression;' FSDApath '\datasets\multivariate;', ...
    FSDApath '\datasets\multivariate_regression;' FSDApath '\graphics;' FSDApath '\utilities;',...
    FSDApath '\examples;' FSDApath '\robust;' FSDApath '\combinatorial'];
path(addp,path);
end
