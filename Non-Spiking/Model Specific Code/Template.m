clear
clc
close all

% Initialize Input Class
thisiClass = Rubin;

% Make Modifications as Needed
% thisiClass.dxInom = [0.3 0 0 0 0]';

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

% Complete Analysis on Output Class
plotNonSpiking(thisoClass)