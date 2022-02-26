% ELEC-2250: Physical Electronics S2020
%Lab Assignment 9
%JFET I-V Characteristics
%Initialization
clear all
close all
clc

%Constants
q=1.6e-19;
k=8.625e-5;
e0=8.854e-14;

%Device, Material, and System Parameters
ni=1.5e10;
esi=11.8;
T=300;
a=1.5e-4;
z=50e-4;
L=5e-4;
ND=2e15;
VG=[0 -.5 -1 -1.5 -2];
%Contact Potential
V0=.55+k*T*log(ND/ni);

%mobility calculation
NDref=1.3e17;
mu_n_min=92;
mu_n_0=1268;
alpha_n=0.91;
mun=mu_n_min+mu_n_0./(1+(ND/NDref).^alpha_n)

%Resistivity
sigma=q*ND*mun;
rho=1/sigma;

%Mutual Transconductance
G0=2*a*z/(rho*L)

%Pinch-off voltage
VP=V0-q*a^2*ND/(2*e0*esi)

% Calculate ID as a function of VD
VD=linspace(0,abs(VP)+5,100);

str = 'Emmanuel Mati 104418019 mati1';
VD=linspace(0,abs(VP)+5,100); % Voltage vector re-generation for plotting
plot(VD,VP)
annotation('textbox',[.15 .8 .1 .1],'String',str);
hold on
xlabel ('VD (Volts)')
ylabel ('ID (Microampere)')
title('JFET I-V Characteristics')
grid
%Code ends