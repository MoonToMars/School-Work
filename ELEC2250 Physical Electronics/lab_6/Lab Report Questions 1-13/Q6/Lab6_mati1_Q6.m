% ELEC-2250 S2020
% Lab Assignment 6
% Equilibrium p-n Junction Analysis
% Electrical and computer Engineering
% University of Windsor
clear all
close all
clc
%Constants
T=500; % Temperature in Kelvin
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
T
ni = ni*(T/300)^(3/2)*exp((-EG/(2*k))*(1/T - 1/300))


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

%Plot Diagrams
%Plot potential distribution
plot(x,V_pn,'r')
title ('Potential (V) Distribution')
xlabel ('Length in cm')
ylabel('Potential in Volts')
hold on
plot ( [xN xN], [ 0 max(V_pn)+.2 ], 'b--' ); %vertical marker, xN
plot ( [-xP -xP], [ 0 max(V_pn)+.2 ], 'g--' );%vertical marker, xP
plot ( [ 0 0 ], [ 0 max(V_pn)+.2 ], 'r--' ); %vertical marker, x=0
%axis off
text(xleft+.5e-4, 0.2,'p-side');
text ( 0, 0.2, 'x=0');
text(xright-.5e-4, 0.2,'n-side');
text(-xP, 0.2,'-Xp');
text ( xN, 0.2, 'xN');