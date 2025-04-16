function [integralStruct] = integrateBurst(thisoClass)

%% This function calculates the integral under the output function for each neural group in the output class
%  **DISCLAIMER** This code assumes that the integral value under bursts
%  converge to a near constant value in steady state
%  I am integrating from peak to peak, and therefore not integrating
%  exactly one burst from "beginning" to "end"
%  See OneNote for more in depth description

% Initialize the things we need
names = thisoClass.inputClassUsed.names;
t     = thisoClass.t;
o     = thisoClass.o;

% For each neural group, integrate between the peaks
for ng = 1:length(names) % each neural group

    if ~isempty(thisoClass.peakStruct.(names(ng)).idx)
        idx   = thisoClass.peakStruct.(names(ng)).idx;
        ong = o(:,ng);
        
        for pk = 1:length(idx)-1 % each peak within a group
            
            thisInterval = idx(pk):idx(pk+1); % Grab the indices for the endpoints of the area we're integrating
            
            % LH Riemann Sum
            thisdt = diff(t(thisInterval));      % widths of each partition
            thiso  = ong(thisInterval(1:end-1)); % left-hand endpoints of each partition
    
            thisInt = sum(thisdt.*thiso);
    
            integralStruct.(names(ng)).outputBurstIntegral(pk) = thisInt;
            integralStruct.(names(ng)).burstIdx(pk)            = pk;
    
        end
    else % in case peaks cannot be found
        integralStruct.(names(ng)).outputBurstIntegral = [];
        integralStruct.(names(ng)).burstIdx            = [];
    end

end