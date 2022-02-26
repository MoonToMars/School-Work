%%Image Processing Assignment
%ELEC-4490 S2020
%Assignment 2
%Author: Emmanuel Mati

%% Part 4:A, B, C, D
clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window

%Original Image
figure, imshow(imread('lena.png'));
title('Original')

%Retreived 8-bit monochrome image location
Mono8bit = imread('lena.png');
%Double monochrome image
Mono2bit = double(Mono8bit);

%Part A
PartA = Mono8bit + Mono8bit;
figure, imshow(PartA); %Image becomes lighter
title('Part A')

%Part B
PartB = immultiply(Mono8bit, Mono8bit);
figure, imshow(PartA); %Image becomes lighter
title('Part B')

%Part C
PartC =  immultiply(Mono2bit, Mono2bit);
figure, imshow(PartC/255); %Image becomes fully White
title('Part C')

%Part D
PartD =  imdivide(Mono2bit, Mono2bit);
figure, imshow(PartD/255); %Image becomes fully Black
title('Part D')