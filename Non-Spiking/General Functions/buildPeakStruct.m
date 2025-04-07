function [peakStruct,o] = buildPeakStruct(NonSpikingoClass)

%% This function takes an Ausborn output class and finds the voltage/output peaks
%  to generate a peak struct that contains all relevant info

% Grab the voltages and time vector
v = NonSpikingoClass.v;
t = NonSpikingoClass.t;
thisiClass = NonSpikingoClass.inputClassUsed;
numNeurons = NonSpikingoClass.numNeurons;

% Loop through the rows of v and convert to output according to the params
% in the input class

o = zeros(length(v),numNeurons);
for ii = 1:numNeurons

    thisv = v(:,ii);

    thiso = voltageToOutput(thisv,thisiClass,ii);

    o(:,ii) = thiso;
    

end

% Generate peakStruct for each neural group
peakStruct = findNeuralPeaks(t,o,thisiClass);