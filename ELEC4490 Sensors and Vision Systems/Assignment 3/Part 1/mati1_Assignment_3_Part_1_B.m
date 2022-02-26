%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3b

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Input Image');

%converting our image into a double for manipulation
x = double(x);

c = min(x(:));%our lowest image value
d = max(x(:));%our highest image value

a = input('Set your lower bound between 0-255: ');%what we want to set out lower bound to
b = input('Set your upper bound between 0-255: '); %What we want to set out upper bount to

x = (x-c)*((b-a)/(d-c)) + a; %manipulating each pixel to stretch parameters

%Displaying our stretched image
figure
x = uint8(x);
imshow(x)
title('Stretched Image');

%%Comparing with imaadjust
figure
imshow(imadjust(imread('eye.jpg'), [c/255 d/255], [a/255 b/255])) %we output the negative of the image
title('Image Adjust Result');
