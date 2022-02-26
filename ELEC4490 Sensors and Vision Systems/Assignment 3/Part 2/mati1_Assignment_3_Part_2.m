%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 3

%%Code for Part A

%Clearing previous results
close all
clear all
clc

%getting our image and displaying it
x = imread('eye.jpg');
figure
imshow(x);
title('Input Image');

x = double(x); % making our value a double for manipulation

%Calculating 8th bit plane
b8 = bitget(x, 8);
figure
imshow(b8)
title('8th bit plane')

%Calculating 7th bit plane
b7 = bitget(x, 7);
figure
imshow(b7)
title('7th bit plane')

%Calculating 6th bit plane
b6 = bitget(x, 6);
figure
imshow(b6)
title('6th bit plane')

%Calculating 5th bit plane
b5 = bitget(x, 5);
figure
imshow(b5)
title('5th bit plane')

%Calculating 4th bit plane
b4 = bitget(x, 4);
figure
imshow(b4)
title('4th bit plane')

%Calculating 3rd bit plane
b3 = bitget(x, 3);
figure
imshow(b3)
title('3rd bit plane')

%Calculating 2nd bit plane
b2 = bitget(x, 2);
figure
imshow(b2)
title('2nd bit plane')

%Calculating 1st bit plane
b1 = bitget(x, 1);
figure
imshow(b1)
title('1st bit plane')

%%Code for Part B
%Connecting the bit slices together
NewImage = 2^7 * b8 + 2^6 * b7 + 2^5 * b6 + 2^4 * b5 + 2^3 * b4 + 2^2 * b3 + 2 * b2 + b1;

%displaying our new re-combined images
figure
imshow(uint8(NewImage));
title('Combined 8 to 1 bit-slices')

%%Code for Part C
%Bits 8-6 recombined
b8to6 = 2^7 * b8 + 2^6 * b7 + 2^5 * b6;
figure
imshow(uint8(b8to6));
title('Combined 8 to 6 bit-slices')

%Missing bits from combining 8 to 6 slices
figure
imshow(imread('eye.jpg') - uint8(b8to6))
title('Subtracted image from planes 8-6')

%Bits 8-3 recombined
b8to3 = 2^7 * b8 + 2^6 * b7 + 2^5 * b6 + 2^4 * b5 + 2^3 * b4 + 2^2 * b3;
figure
imshow(uint8(b8to3));
title('Combined 8 to 3 bit-slices')

%Missing bits from combining 8 to 3 slices
figure
imshow(imread('eye.jpg') - uint8(b8to3))
title('Subtracted image from planes 8-3')

%%Part D Watermarking our Image
WaterMark = zeros(576, 768);
WaterMark(144:432, 1:768) = 1;


%Placing the watermark on the th bit
WaterMarkedImage = 2^7 * b8 + 2^6 * b7 + 2^5 * b6 + 2^4 * WaterMark + 2^3 * b4 + 2^2 * b3 + 2 * b2 + b1;

%displaying our new re-combined images
figure
imshow(uint8(WaterMarkedImage));
title('Water Marked Image at bit 5')

figure
imshow(imread('eye.jpg') - uint8(WaterMarkedImage))
title('Subtracted image from bit 5 and water mark')

%Placing the watermark on the 6th bit
WaterMarkedImage = 2^7 * b8 + 2^6 * b7 + 2^5 * WaterMark + 2^4 * b5 + 2^3 * b4 + 2^2 * b3 + 2 * b2 + b1;

%displaying our new re-combined images
figure
imshow(uint8(WaterMarkedImage));
title('Water Marked Image at bit 6')

figure
imshow(imread('eye.jpg') - uint8(WaterMarkedImage))
title('Subtracted image from bit 6 and water mark')

%Placing the watermark on the 7th bit
WaterMarkedImage = 2^7 * b8 + 2^6 * WaterMark + 2^5 * b6 + 2^4 * b5 + 2^3 * b4 + 2^2 * b3 + 2 * b2 + b1;

%displaying our new re-combined images
figure
imshow(uint8(WaterMarkedImage));
title('Water Marked Image at bit 7')

figure
imshow(imread('eye.jpg') - uint8(WaterMarkedImage))
title('Subtracted image from bit 7 and water mark')

%Placing the watermark on the 8th bit
WaterMarkedImage = 2^7 * WaterMark + 2^6 * b7 + 2^5 * b6 + 2^4 * b5 + 2^3 * b4 + 2^2 * b3 + 2 * b2 + b1;

%displaying our new re-combined images
figure
imshow(uint8(WaterMarkedImage));
title('Water Marked Image at bit 8')

figure
imshow(imread('eye.jpg') - uint8(WaterMarkedImage))
title('Subtracted image from bit 8 and water mark')