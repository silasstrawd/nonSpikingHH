clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;
thisiClass.tMax = 30;

% Make Modifications as Needed
% thisiClass.dxEnom = [0 0.495]';
thisiClass.dxInom = [0 0]';

% Run Sims
[thisoClass] = solveNonSpiking(thisiClass);

% plotNonSpiking(thisoClass)
% set(gcf,"Position",[1921 397.6667 1280 599.3333])


% BF Stuff
t  = thisoClass.peakStruct.Ex.t(2:end);
BF = thisoClass.peakStruct.Ex.f;
% figure('Color','w')
plot(t,BF,'k^:')
title(sprintf('EX BF uI = %4.3f',thisoClass.inputClassUsed.dxInom(2)))
ylabel('Burst Frequency [Hz]')
xlabel('Time [s]')
yline(0.3422) % [Hz] nominal from Ausborn
grid minor