%%Author: Emmanuel Mati
%Control Systems 1
%Summer 2020
%Lab 1 RLC Circuit

%Clear everything
close all;
clear all;
clc;

%our symbols
syms t s

%Our time domain
t= 0:100:11000;

%Current functions
I1 = 1/(2*s^2 + 1000*s + 1/2); %One Capactior
I2 = 1/(2*s^2 + 1000*s + 1); % Two Capacitors

%Taking inverse laplace
i1 = ilaplace(I1);
i2 = ilaplace(I2);

%Plotting i(t) with one capacitor
ii1 = subs(i1);
figure
plot(t, ii1)
xlabel('t (seconds)')
ylabel('i(t) Amperes')
title('i(t) with one capacitor')

%Plotting i(t) with two capacitors
ii2 = subs(i2);
figure
plot(t, ii2)
xlabel('t (seconds)')
ylabel('i(t) Amperes')
title('i(t) with two capacitors')

%Displaying current functions
disp('The current equation I(s) in the s-domain with only one capacitor:')
pretty(I1);
disp('The current equation i(t) with only one capacitor:')%Displaying i(t)
pretty(i1);

%Displaying current functions
disp('The current equation I(s) in the s-domain with two capacitors:')
pretty(I2);
disp('The current equation i(t) with two capacitors:') %Displaying i(t)
pretty(i2);
