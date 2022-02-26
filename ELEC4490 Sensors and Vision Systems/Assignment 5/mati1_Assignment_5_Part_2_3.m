%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-2.3

%Clearing previous results
close all;
clear all;
clc;

Image= im2bw(imread('binaryImage.png'));
SE1 = strel('disk',15); %struct used
SE2 = [1 0 0;0 1 0;0 0 1];
SE3 = [0 0 0;1 0 0;0 0 0];

%Output
figure;imshow(Image);title('Original Image');
figure;imshow(imopen(Image, SE1));title('a. Imopen with disk struct r = 15'); %a
figure;imshow(imclose(Image, SE1));title('b. Imclose with disk struct r = 15'); %b
figure;imshow(bwhitmiss(Image, SE2, SE3));title('C. bwhitmiss with SE = [100;010;001] & [000;100;000]'); %c
