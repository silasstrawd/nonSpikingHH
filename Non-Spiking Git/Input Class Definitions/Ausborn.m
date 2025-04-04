classdef Ausborn

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
        C(5,1) = [20 20 20 20 20]'; % [pre-I early-I aug-E post-I post-IpBC]
        
        % Maximal Conductances [nS] -- setting these to 0 turns off a channel
        gNaP_max(5,1)  = [ 5    0    0    0    0]';   % [pre-I early-I aug-E post-I post-IpBC]
        gK_max(5,1)    = [ 5    0    0    0    0]';   % [pre-I early-I aug-E post-I post-IpBC]
        gAD_max(5,1)   = [ 0   10   10   10   10]';   % [pre-I early-I aug-E post-I post-IpBC]
        gL_max(5,1)    = [ 2.8  2.8  2.8  2.8  2.8]'; % [pre-I early-I aug-E post-I post-IpBC]
        gsynE_max(5,1) = [10   10   10   10   10]';   % [pre-I early-I aug-E post-I post-IpBC]
        gsynI_max(5,1) = [60   60   60   60   60]';   % [pre-I early-I aug-E post-I post-IpBC]
        gChR_max(5,1)  = [ 8    8    8    8    8]';   % [pre-I early-I aug-E post-I post-IpBC]
        
        % Reversal Potentials [mV] -- do these change if we define v as e - e_rest?
        ENa(5,1)   = [ 50  50  50  50  50]'; % [pre-I early-I aug-E post-I post-IpBC]
        EK(5,1)    = [-85 -85 -85 -85 -85]'; % [pre-I early-I aug-E post-I post-IpBC]
        EL(5,1)    = [-60 -60 -60 -60 -60]'; % [pre-I early-I aug-E post-I post-IpBC]
        EsynE(5,1) = [  0   0   0   0   0]'; % [pre-I early-I aug-E post-I post-IpBC]
        EsynI(5,1) = [-75 -75 -75 -75 -75]'; % [pre-I early-I aug-E post-I post-IpBC]
        EChR(5,1)  = [  0   0   0   0   0]'; % [pre-I early-I aug-E post-I post-IpBC]
        
        % Output Slope (for f(Vi)) [mV]
        kV(5,1) = [-8 -4 -4 -4 -4]'; % [pre-I early-I aug-E post-I post-IpBC]
        
        % Time Constants [ms]
        Tao_hNaPmax(5,1) = [2000    1    1    1   1]'; % [pre-I early-I aug-E post-I post-IpBC] (1 is a placeholder value)
        Tao_ADi(5,1)     = [   1 2000 1500 1000 500]'; % [pre-I early-I aug-E post-I post-IpBC] (1 is a placeholder value)
        
        % Adaptation Parameters [-]
        kAD(5,1) = [1 0.9 0.9 1.3 1.7]'; % pre-I (placeholder)

        % Voltage Dependent Sigmoid Parameters [mV]========================
        thetamNaP = -40;
        sigmamNaP =  -6;
        
        thetahNaP = -48;
        sigmahNaP =   6;

        thetamK   = -30;
        sigmamK   = -4;
        %==================================================================

        % Threshold Voltage [mV]===========================================
        vth = -60;
        %==================================================================

        %==================================================================

        % Connection Strengths=============================================
        Wnom = [0    0     -0.20  -0.20 -1.40
                0.5  0     -0.50  -0.10 -0.70
                0   -0.37   0     -0.39 -0.65
                0   -0.26  -0.10   0     0
                0   -0.27  -0.20   0     0   ];
        WE = zeros(5);
        WI = zeros(5);
        %==================================================================

        % Input Magnitudes=================================================
        dxEnom = [0.21 0.59 0.73 0.72 0.30]'; % Tonic Input (Excitatory)
        dxInom = [0    0    0    0    0   ]'; % Tonic Input (Inhibitory)
        %==================================================================

        % Laser Stimulation================================================
        stim = [0 0 0 0 0]';
        %==================================================================

        % Initial Conditions===============================================
        x0 = [-60+(5*rand(5,1));  % v
                     rand(5,1) ;  % hNaP
                     rand(5,1)]; % mAD
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
        names = ["pre-I" "early-I" "aug-E" "post-I" "post-IpBC"];
        %==================================================================

    end

    methods

        function thisoClass = Ausborn5NeuronSimulation(thisiClass)

            % Define Inhibitory and Excitatory Connection Strengths
            thisiClass.WE = zeros(5);
            thisiClass.WE(thisiClass.Wnom > 0) = thisiClass.Wnom(thisiClass.Wnom > 0);

            thisiClass.WI = zeros(5);
            thisiClass.WI(thisiClass.Wnom < 0) = abs(thisiClass.Wnom(thisiClass.Wnom < 0));

            % Convert Input Class time to seconds
            thisiClass.tMax     = thisiClass.tMax     * 1000;
            thisiClass.tStepOn  = thisiClass.tStepOn  * 1000;
            thisiClass.tStepOff = thisiClass.tStepOff * 1000;

            % Run ode solver using the input class and structure the results
            [t,x] = ode45(@(t,x) AusbornSim(t,x,thisiClass),[0 thisiClass.tMax],thisiClass.x0,thisiClass.options);

            % Do stuff with the t,x matrices depending on the flags from
            % the input class

            % Initialize Output Class
            thisoClass = AusbornOutputClass;

            % Pack on results
            thisoClass.t    = t;
            thisoClass.v    = x(:,1:5);
            thisoClass.hNaP = x(:,6:10);
            thisoClass.mAD  = x(:,11:15);
            thisoClass.inputClassUsed = thisiClass;
            thisoClass.peakStruct = buildPeakStruct(thisoClass);
            % thisoClass.o = AusbornVoltageToOutput(thisoClass.v,thisiClass.kV); % To be added later

        end

   end

end