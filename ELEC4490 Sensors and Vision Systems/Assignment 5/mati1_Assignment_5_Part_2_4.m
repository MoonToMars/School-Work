%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-2.4

%%a
%Clearing previous results
close all;
clear all;
clc;

Image= im2bw(imread('binaryImage.png'));
[x, connectedObjects]= bwlabel(Image,4);
bwSelectImage = bwselect(Image);
%Output
figure;imshow(Image);title('Original Image');
figure;imshow(x);title(['This image has ',num2str(connectedObjects),' objects using bwlabel']);
figure;imshow(bwSelectImage);title('bwselect image');

%%b
figure;imshow(bwmorph(Image,'skel',Inf));title('4b-b Image using skel');
figure;imshow(bwmorph(Image,'shrink',Inf));title('4b-c Image using shrink');
figure;imshow(bwmorph(Image,'remove',Inf));title('4b-d Image using remove');