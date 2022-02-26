%%Author: Emmanuel Mati
%Created: June 17, 2020
%This program finds the holes and poles of a transfer function

clear all; %Clears values stored from pervious calculations
close all; %Closes all open windows
clc; %Clears command window

%Numerator Values for polynomial(holes/zeros)
%Ex: [1 2 3 4] = s^4 + 2s^3 + 3s^2 + 4s
holes = [1];

%Denominator Values for polynomial(poles)
%Ex: [1 2 3 4] = s^4 + 2s^3 + 3s^2 + 4s
poles = [1 2 3 0];


%Our Transfer Function and its graph
TransferFunction=tf(holes, poles)
pzmap(TransferFunction)
grid on

%Separating the holes/zeros and poles of our transfer function
[p,z] = pzmap(TransferFunction);

%Displaying the holes/zeros
if isempty(p)
    fprintf('There are no poles\n')
else
    fprintf('Here are the poles: \n')
    disp(p)
end

%Displaying our poles
if isempty(z)
    fprintf('There are no holes/zeros\n')
else
    fprintf('Here are the holes/zeros: \n')
    disp(z)
end