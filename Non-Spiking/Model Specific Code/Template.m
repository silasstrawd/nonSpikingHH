clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;

% Make Modifications as Needed
thisiClass.kV(2) = -6;

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

plotNonSpiking(thisoClass)