function [thisoClass] = solveNonSpiking(nonSpikingiClass)

%% This function takes an Ausborn input class, solves the ode, then returns an output class for further processing

% Assign excitatory and inhibitory connection strengths
nonSpikingiClass.WE(nonSpikingiClass.Wnom > 0) = nonSpikingiClass.Wnom(nonSpikingiClass.Wnom > 0);
nonSpikingiClass.WI(nonSpikingiClass.Wnom < 0) = abs(nonSpikingiClass.Wnom(nonSpikingiClass.Wnom < 0));

% ode stuff
tspan = [0 nonSpikingiClass.tMax*1000];
x0 = nonSpikingiClass.x0;
options = nonSpikingiClass.options;

% Solve ode
[t,x] = ode45(@(t,x) nonSpikingSim(t,x,nonSpikingiClass),tspan,x0,options);

% Attach to Output Class
thisoClass = NonSpikingOutputClass;

% Time
thisoClass.t = t/1000; % Convert to s

% ode solutions
numSolns = width(x);
numNeurons = numSolns/3;
assert(mod(width(x),3) == 0,"This function is for solving NonSpiking models, but somehow you got here with a different model"); % x must have a multiple of 3 soln's - v, hNaP, mAD

% indices
vidx = 1:numNeurons;
hNaPidx = vidx + numNeurons;
mADidx = hNaPidx + numNeurons;

thisoClass.v = x(:,vidx);
thisoClass.hNaP = x(:,hNaPidx);
thisoClass.mAD = x(:,mADidx);
thisoClass.inputClassUsed = nonSpikingiClass;
thisoClass.numNeurons = numNeurons;

% Create and save peakStruct and output vectors
[peakStruct,o] = buildPeakStruct(thisoClass);
thisoClass.o = o;
thisoClass.peakStruct = peakStruct;



