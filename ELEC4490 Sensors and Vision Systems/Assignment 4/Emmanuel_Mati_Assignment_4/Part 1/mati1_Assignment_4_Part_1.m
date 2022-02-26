%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 4.1

%Clearing previous results
close all
clear all
clc

%Retreiving our image and displaying it
x = imread('picture.gif');
figure
imshow(x);
title('Original Image');

gcon = zeros(514, 514); %Our matrix that will hold our convoultion variables
gcor = zeros(514, 514); %Our matrix that will hold our  correlation variables

f = double(x); %Making our image a double so we can manipulate it

w = [0.02 0.02 0.02 %our mask User Can input values here
    .1 .1 1
    .1 0 0];

disp('user inputted mask:')
w

wrot = rot90(w,2); %180 degree rotated mask

for i = 2:513
    for j = 2:513
            gcon((i-1):(i+1),(j-1):(j+1)) = gcon((i-1):(i+1),(j-1):(j+1)) + f(i-1, j-1)*w; %conducting our convolution
    end
end
%Convolution Results
%Displaying our Convoluted image
figure
imshow(uint8(gcon))
title('Convolution Results')

for i = 2:513
    for j = 2:513
            gcor((i-1):(i+1),(j-1):(j+1)) = gcor((i-1):(i+1),(j-1):(j+1)) + f(i-1, j-1)*wrot; %conducting our correlation
    end
end
%Correlation Results
%Displaying our Correlation image
figure
imshow(uint8(gcor))
title('Correlation Results')

%%Testing using conv2
%using for convolution conv2
g = conv2(f,w);
%Displaying our convoluted image
figure
imshow(uint8(g))
title('Convolution using conv2')

%using for correlation conv2
g = conv2(f,wrot);
%Displaying our correlation image
figure
imshow(uint8(g))
title('Correlation using conv2')