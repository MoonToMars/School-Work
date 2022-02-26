%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3a

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
imshow(x);
title('Input Image');

%converting our image into a double for manipulation
x = double(x);

%Creating our negative array
NegativeValues(1:576, 1:768) = 255;

NegImage = imsubtract(NegativeValues, x); %Creating our Negative image

%Converting to 8 bit so we can show the image
NegImage=uint8(NegImage);

%Showing our negative Image
figure
imshow(NegImage);
title('Image Negative');

%%Comparing with imadjust
figure
imshow(imadjust(imread('eye.jpg'), [0 1], [1 0])) %we output the negative of the image
title('imadjust Image');