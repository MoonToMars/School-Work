%Assignment 5 and 6
%Emmanuel Mati
% University of Windsor
clear all
close all
clc

numerator = 180*[1 3];
denominator = conv([1 9],[1 8 36]);
sys=tf(numerator,denominator)
step(sys)
