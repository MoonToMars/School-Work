%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-1.2

%Clearing previous results
close all;
clear all;
clc;

%%part a
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 80;

[H] = lpfilter('ideal',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(I);title('Original');
figure;imshow(abs(i)/m);title('Ideal Low-Pass');

%%part b
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 160;

[H] = lpfilter('btw',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(abs(i)/m);title('btw Low-Pass');

%%part c
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 240;

[H] = lpfilter('gaussian',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(abs(i)/m);title('Gaussian Low-Pass');