%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-2.2

%Clearing previous results
close all;
clear all;
clc;

%User input for SE
Image=[0 0 0 0 0;0 1 1 0 0;0 1 1 0 0;0 0 1 0 0;0 0 0 0 0]


%structing elements
diaStruct1 = strel('diamond', 1)
diaStruct2 = strel('diamond', 2)

lineStruct1 = strel('line', 1, 90)
lineStruct2 = strel('line', 2, 180)

diskStruct1 = strel('disk', 1)
diskStruct2 = strel('disk', 2)

%applying dialation
figure;imshow(Image);title('Original Undilated Image');
figure;imshow(imdilate(Image,diaStruct1));title('Diamond struct n = 1');
figure;imshow(imdilate(Image,diaStruct2));title('Diamond struct n = 2');
figure;imshow(imdilate(Image,lineStruct1));title('Line struct n = 1, r = 90');
figure;imshow(imdilate(Image,lineStruct1));title('Line struct n = 2, r = 180');
figure;imshow(imdilate(Image,diskStruct1));title('Disk struct n = 1');
figure;imshow(imdilate(Image,diskStruct2));title('Disk struct n = 2');


