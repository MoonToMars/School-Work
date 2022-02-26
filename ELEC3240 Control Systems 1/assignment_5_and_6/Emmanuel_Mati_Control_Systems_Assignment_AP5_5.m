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
t= 0:0.01:0.6;
alpha = 0;
%function
Y = (50*(s+2))/( s*(s+3)*(s+4) + 50*(s+alpha)*(s+2))

%Taking inverse laplace
y = ilaplace(Y);
pretty(y)

y = subs(y);
figure
hold on
plot(t, y)
xlabel('Time (seconds)')
ylabel('y(t)')
title('Unit Step Input Td(s)')

alpha = 10;
%function
Y = (50*(s+2))/( s*(s+3)*(s+4) + 50*(s+alpha)*(s+2))
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)

alpha = 100;
%function
Y = (50*(s+2))/( s*(s+3)*(s+4) + 50*(s+alpha)*(s+2))
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)
legend('alpha=1','alpha=10','alpha=100');
hold off
