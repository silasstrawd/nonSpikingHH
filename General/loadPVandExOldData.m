clear
clc
close all

%% This code is meant to recover the data that was processed in February to create the simpleNetwork plots
%  found in the results section of my OneNote

filePath = "C:\Users\silas\Documents\UCLA\Research\Simulations\SimData\cervicalCPG\PV and Ex\Config 6";
fileDir  = dir(fullfile(filePath,"*.mat"));

for ii = 1:length(fileDir)
    
    thisFile = fullfile(filePath,fileDir(ii).name);

    loadFile = load(thisFile);

end
