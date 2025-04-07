classdef Rubin

% This is the class definition for the neurons in the Rubin/Rybak 2009 paper
% All values in this class definition are as defined in the paper, any
% modifications to these values need to be made outside of this function.

% The neurons in this model are layed out as follows:
% 1 -- pre-I
% 2 -- early-I
% 3 -- post-I
% 4 -- aug-E

properties

    % Neuron Parameters================================================
    % Capacitance [pF]
    C(4,1) = [20 20 20 20]'; % [pre-I early-I aug-E post-I post-IpBC]
    
    % Maximal Conductances [nS] -- setting these to 0 turns off a channel
    gNaP_max(4,1)  = [ 5    0    0    0  ]';   % [pre-I early-I aug-E post-I post-IpBC]
    gK_max(4,1)    = [ 5    0    0    0  ]';   % [pre-I early-I aug-E post-I post-IpBC]
    gAD_max(4,1)   = [ 0   10   10   10  ]';   % [pre-I early-I aug-E post-I post-IpBC]
    gL_max(4,1)    = [ 2.8  2.8  2.8  2.8]'; % [pre-I early-I aug-E post-I post-IpBC]
    gsynE_max(4,1) = [10   10   10   10  ]';   % [pre-I early-I aug-E post-I post-IpBC]
    gsynI_max(4,1) = [60   60   60   60  ]';   % [pre-I early-I aug-E post-I post-IpBC]
    gChR_max(4,1)  = [ 0    0    0    0  ]';
    
    % Reversal Potentials [mV] -- do these change if we define v as e - e_rest?
    ENa(4,1)   = [ 50  50  50  50]'; % [pre-I early-I aug-E post-I post-IpBC]
    EK(4,1)    = [-85 -85 -85 -85]'; % [pre-I early-I aug-E post-I post-IpBC]
    EL(4,1)    = [-60 -60 -60 -60]'; % [pre-I early-I aug-E post-I post-IpBC]
    EsynE(4,1) = [  0   0   0   0]'; % [pre-I early-I aug-E post-I post-IpBC]
    EsynI(4,1) = [-75 -75 -75 -75]'; % [pre-I early-I aug-E post-I post-IpBC]
    EChR(4,1)  = [  1   1   1   1]'; % 1 is a placeholder values since the Rubin model does not have a ChR channel
    
    % Output Slope (for f(Vi)) [mV]
    kV(4,1) = [-8 -4 -4 -4]'; % [pre-I early-I aug-E post-I post-IpBC]
    
    % Time Constants [ms]
    Tao_hNaPmax(4,1) = [6000    1    1    1]'; % [pre-I early-I aug-E post-I ] (1 is a placeholder value)
    Tao_ADi(4,1)     = [   1 2000 1000 2000]'; % [pre-I early-I aug-E post-I ] (1 is a placeholder value)
    
    % Adaptation Parameters [-]
    kAD(4,1) = [1 0.9 1.3 0.9]'; % [pre-I early-I aug-E post-I ] (1 is a placeholder value)
    %==================================================================

    % Voltage Dependent Sigmoid Parameters [mV]========================
    thetamNaP = -40;
    sigmamNaP =  -6;
    
    thetahNaP = -48;
    sigmahNaP =   6;

    thetamK   = -29;
    sigmamK   =  -4;
    %==================================================================

    % Threshold Voltage [mV]===========================================
    vth = -60;
    %==================================================================

    % Connection Strengths=============================================
    Wnom = [0    0     -0.30  -0.20
            0.4  0     -0.05  -0.35 
            0   -0.25   0     -0.10 
            0   -0.35  -0.35   0    ];
    WE = zeros(4);
    WI = zeros(4); 
    %==================================================================

    % Input Magnitudes=================================================
    dxEnom = [0.21 0.6 0.63 0.73]'; % Tonic Input (Excitatory)
    dxInom = [0    0   0    0   ]'; % Tonic Input (Inhibitory)
    %==================================================================

    % Laser Stimulation================================================
    stim = [0 0 0 0]';
    %==================================================================

    % Initial Conditions===============================================
    x0 = [-60+(5*rand(4,1));  % v
                 rand(4,1) ;  % hNaP
                 rand(4,1)]; % mAD
    %==================================================================

    % Time=============================================================
    tMax     = 30; % s
    tStepOn  = [];
    tStepOff = [];
    %==================================================================

    % Step Connection Strength=========================================
    Wstep = [];
    %==================================================================

    % Step Input Magnitude=============================================
    dxEstep = [];
    dxIstep = [];
    %==================================================================

    % odeOptions=======================================================
    options = odeset('RelTol',1e-6,'AbsTol',1e-9,'Refine',10);
    %==================================================================

    % Flags============================================================
    % saveVoltage = 0;
    % saveOutput  = 0;
    % saveParams  = 0;
    
    stepFlag = 0;
    %==================================================================

    % admin============================================================
    names = ["preI" "earlyI" "postI" "augE"];
    model = "Rubin";
    %==================================================================

end


end