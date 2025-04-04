function [] = plotNonSpiking(thisoClass)

t = thisoClass.t;
o = thisoClass.o;

figure("Color","w")
subplot(511)
    plot(t,o(:,1))
    hold on
    grid minor
    plot(t(thisoClass.peakStruct.group1.idx),o((thisoClass.peakStruct.group1.idx),1),'r*')
    ylabel("Pre-I")
subplot(512)
    plot(t,o(:,2))
    hold on
    grid minor
    plot(t(thisoClass.peakStruct.group2.idx),o((thisoClass.peakStruct.group2.idx),2),'r*')
    ylabel("Early-I")
subplot(513)
    plot(t,o(:,3))
    hold on
    grid minor
    plot(t(thisoClass.peakStruct.group3.idx),o((thisoClass.peakStruct.group3.idx),3),'r*')
    ylabel("Aug-E")
subplot(514)
    plot(t,o(:,4))
    hold on
    grid minor
    plot(t(thisoClass.peakStruct.group4.idx),o((thisoClass.peakStruct.group4.idx),4),'r*')
    ylabel("Post-I")
subplot(515)
    plot(t,o(:,5))
    hold on
    grid minor
    plot(t(thisoClass.peakStruct.group5.idx),o((thisoClass.peakStruct.group5.idx),5),'r*')
    ylabel("Post-I_{pBC}")
    xlabel("Time [s]")
subplot(511);title("Output Timeseris for Ausborn Model")


    