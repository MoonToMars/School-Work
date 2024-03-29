%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3.3 C

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Original Input Image');

x1 = imnoise(x,'salt & pepper');
figure
imshow(x1)
title('Salt and Pepper Noise')

x1 = imdivide(x1, 10);
x2 = imnoise(x, 'salt & pepper');
x2 = imdivide(x2, 10);
x3 = imnoise(x, 'salt & pepper');
x3 = imdivide(x3, 10);
x4 = imnoise(x, 'salt & pepper');
x4 = imdivide(x4, 10);
x5 = imnoise(x, 'salt & pepper');
x5 = imdivide(x5, 10);
x6 = imnoise(x, 'salt & pepper');
x6 = imdivide(x6, 10);
x7 = imnoise(x, 'salt & pepper');
x7 = imdivide(x7, 10);
x8 = imnoise(x, 'salt & pepper');
x8 = imdivide(x8, 10);
x9 = imnoise(x, 'salt & pepper');
x9 = imdivide(x9, 10);
x10 = imnoise(x, 'salt & pepper');
x10 = imdivide(x10, 10);

y = imadd(x1, x2);
y = imadd(y, x3);
y = imadd(y, x4);
y = imadd(y, x5);
y = imadd(y, x6);
y = imadd(y, x7);
y = imadd(y, x8);
y = imadd(y, x9);
y = imadd(y, x10);

figure
imshow(y)
title('Averaged 10 times with salt and pepper')