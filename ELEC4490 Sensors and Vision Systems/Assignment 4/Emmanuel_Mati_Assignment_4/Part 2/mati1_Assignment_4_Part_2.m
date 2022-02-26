%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 4.2

%Clearing previous results
close all
clear all
clc

%%Part A

%Retreiving our image and displaying it
x = imread('picture.gif');
figure
imshow(x);
title('Original Image');

f = imnoise(x, 'gaussian');
f2 = imnoise(x, 'salt & pepper');

figure
imshow(f)
title('Noisy image using gaussian noises')
figure
imshow(f2)
title('Noisy image using salt and pepper noises')

%%Part B filtering

%Mean Filter
filter = fspecial('average', [3 3]);
filteredimage = imfilter(f, filter);
figure
imshow(filteredimage)
title('Gaussian noise filtered using fspecial-mean with a mask of [3 3]')

%Median Filter
filteredimage = medfilt2(f2,[3,3]);
figure
imshow(filteredimage)
title('Gaussian noise filtered using median with a mask of [3 3]')

%Gaussian Filter
filter = fspecial('gaussian', [3 3]);
filteredimage = imfilter(f, filter);
figure
imshow(filteredimage) 
title('Gaussian noise filtered using fspecial-gaussian with a mask of [3 3]')

%Salt And Pepper
%Mean Filter
filter = fspecial('average', [3 3]);
filteredimage = imfilter(f2, filter);
figure
imshow(filteredimage)
title('Salt & Pepper noise filtered using fspecial-mean with a mask of [3 3]')

%Median Filter
filteredimage = medfilt2(f2,[3,3]);
figure
imshow(filteredimage)
title('Salt & Pepper noise filtered using median with a mask of [3 3]')

%Gaussian Filter
filter = fspecial('gaussian', [3 3]);
filteredimage = imfilter(f2, filter);
figure
imshow(filteredimage) 
title('Salt & Pepper noise filtered using fspecial-gaussian with a mask of [3 3]')

%%Part C

%Creating our avearging filter for a mask of 3x3
avgmask1 = 1/4 *[ 0 1 0; 1 0 1; 0 1 0];
avgmask2 = 1/32 *[ 1 13 1; 3 16 3; 1 3 1];

filteredimage = imfilter(f, avgmask1); %Filtering a Gaussian image with averaging mask
figure
imshow(filteredimage)
title('Part C, filtering an image using averaging 3x3 mask of: 1/4 *[ 0 1 0; 1 0 1; 0 1 0] ')

filteredimage = imfilter(f, avgmask2); %Filtering a Gaussian image with averaging mask
figure
imshow(filteredimage)
title('Part C, filtering an image using averaging 3x3 mask of: 1/32 *[ 1 13 1; 3 16 3; 1 3 1]')

%% Part D


%Gaussian Filter 3x3
filter = fspecial('gaussian', [3 3]);
disp('Gaussian filter time for 3x3:');
tic
filteredimage1 = imfilter(f, filter);
toc

%Gaussian Filter 5x5
filter = fspecial('gaussian', [9 9]);
disp('Gaussian filter time for 9x9:');
tic
filteredimage2 = imfilter(f, filter);
toc

%Gaussian Filter 5x5
filter = fspecial('gaussian', [13 13]);
disp('Gaussian filter time for 13x13:');
tic
filteredimage3 = imfilter(f, filter);
toc