%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3.3 A

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Original Input Image');

x1 = imnoise(x,'gaussian', 0.1);
figure
imshow(x1)
title('gaussian at 0.1')

x1 = imdivide(x1, 10);
x2 = imnoise(x, 'gaussian', 0.1);
x2 = imdivide(x2, 10);
x3 = imnoise(x, 'gaussian', 0.1);
x3 = imdivide(x3, 10);
x4 = imnoise(x, 'gaussian', 0.1);
x4 = imdivide(x4, 10);
x5 = imnoise(x, 'gaussian', 0.1);
x5 = imdivide(x5, 10);
x6 = imnoise(x, 'gaussian', 0.1);
x6 = imdivide(x6, 10);
x7 = imnoise(x, 'gaussian', 0.1);
x7 = imdivide(x7, 10);
x8 = imnoise(x, 'gaussian', 0.1);
x8 = imdivide(x8, 10);
x9 = imnoise(x, 'gaussian', 0.1);
x9 = imdivide(x9, 10);
x10 = imnoise(x, 'gaussian', 0.1);
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
title('Averaged 10 times')

%%
%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Original Input Image');

x1 = imnoise(x,'gaussian', 0.05);
figure
imshow(x1)
title('gaussian at 0.05')

x1 = imdivide(x1, 8);
x2 = imnoise(x, 'gaussian', 0.05);
x2 = imdivide(x2, 8);
x3 = imnoise(x, 'gaussian', 0.05);
x3 = imdivide(x3, 8);
x4 = imnoise(x, 'gaussian', 0.05);
x4 = imdivide(x4, 8);
x5 = imnoise(x, 'gaussian', 0.05);
x5 = imdivide(x5, 8);
x6 = imnoise(x, 'gaussian', 0.05);
x6 = imdivide(x6, 8);
x7 = imnoise(x, 'gaussian', 0.05);
x7 = imdivide(x7, 8);
x8 = imnoise(x, 'gaussian', 0.05);
x8 = imdivide(x8, 8);
x9 = imnoise(x, 'gaussian', 0.05);

y = imadd(x1, x2);
y = imadd(y, x3);
y = imadd(y, x4);
y = imadd(y, x5);
y = imadd(y, x6);
y = imadd(y, x7);
y = imadd(y, x8);

figure
imshow(y)
title('Averaged 8 times')