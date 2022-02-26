%Image Processing Assignment
%ELEC-4490 S2020
%Assignment 2
%Author: Emmanuel Mati

%Part 1

clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window

%Retreived image
ImageInput = imread('lena.png');


%Recording how many rows and columns the image has
[rows, cols] = size(ImageInput)
%Here we choose how much we want to rezize our image by
newImage= zeros(round(rows/8),round(cols/8));

%Row and column index positions
rind = 1
cind = 1

%Now we shrink the image with two for loops
for row = 1:8:rows
    for col = 1:8:cols
        newImage(rind,cind) = ImageInput(row, col);
        cind = cind + 1;
    end
    cind = 1;
    rind = rind + 1;
end

figure, imshow(ImageInput)
figure, imshow(newImage/255)

%%using imresize for comparison
figure, imshow(imresize(imread('lena.png'),[64 64]))
figure, imshow(imresize(imread('monkey.gif'),[64 64]))
figure, imshow(imresize(imread('bird.gif'),[86 86]))