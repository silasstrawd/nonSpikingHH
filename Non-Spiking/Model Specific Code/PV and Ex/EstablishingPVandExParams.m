clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;
thisiClass.tMax = 50;

% Make Modifications as Needed
thisiClass.dxEnom = [0 0]';
thisiClass.Wnom = [0  -0.5
                   0.1 0  ];

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

plotNonSpiking(thisoClass)