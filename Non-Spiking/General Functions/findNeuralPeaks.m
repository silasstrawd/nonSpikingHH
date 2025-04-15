function [peakStruct] = findNeuralPeaks(t,o,thisiClass)

%% This function finds the peaks of a given output function [0 1)
assert(min(o,[],"all") >= 0,'This function is for output functions on [0 1) only.')

% Find top 5% values for each group
top5 = prctile(o,95); % Gives the 95 percentile value for each neural group (row)

for ii = 1:length(top5)

    % Create the name for the struct where these will go
    thisGroup = thisiClass.names(ii);

    % Grab the output vector that we're looking at
    thiso = o(:,ii);

    % Find the top 95 percentile values
    thisoidx = thiso > top5(ii);

    % Make a vector of only those values
    thisGrouptop = thiso(thisoidx);
    thisGrouptopt = t(thisoidx);

    % Find the peaks of the 95 percentile group
    try
        thisGrouptopPeaks = findpeaks(thisGrouptop,thisGrouptopt,'MinPeakDistance',1);

        % Find the inds of the peak values
        idx = zeros(1,length(thisGrouptopPeaks));
        for jj = 1:length(thisGrouptopPeaks)
            idx(jj) = find(thiso == thisGrouptopPeaks(jj));
        end

        tPeaks = t(idx);
        oPeaks = o(idx,ii);

        % Calculate burst frequency
        BF = 1./diff(tPeaks);
    
        % Save the time and output values for the indices of the peaks you used
        peakStruct.(thisGroup).t   = tPeaks;
        peakStruct.(thisGroup).o   = oPeaks;
        peakStruct.(thisGroup).idx = idx;
        peakStruct.(thisGroup).f   = BF;

    catch
        warning("Could not calculate neural peaks for %s",thisGroup)
        peakStruct.(thisGroup).t   = [];
        peakStruct.(thisGroup).o   = [];
        peakStruct.(thisGroup).idx = [];
        peakStruct.(thisGroup).f   = [];
    end

end
