function dx = nonSpikingSim(t,x,nonSpikingiClass) % This is the function to send to the ode45

    xtemp = reshape(x,[],3);
    
    % State Variables -- [v hNaP mAD]
    v    = xtemp(:,1);
    hNaP = xtemp(:,2);
    mAD  = xtemp(:,3);
    
    % Output Function Values Calc
    fi = zeros(length(v),1);
    
    vth = nonSpikingiClass.vth;

    idx = v >= vth; % typically around -60
    fi(idx) = 1./(1 + exp((v(idx) - (vth/2))./nonSpikingiClass.kV(idx)));
    
    % % Step On/Off
    % fns = string(fieldnames(thisiClass));
    % stepFlag = sum(contains(fns,"tstepA"));
    % 
    % if thisiClass.stepFlag
    %     if t < thisiClass.tstepOn*1000
    %         dxE = thisiClass.dxEStep;
    %     elseif thisiClass.tstepOn*1000 < t && t < thisiClass.tstepOff*1000
    %         dxE = thisiClass.dxEStep + thisiClass.uEvec.*thisiClass.uEstep; % Apply step input
    %     else
    %         dxE = thisiClass.dxE;
    %     end
    % else 
    %     dxE = thisiClass.dxE;
    % end
    % 
    
    dxE = nonSpikingiClass.dxEnom;
    dxI = nonSpikingiClass.dxInom;

    uxE = dxE + (nonSpikingiClass.WE*fi);
    uxI = dxI + (nonSpikingiClass.WI*fi);
    
    % pre-I Voltage Dependent Target Functions
    mNaP     = 1./(1 + exp((v(1) - nonSpikingiClass.thetamNaP)/nonSpikingiClass.sigmamNaP));
    mK       = 1./(1 + exp((v(1) - nonSpikingiClass.thetamK)  /nonSpikingiClass.sigmamK)); % this is where the typo was in the paper - activation sigmoids should have a negative sigma
    hNaP_inf = 1./(1 + exp((v(1) - nonSpikingiClass.thetahNaP)/nonSpikingiClass.sigmahNaP)); 
    Tao_hNaP = nonSpikingiClass.Tao_hNaPmax./cosh((v(1) - nonSpikingiClass.thetahNaP)/(2*nonSpikingiClass.sigmahNaP));
    
    % Channel Currents
    iNaP  = nonSpikingiClass.gNaP_max .*mNaP.*hNaP.*(v - nonSpikingiClass.ENa); % params.ENa will be a col vector
    iK    = nonSpikingiClass.gK_max   .*(mK.^4)   .*(v - nonSpikingiClass.EK);
    iAD   = nonSpikingiClass.gAD_max  .*mAD       .*(v - nonSpikingiClass.EK);
    iL    = nonSpikingiClass.gL_max               .*(v - nonSpikingiClass.EL);
    isynE = nonSpikingiClass.gsynE_max.*uxE       .*(v - nonSpikingiClass.EsynE);
    isynI = nonSpikingiClass.gsynI_max.*uxI       .*(v - nonSpikingiClass.EsynI);
    iChR  = nonSpikingiClass.gChR_max .*nonSpikingiClass.stim.*(v - nonSpikingiClass.EChR);
    
    % Differential Equations
    dv    = (-1./nonSpikingiClass.C).*(iNaP + iK + iAD + iL + isynE + isynI + iChR);
    dhNaP = (1./Tao_hNaP).*(hNaP_inf - hNaP);
    dmAD  = (1./nonSpikingiClass.Tao_ADi).*((nonSpikingiClass.kAD.*fi) - mAD);
    
    dx = [dv;dhNaP;dmAD];

end