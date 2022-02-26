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
t= 0:0.01:1.5;
k = 1;
%function
Y = (k*15)/(s*((s+5)*(s+7)+k*15))

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

k = 10;
%function
Y = (15*k)/(s*((s+5)*(s+7)+15*k));
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)

k = 100;
%function
Y = (15*k)/(s*((s+5)*(s+7)+15*k));
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)
legend('k=1','k=10','k=100');
hold off

%%ii
k = 1;
%function
Y = (15)/(s*((s+5)*(s+7)+k*15))

%Taking inverse laplace
y = ilaplace(Y)
pretty(y)

y = subs(y);
figure
hold on
plot(t, y)
xlabel('Time (seconds)')
ylabel('y(t)')
title('Unit Step Input Td(s)')

k = 10;
%function
Y = (15)/(s*((s+5)*(s+7)+15*k));
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)

k = 100;
%function
Y = (15)/(s*((s+5)*(s+7)+15*k));
%Taking inverse laplace
y = ilaplace(Y);
y = subs(y);
plot(t, y)
legend('k=1','k=10','k=100');
hold off