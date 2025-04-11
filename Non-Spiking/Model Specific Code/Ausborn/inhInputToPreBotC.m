% clear
clc
close all

% Initialize Input Class
thisiClass = Ausborn;

% List of inhibitory inputs to apply to pre-BotC neurons
% dxIList = 0;
% dxIList = linspace(0,0.08,15);  % BotC
dxIList = linspace(0,0.012,10); % all
% dxIList = linspace(0,0.020,10); % inh
% dxIList = linspace(0,0.150,10); % post-IpBC

% Weights of dxI from EES
preIw     = 1;
earlyIw   = 1;
postIpBCw = 0;
augEw     = 0;
postIw    = 0;

for ii = 1:length(dxIList)

    % Apply inhibitory input to pre-BotC neurons
    dxI = dxIList(ii);
    thisiClass.dxInom = [preIw*dxI earlyIw*dxI augEw*dxI postIw*dxI postIpBCw*dxI]';

    % Run Sims
    [thisoClass] = solveNonSpiking(thisiClass);

    % Grab the best BF
    BF(ii) = thisoClass.peakStruct.preI.f(end-1);

    % Plot BF Timeseries for a single realization
    BFts = thisoClass.peakStruct.preI.f;
    peakt = thisoClass.peakStruct.preI.t(2:end);

    figure('Color','w')
    plot(peakt,BFts,'^-','MarkerFaceColor',[0 0.7 0.2],'Color',[0 0.7 0.2])
    ylabel('Freqency [Hz]')
    title(["Respiratory Frequency Timeseries";sprintf("uI = %4.3f",dxI)])
    xlabel('Time [s]')
    grid minor

end

% Plot BF vs uI
figure('Color','w')
plot(dxIList,BF,'r^-','MarkerFaceColor','r')
grid minor
ylabel("Steady State Network Frequency [Hz]")
xlabel("Inhibitory Input Magnitude")
title("Inhibitory Input to all BOTC Neurons")
% title("Inhibitory Input to ALL pre-BotC Neurons")
% title("Inhibitory Input to INHIBITORY pre-BotC Neurons")
% title("Inhibitory Input to Post-I pre-BotC Neurons")
% ylim([0.25 0.5])

plotNonSpiking(thisoClass)




