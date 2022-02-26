% ELEC-2250 S2020
% Lab Assignment 6
% Equilibrium p-n Junction Analysis
% Electrical and computer Engineering
% University of Windsor
clear all
close all
clc
%Constants
T=300; % Temperature in Kelvin
k=8.617e-5; % Boltzmann constant (eV/K)
e0=8.85e-14; % permittivity of free space (F/cm)
q=1.602e-19; % charge on an electron (coulomb)
esi=11.8; % Dielectric constant of Si at 300K
ni=1.5e10; % intrinsic carrier concentration. in Silicon at 300K (cm^-3)
EG=1.12; % Silicon band gap (eV)
%Control constants
xleft = -3.5e-4; % Leftmost x position
xright = -xleft; % Rightmost x position

NA=input ('Please enter p-side doping (cm^-3), NA = ');
ND=input ('Please enter n-side doping (cm^-3), ND = ');
NA
ND
%Computations
V0=k*T*log((NA*ND)/ni^2) % Contact potential
xN=sqrt(2*esi*e0/q*NA*V0/(ND*(NA+ND))) % Depletion width n-side
xP=sqrt(2*esi*e0/q*ND*V0/(NA*(NA+ND))) % Depletion width p-side
W=xN+xP % Width of the depletion region
Emax=-q*NA*xP/(e0*esi) % Maximum electric field
x = linspace(xleft, xright, 200);
% Potential (V) Distribution in Volts
% P-side
for i=1:1:length(x)
V_p(i)=q*NA/(2*e0*esi)*(x(i)+xP).^2;
if x(i)>0
 V_p(i)=0;
end
if x(i)<-xP
 V_p(i)=0;
end
end
%N-side
for i=1:1:length(x)
V_n(i)=(q*ND)/(e0*esi)*(xN*x(i)-(x(i).^2)/2)+q*NA/(2*e0*esi)*xP^2;
if x(i)<=0
 V_n(i)=0;
end
if x(i)>=xN
 V_n(i)=max(V_n);
end
end
V_pn=V_p+V_n; % V as a function of x
VMAX = 3; % Maximium Plot Voltage
EF=V_pn(1)+VMAX/2-k*T*log(NA/ni); % Fermi level

%Assignment task 4
xl = linspace(0, -xP, 200);
xr = linspace(0, xN, 200);

epsilonp = -q*NA*(xl+xP)/(esi*e0); %p-side
epsilonn = -q*ND*(xN-xr)/(esi*e0); %n-side

figure
hold on
%grid on
plot ( xl, epsilonp);
plot ( xr, epsilonn);
plot ([-xP-xN xP+xN], [0 0], 'k');
plot ([0 0], [-Emax*1.3 Emax*1.3], 'k');
title ('Electric Field Distribution Across P-N Junction')
xlabel ('Length x (cm)')
ylabel('Electric Field Epsilon (V/m)')
legend('p side','n side')
hold off