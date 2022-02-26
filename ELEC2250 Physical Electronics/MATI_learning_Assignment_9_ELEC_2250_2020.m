% ELEC-2250: Physical Electronics S2020
%Learning Assignment 9
%Emmanuel Mati
%Initialization

clear all
close all
clc

V = [0.4 : 0.01: 10];

%Constants
q=1.6e-19;
k=1.38e-23;
ks = 0.072
T0 = 223;       %Temp at -50C
T1 = 373;       %Temp at 100C
Troom = 300;    %Room temp

Iroom = 1e-12     %our initial saturation current at room temp
I00 = Iroom*exp(ks * (T0 - Troom))
I01 = I00*exp(ks * (T1 - T0))

I0 = I00*(exp(V.*q/(k*T0)) - 1);
I1 = I01*(exp(V*q/(k*T1)) - 1);
Ir = Iroom*(exp(q*V./(k*Troom)) - 1);

figure
hold on
plot(V, I0)
plot(V, I1)
plot(V, Ir)
xlabel('Voltage V in Volts');
ylabel('Current I in Amps');
ylim([-1 5])
legend('-50C', '100C', 'Room Temperature')
hold off