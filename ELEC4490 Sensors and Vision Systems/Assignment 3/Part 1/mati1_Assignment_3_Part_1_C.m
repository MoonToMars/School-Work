%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3c

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Input Image');


x = imadjust(imread('eye.jpg'), [], [], 0.5); %adjusting our gamma
figure
imshow(x);
title('Gamma Adjusted Image at 0.5');

x = imadjust(imread('eye.jpg'), [], [], 2); %adjusting our gamma
figure
imshow(x);
title('Gamma Adjusted Image at 2');