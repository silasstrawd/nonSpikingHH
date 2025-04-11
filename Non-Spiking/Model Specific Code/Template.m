clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;

% Make Modifications as Needed
% thisiClass.dxInom = [0.3 0 0 0 0]';

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

plotNonSpiking(thisoClass)