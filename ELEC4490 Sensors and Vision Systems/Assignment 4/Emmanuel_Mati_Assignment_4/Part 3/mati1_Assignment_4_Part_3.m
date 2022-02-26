%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 4.3

%Clearing previous results
close all
clear all
clc

%%Part A

%Retreiving our image and displaying it
x = imread('picture.gif');
figure
imshow(x);
title('Original Image');

%Laplacian filter
filter = fspecial('laplacian');
lap = imfilter(x, filter);
figure
imshow(lap);
title('Laplacian filtered image');

%Prewitt filter
filter = fspecial('prewitt');
pre = imfilter(x, filter);
figure
imshow(pre);
title('Prewitt filtered image');

%Sobel filter
filter = fspecial('sobel');
sob = imfilter(x, filter);
figure
imshow(sob);
title('Sobel filtered image');

%Unsharp filter
filter = fspecial('unsharp');
unsharp = imfilter(x, filter);
figure
imshow(unsharp);
title('Unsharp filtered image');

%%Part B

%Adding our Gaussian Noise to x
x = imnoise(x, 'gaussian');
figure
imshow(x)
title('Our new noisy image before filtering')

%Laplacian filter
filter = fspecial('laplacian');
lap = imfilter(x, filter);
figure
imshow(lap);
title('Laplacian filtered image');

%Prewitt filter
filter = fspecial('prewitt');
pre = imfilter(x, filter);
figure
imshow(pre);
title('Prewitt filtered image');

%Sobel filter
filter = fspecial('sobel');
sob = imfilter(x, filter);
figure
imshow(sob);
title('Sobel filtered image');

%Unsharp filter
filter = fspecial('unsharp');
unsharp = imfilter(x, filter);
figure
imshow(unsharp);
title('Unsharp filtered image');

%%Part C

%edge detection using roberts and sobel

%Retreiving our rgb image and displaying it
y = imread('pennies.jpg');
figure
imshow(y);
title('Original RGB Image');
empty = zeros(size(y, 1), size(y, 2), 'uint8');


y1 = y(:, :, 1).*uint8(edge(y(:, :, 1), 'roberts')); %Our Roberts edge
y2 = y(:, :, 1).*uint8(edge(y(:, :, 1), 'sobel')); %Our Sobel edge
y3 = y(:, :, 2).*uint8(edge(y(:, :, 2), 'roberts')); %Our Roberts edge
y4 = y(:, :, 2).*uint8(edge(y(:, :, 2), 'sobel')); %Our Sobel edge
y5 = y(:, :, 1).*uint8(edge(y(:, :, 3), 'roberts')); %Our Roberts edge
y6 = y(:, :, 1).*uint8(edge(y(:, :, 3), 'sobel')); %Our Sobel edge

%displaying Roberts edge
figure
imshow(cat(3, y1, empty, empty))
title('Roberts Red edges for RGB image');

%displaying Sobels edge
figure
imshow(cat(3, y2, empty, empty))
title('Sobels Red edges for RGB image');

%displaying Roberts edge
figure
imshow(cat(3, empty, y3, empty))
title('Roberts Green edges for RGB image');

%displaying Sobels edge
figure
imshow(cat(3, empty, y4, empty))
title('Sobels Green edges for RGB image');

%displaying Roberts edge
figure
imshow(cat(3, empty, empty, y5))
title('Roberts Blue edges for RGB image');

%displaying Sobels edge
figure
imshow(cat(3, empty, empty, y6))
title('Sobels Blue edges for RGB image');

%displaying Roberts combined colour channel edges
figure
imshow(cat(3,y1,y3,y5))
title('Roberts edges combined');

%displaying Sobels edge
figure
imshow(cat(3,y2,y4,y6))
title('Sobels edges combined');