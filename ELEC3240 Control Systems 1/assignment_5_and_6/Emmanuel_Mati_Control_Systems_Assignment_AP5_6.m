%%Author: Emmanuel Mati
%Control Systems 1
%Summer 2020
%Assignment 5&6

%Clear everything
close all;
clear all;
clc;

%our symbols
syms t s

%Our time domain
t= 0:0.01:20;
%function
Y = 0.51/( s^2 * (s + 0.51) + s*0.51)

%Taking inverse laplace
y = ilaplace(Y);
pretty(y)

y = subs(y);
figure
hold on
plot(t, y)
xlabel('Time (seconds)')
ylabel('y(t)')
title('Unit Step Input R(s)')

%function
Y = 0.51/( s^3 * (s + 0.51) + s^2*0.51)

%Taking inverse laplace
y = ilaplace(Y);
pretty(y)

y = subs(y);
figure
plot(t, y)
xlabel('Time (seconds)')
ylabel('y(t)')
title('Unit Ramp Input R(s)')
hold off