%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 4.4 C

%Clearing previous results
close all
clear all
clc

%Retreiving our image and displaying it
cat = rgb2gray(imread('cat.png'));
figure
imshow(cat);
title('Original Image');

%Retreiving character template
t = rgb2gray(rot90(imread('t.png')));
figure
imshow(t);
title('Pattern Matching Image');

[m n] = size(t);

%padding our letter
paddedt = uint8(zeros(100, 200));
paddedt(1:m, 1:n) = paddedt(1:m, 1:n) + t;
figure
imshow(paddedt);
title('Padded letter');

cor = normxcorr2(cat, paddedt);

disp('Template position in the image:')
[x y] =  find(cor ==(max(max(cor))))
