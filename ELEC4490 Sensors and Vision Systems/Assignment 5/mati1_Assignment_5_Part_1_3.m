%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-1.3

%Clearing previous results
close all;
clear all;
clc;

%%part a
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 80;

[H] = hpfilter('ideal',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(I);title('Original');
figure;imshow(abs(i)/m);title('Ideal High-Pass');

%%part b
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 160;

[H] = hpfilter('btw',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(abs(i)/m);title('btw High-Pass');

%%part C
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 160;

[H] = 0.5+1.5*hpfilter('btw',M,N,radii, 2);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(abs(i)/m);title('btw High-Pass with High Frequency');

%%part d
I = rgb2gray(imread('a.jpg'));
[M,N] = size(I);
radii = 240;

[H] = hpfilter('gaussian',M,N,radii);
%Retreiving our image and displaying it
F = fft2(I);
Z = F.*H;
i = ifft2(Z);
m = max(max(i));
figure;imshow(abs(i)/m);title('Gaussian High-Pass');