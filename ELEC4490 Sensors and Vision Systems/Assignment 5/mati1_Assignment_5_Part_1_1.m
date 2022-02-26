%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-1.1

%Clearing previous results
close all
clear all
clc

%Retreiving our image and displaying it
peppers = rgb2gray(imread('peppers.jpg'));
wicker = rgb2gray(imread('wicker.jpg'));
wood = rgb2gray(imread('wood.jpg'));


%applying FFT2
peppersGraph = abs(fftshift(fft2(peppers)));
wickerGraph = abs(fftshift(fft2(wicker)));
woodGraph = abs(fftshift(fft2(wood)));

figure;imshow(peppers);title('peppers');
figure;imshow(log(peppersGraph), []);title('DFT peppers');

figure;imshow(wicker);title('wicker');
figure;imshow(log(wickerGraph), []);title('DFT wicker');

figure;imshow(wood);title('wood');
figure;imshow(log(woodGraph), []);title('DFT wood');