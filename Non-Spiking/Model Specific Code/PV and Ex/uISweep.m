clear
clc
close all

% Initialize Input Class
thisiClass = PVandEx;

uIList = linspace(0,0.1,10);

uIwaitbar = waitbar(0,'Processing Inhibitory Inputs...');

for ii = 1:length(uIList)

    thisiClass.dxInom = [0 uIList(ii)]';

    % Run Sims
    [thisoClass] = solveNonSpiking(thisiClass);

    % Grab the best BF
    BF(ii) = thisoClass.peakStruct.Ex.f(end-1);

    % Plot BF Timeseries for a single realization
    BFts = thisoClass.peakStruct.Ex.f;
    peakt = thisoClass.peakStruct.Ex.t(2:end);

    % figure('Color','w')
    % plot(peakt,BFts,'^-','MarkerFaceColor',[0 0.7 0.2],'Color',[0 0.7 0.2])
    % ylabel('Freqency [Hz]')
    % title(["Respiratory Frequency Timeseries";sprintf("uI = %4.3f",uIList(ii))])
    % xlabel('Time [s]')
    % grid minor

    waitbar(ii/length(uIList),uIwaitbar,sprintf('Processing Inhibitory Inputs...%i %%',floor(ii*100/length(uIList))));

end

close(uIwaitbar)

plotNonSpiking(thisoClass)

% Plot BF vs uI
figure('Color','w')
plot(uIList,BF,'b^-','MarkerFaceColor','b')
grid minor
ylabel("Steady State Network Frequency [Hz]")
xlabel("Inhibitory Input Magnitude")
title("Inhibitory Input to PV Neurons")
yline(0.3422,"Label","Nominal (Ausborn 2018)") % [Hz] nominal from Ausborn
