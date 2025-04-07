function [] = plotNonSpiking(thisoClass)

t = thisoClass.t;
o = thisoClass.o;
names = thisoClass.inputClassUsed.names;
model = thisoClass.inputClassUsed.model;

if strcmp(model,"Ausborn")
    figure("Color","w")
    subplot(511)
        plot(t,o(:,1))
        hold on
        grid minor
        plot(t(thisoClass.peakStruct.(names(1)).idx),o((thisoClass.peakStruct.(names(1)).idx),1),'r*')
        ylabel("Pre-I")
        ylim([0 1])
    subplot(512)
        plot(t,o(:,2))
        hold on
        grid minor
        plot(t(thisoClass.peakStruct.(names(2)).idx),o((thisoClass.peakStruct.(names(2)).idx),2),'r*')
        ylabel("Early-I")
        ylim([0 1])
    subplot(515)
        plot(t,o(:,3))
        hold on
        grid minor
        plot(t(thisoClass.peakStruct.(names(3)).idx),o((thisoClass.peakStruct.(names(3)).idx),3),'r*')
        ylabel("Aug-E")
        ylim([0 0.5])
        xlabel("Time [s]")
    subplot(514)
        plot(t,o(:,4))
        hold on
        grid minor
        plot(t(thisoClass.peakStruct.(names(4)).idx),o((thisoClass.peakStruct.(names(4)).idx),4),'r*')
        ylabel("Post-I")
        ylim([0 1])
    subplot(513)
        plot(t,o(:,5))
        hold on
        grid minor
        plot(t(thisoClass.peakStruct.(names(5)).idx),o((thisoClass.peakStruct.(names(5)).idx),5),'r*')
        ylabel("Post-I_{pBC}")
        ylim([0 1])
    subplot(511);title("Output Timeseries for Ausborn Model")
end

    