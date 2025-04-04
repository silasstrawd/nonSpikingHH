function [peakStruct] = findNeuralPeaks(t,o)

%% This function finds the peaks of a given output function [0 1)

assert(min(o,[],"all") >= 0,'This function is for output functions on [0 1) only.')

% Find top 5% largest values for each group
top5 = prctile(o,95); % Gives the 95 percentile value for each group

for ii = 1:length(top5)

    % Create the name for the struct where these will go
    thisGroup = sprintf("group%i",ii);

    % Grab the output vector that we're looking at
    thiso = o(:,ii);

    % Find the top 95 percentile values
    thisoidx = thiso > top5(ii);

    % Make a vector of only those values
    thisGrouptop = thiso(thisoidx);
    thisGrouptopt = t(thisoidx);

    % Find the peaks of the 95 percentile group
    thisGrouptopPeaks = findpeaks(thisGrouptop,thisGrouptopt,'MinPeakDistance',1);

    % Find these peak values - this is gross there's gotta be a better way
    % to do this
    idx = zeros(1,length(thisGrouptopPeaks));
    for jj = 1:length(thisGrouptopPeaks)
        idx(jj) = find(thiso == thisGrouptopPeaks(jj));
    end

    % Save the time and output values for the indices of the peaks you used
    peakStruct.(thisGroup).t = t(idx);
    peakStruct.(thisGroup).o = o(idx,ii);
    peakStruct.(thisGroup).idx = idx;

end
