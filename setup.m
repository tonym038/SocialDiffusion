function setup()
% function just to avoid variables from being added to global workspace

% add paths
s = pwd; 
addpath(s)
addpath([s(1:find(s == filesep, 1, 'last')) 'SimRunner']); % assuming SimRunner is located on one folder up
% addpath([s filesep 'Results'])
% addpath([s filesep 'SupportingFunctions'])

pause on; % enables pausing
format compact; format shortG; % formatting output in command window
dbstop if error; % enter debug mode when error arises
% dbstop if warning; % enter debug mode when warning arises
% dbclear if error; % return to normal setting

% 'none'; 'LaTeX': interpret only math envt, i.e. $$; 'TeX': always interpret
% when using sprintf, add extra \ so that one \ remains in string to be displayed
set(0, 'DefaultTextInterpreter', 'TeX') %
set(0, 'DefaultLegendInterpreter', 'TeX')
set(0, 'DefaultAxesTickLabelInterpreter', 'TeX')

set(0, 'DefaultAxesXGrid', 'on');
set(0, 'DefaultAxesYGrid', 'on');