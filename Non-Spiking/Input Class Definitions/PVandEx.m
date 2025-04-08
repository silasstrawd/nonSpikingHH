classdef PVandEx

% This is the class definition for the neurons in the Ausborn 2018 paper
% All values in this class definition are as defined in the paper, any
% modifications to these values need to be made outside of this function.

% The neurons in this model are layed out as follows:
% 1 -- pre-I
% 2 -- early-I
% 3 -- aug-E
% 4 -- post-I
% 5 -- post-I preBotC

    properties
    % Neuron Parameters================================================
    % Capacitance [pF]
    C(2,1) = [20 20]'; % [pre-I early-I]
    
    % Maximal Conductances [nS] -- setting these to 0 turns off a channel
    gNaP_max(2,1)  = [ 5    0  ]';   % [pre-I early-I]
    gK_max(2,1)    = [ 5    0  ]';   % [pre-I early-I]
    gAD_max(2,1)   = [ 0   10  ]';   % [pre-I early-I]
    gL_max(2,1)    = [ 2.8  2.8]';   % [pre-I early-I]
    gsynE_max(2,1) = [10   10  ]';   % [pre-I early-I]
    gsynI_max(2,1) = [60   60  ]';   % [pre-I early-I]
    gChR_max(2,1)  = [ 8    8  ]';   % [pre-I early-I]
    
    % Reversal Potentials [mV] -- do these change if we define v as e - e_rest?
    ENa(2,1)   = [ 50  50]'; % [pre-I early-I]
    EK(2,1)    = [-85 -85]'; % [pre-I early-I]
    EL(2,1)    = [-60 -60]'; % [pre-I early-I]
    EsynE(2,1) = [  0   0]'; % [pre-I early-I]
    EsynI(2,1) = [-75 -75]'; % [pre-I early-I]
    EChR(2,1)  = [  0   0]'; % [pre-I early-I]
    
    % Output Slope (for f(Vi)) [mV]
    kV(2,1) = [-8 -4]'; % [pre-I early-I]
    
    % Time Constants [ms]
    Tao_hNaPmax(2,1) = [2000    1]'; % [pre-I early-I] (1 is a placeholder value)
    Tao_ADi(2,1)     = [   1 2000]'; % [pre-I early-I] (1 is a placeholder value)

    
    % Adaptation Parameters [-]
    kAD(2,1) = [1 0.9]'; % pre-I (placeholder)

    % Voltage Dependent Sigmoid Parameters [mV]========================
    % These are the same as Ausborn
    thetamNaP = -40;
    sigmamNaP =  -6;
    
    thetahNaP = -48;
    sigmahNaP =   6;

    thetamK   = -30;
    sigmamK   =  -4;
    %==================================================================

    % Threshold Voltage [mV]===========================================
    vth = -60;
    %==================================================================

    % Connection Strengths=============================================
    Wnom = [0  -0.05
            0.5 0];
    WE = zeros(2);
    WI = zeros(2);
    %==================================================================

    % Input Magnitudes=================================================
    dxEnom = [0 0.495]'; % Tonic Input (Excitatory)
    dxInom = [0 0]'; % Tonic Input (Inhibitory)
    %==================================================================

    % Laser Stimulation================================================
    stim = [0 0]';
    %==================================================================

    % Initial Conditions===============================================
    x0 = [-60+(5*rand(2,1));  % v
                 rand(2,1) ;  % hNaP
                 rand(2,1)]; % mAD
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
    names = ["Ex" "PV"];
    model = "Ex and PV";
    %==================================================================

    end

  
end