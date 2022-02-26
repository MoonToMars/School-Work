% ELEC-2250: Physical Electronics
% Summer 2020
% This program computes and plots the ELECTROSTATIC VARIABLES (xp, xn, W, V0,V, E)
% for an abrupt p-n Junction in thermal equilibrium, forward, and reverse bias cases
% It also provides an output of key computational parameters.
% It is assumed that the junction is at 300K.
% it is also assumed that there is no generation and recombination in theSCR.

%Initializatìon
clear all
close all
clc % clears the command window

%Constants
q=1.6e-19;
k=8.617e-5;
e0=8.854e-14; % Permittivity of free space

%Parameters
ni=1.5e10;
kT=0.0259;
KS=11.8; % Relative permittivity of Silicon

%Variables
NA=input ('Input the p-side doping, NA= ');
ND=input('Input the n-side doping, ND = ');
%Thermal equilibrium V=0;

%Contact potential
V0=kT*log(NA*ND/ni^2)
V=input('Bias voltage, V (Smaller than V0 for forward bias)= ');

%xn, xp, and W
X=(2*KS*e0)*(V0-V)/q;
xn=sqrt (X*NA/(ND*(NA+ND)));
xp=sqrt (X*ND/(NA*(NA+ND)));
W=xn+xp;

%p-side electrostatic variables
x=linspace(-xp,0);
Vp= (q*NA/(2*KS*e0))*(xp+x).^2; % Electric potential variation in the p side
Ep=-(q*NA/(KS*e0))*(xp+x); % Electric field variation in p-side

%n—side electrostatic variables
xx=linspace (0,xn);
Vn=q*ND/(KS*e0)*(xn*xx-xx.^2/2)+Vp(end);
En=-(q*ND/(KS*e0))*(xn-xx);
xxx=[xx,2*xn];
Vn=[Vn,Vn(100)];
subplot(2,1,1), plot(x,Vp,xxx,Vn);
grid on
annotation('textbox', [0.5, 0.2, 0.1, 0.1], 'String', "Emmanuel Mati 104418019")
xlabel('x(cm)'); ylabel('V(volts)');
hold on
subplot (2,1,2), plot(x, Ep, xx, En);
grid on
xlabel('x(cm)'); ylabel('E(volts/cm)');
hold on
%Print out numerical results
fprintf('\n\nCOMPUTATIONAL RESULTS\n')
NA, ND, V, V0, xn, xp, W, E0=En(1),
hold off