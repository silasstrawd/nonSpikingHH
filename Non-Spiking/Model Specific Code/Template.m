clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;

% Make Modifications as Needed
% thisiClass.C(1) = 10;

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

plotNonSpiking(thisoClass)