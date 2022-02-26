% ELEC-2250: Physical Electronics
%S2020
% MOSFET I-V Characteristics including the mobility degradation parameter Theta
%Lab Assignment 8
%initialization
close all
clear all
%Let VGT = VG-VT,
theta=0.85;
for VGT=4:-1:1,
%primary Computation
VD=linspace(0,VGT);
ID0=VGT.*VD-VD.*VD./2; % Drain current without the mobility degradation parameter
ID0sat=VGT.*VGT/2;
ID0=[ID0,ID0sat];
ID1=(VGT.*VD-VD.*VD./2)/(1+theta*VGT); %Drain current with mobility degradation parameter theta
ID1sat=(VGT.*VGT/2)/(1+theta*VGT);
ID1=[ID1,ID1sat];
VD=[VD,9];
%Plotting and labelling
if VGT==4
 plot(VD,ID0,'b',VD,ID1,'r')
 title('MOSFET I-V Characteristics Comparison')
 axis([0 10 0 10])
 xlabel ('VD(volts)')
 ylabel ('ID/(ZmuC/L)')
 text(8,ID0sat+0.2,'VG-VT=4V')
 text(4.5,ID0sat+0.2,'theta=0')
 text(4.5,ID1sat+0.2,strcat('theta=',num2str(theta)))
 hold on
else
 plot(VD,ID0,'b',VD,ID1,'r')
 if VGT==3
 text(8,ID0sat+0.2,'VG-VT=3V')
 elseif VGT==2
 text(8,ID0sat+0.2,'VG-VT=2V')
 else
 text(8,ID1sat+0.2,'VG-VT=1V')
end
end
end