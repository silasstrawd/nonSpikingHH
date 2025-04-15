function [peakStruct,o] = buildPeakStruct(NonSpikingoClass)

%% This function takes a nonspiking output class (e.g. Ausborn) and finds:
% - output peaks
%   - assoc idx, o, and t values
%  to generate a peak struct that contains all relevant info

% Grab the voltages and time vector
v = NonSpikingoClass.v;
t = NonSpikingoClass.t;
thisiClass = NonSpikingoClass.inputClassUsed;
numNeurons = NonSpikingoClass.numNeurons;

% Convert voltage to output for each neuron (row) v is fat
o = zeros(length(v),numNeurons);
for ii = 1:numNeurons

    thisv = v(:,ii);
    thiso = voltageToOutput(thisv,thisiClass,ii);
    o(:,ii) = thiso;
    
end

% Generate peakStruct for each neural group
peakStruct = findNeuralPeaks(t,o,thisiClass);

% Calculate the integral under each burst (see OneNote for description)
% This code assumes that the bursts are periodic in steady state
% (i.e. peak to peak integration is the same as trough to trough
% for the same time interval)
% integ = integrateBurst(peakStruct);