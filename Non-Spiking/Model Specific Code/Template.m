clear
clc
close all

% Initialize Input Class
thisiClass = Rubin;

% Make Modifications as Needed
% thisiClass.C(1) = 10;

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

plotNonSpiking(thisoClass)