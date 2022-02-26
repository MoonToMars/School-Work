%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3.3 D

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Original Input Image');

%Generating Salt and Pepper Noise
x1 = imnoise(x,'salt & pepper');
figure
imshow(x1)
title('Salt and Pepper Noise')

%Using medfilt2
x1 = medfilt2(x1);
figure
imshow(x1)
title('Salt and Pepper Noise Reduction Using medfilt2')