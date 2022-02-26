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
ND=[0: 1000: 2e6];
VG=[0 -.5 -1 -1.5 -2];
%Contact Potential
V0=.55+k*T*log(ND./ni);

%mobility calculation
NDref=1.3e17;
mu_n_min=92;
mu_n_0=1268;
alpha_n=0.91;
mun=mu_n_min+mu_n_0./(1+(ND./NDref).^alpha_n)

%Resistivity
sigma=q*ND.*mun;
rho=1./sigma;


%Mutual Transconductance
G0=2*a*z./(rho*L) 

%Pinch-off voltage
VP=V0-q*a^2*ND./(2*e0*esi)

hold on
plot (ND, VP);
xlabel ('ND(1/cm^3)')
ylabel ('VP')
title('VP as a function of ND')
grid
%Code ends