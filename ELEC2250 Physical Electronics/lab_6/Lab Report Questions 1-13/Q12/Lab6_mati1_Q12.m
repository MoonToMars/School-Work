% ELEC-2250 S2020
% Lab Assignment 6
% Equilibrium p-n Junction Analysis
% Electrical and computer Engineering
% University of Windsor
clear all
close all
clc
%Constants
T= linspace(1, 500, 250); % Temperature in Kelvin
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

%we must recalculate the intrinsic carrier concentration as a function of
%temperature
ni = (2.887E6)*T.^(1.5).*exp((-EG/(2*k))*(1./T - 1/300));


%Computations
V0=k*T.*log((NA*ND)./ni.^2); % Contact potential
xN=sqrt(2*esi*e0/q*NA*V0/(ND*(NA+ND))); % Depletion width n-side
xP=sqrt(2*esi*e0/q*ND*V0/(NA*(NA+ND))); % Depletion width p-side
W=xN+xP; % Width of the depletion region
Emax=-q*NA*xP/(e0*esi); % Maximum electric field

%Plotting contact potential as a function of doping
figure
hold on
grid on
plot (T, V0)
title ('Variation of Contact Potential as a function of Temperature')
xlabel ('Temperature (Kelvin)')
ylabel('Contact Potential (ev)')
hold off