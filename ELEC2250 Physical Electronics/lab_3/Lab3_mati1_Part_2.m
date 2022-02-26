%%Emmanuel Mati
% ELEC-2250 S2020
% Lab Assignment 3
% Fermi-Dirac Distribution function Simulation

%Clearing Results
close all;
clear all;
clc;

kB = 8.617e-5; % Boltzmann constant in eV/K
Ef = 0.25; % Arbitrary Fermi level in eV
E = -0.2:0.0005:1.4; % Energy levels

% Calculate f(E) at T=0 K as fTo
fTo = zeros(size(E));
for k=1:1:length(E)
 if E(k)<Ef
    fTo(k)=1;
 elseif E(k)==Ef
    fTo(k)=0.5;
 end
end

% Calculate f(E) at three different temperatures
T1 = input('Enter first temperature in Kelvin:'); % in K
T2 = input('Enter second temperature in Kelvin:');
T3 = input('Enter third temperature in Kelvin:');

fT1 = 1 ./ (1 + exp( (E-Ef*ones(size(E)))/(kB*T1) )); % Period is necessary for matrix division
fT2 = 1 ./ (1 + exp( (E-Ef*ones(size(E)))/(kB*T2) ));
fT3 = 1 ./ (1 + exp( (E-Ef*ones(size(E)))/(kB*T3) ));

%Calculating hole concentration
holesfT1 = 1- fT1;
holesfT2 = 1- fT2;
holesfT3 = 1- fT3;



figure
plot(E,fTo,'k');
grid on; 
hold on;
plot(E,fT1,'b')
plot(E,fT2,'r')
plot(E,fT3,'m')

%adding our hole plots
plot(E,holesfT1,'g:')
plot(E,holesfT2,'c--')
plot(E,holesfT3,'-.')

xlabel('Energy Level, E (eV)');
ylabel('Fermi-Dirac Distribution Function, f(E)');
title('Fermi-Dirac Distribution Functions at Different Temperatures')
temp0=strcat(num2str(0),'K') % convert number to string and string concatenation
temp1=strcat(num2str(T1),'K') % type help strcat in Matlab command window for description of the functions num2str and strcat
temp2=strcat(num2str(T2),'K')
temp3=strcat(num2str(T3),'K')

%Our legend values for holes
temp4=strcat(num2str(T1),'K')
temp5=strcat(num2str(T2),'K')
temp6=strcat(num2str(T3),'K')

lgd = legend(temp0, temp1, temp2, temp3, temp4, temp5, temp6, 'Location', 'East');

%3D Visualization
figure

%Adding inverse 3-D plot
y6=holesfT3(:)*holesfT3(:)';
y5=holesfT2(:)*holesfT3(:)';
y4=holesfT1(:)*holesfT1(:)';

y3=fT3(:)*fT3(:)'; % Create 2D matrix of the fT1 data
y2=fT2(:)*fT2(:)'; % Create 2D matrix of the fT2 data
y1=fT1(:)*fT1(:)'; % Create 2D matrix of the fT3 data
mesh(E,E,y1) % Plot 3D fT1 data
hold on %hold the figure window for next plot
mesh(E,E,y2) % Plot 3D fT2 data
mesh(E,E,y3) % Plot 3D fT3 data
mesh(E,E,y4) % Plot 3D fT2 data
mesh(E,E,y5) % Plot 3D fT3 data
mesh(E,E,y6) % Plot 3D fT2 data
xlabel('Energy Level, E (eV)');
ylabel('Energy Level, E (eV)');
zlabel('Fermi-Dirac Function, f(E)');
%Code ends 