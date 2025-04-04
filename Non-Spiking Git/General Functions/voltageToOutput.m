function [fi] = voltageToOutput(v,thisiClass,ii)

%% This function maps a voltage signal to a sigmoidal output function defined on [0 1) according to threshold voltage (vth) and output slope (kV)

vth = thisiClass.vth;
kV  = thisiClass.kV(ii);

fi = zeros(length(v),1);

% Find voltage values above the threshold potential
idx = v >= vth;

% Apply the output function to those values
fi(idx) = 1./(1 + exp((v(idx) - (vth/2))/kV));


