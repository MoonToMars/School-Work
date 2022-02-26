%Image Processing Assignment
%ELEC-4490 S2020
%Assignment 2
%Author: Emmanuel Mati

% Part 2
clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window

%Retreived image location
GreyImage = imread('lena.png');
imshow(GreyImage);

%Takes image from unit8 array to double array
ImageToBeProcessed = double(GreyImage);

%Taking Resolution of the image
[ImageRow ImageColumn] = size(GreyImage);

% What we want to display in the user prompt
prompt={'Pick a threshold between 0 and 255'};
name='Black and White from Grey';
numlines=1;
defaultanswer={'128'};

%Taking user input and converting it to double
Thresh=str2double(inputdlg(prompt,name,numlines,defaultanswer));

%Blank Image
BlackAndWhite=zeros(ImageRow,ImageColumn);

%loop array from left to right and bottom to top
    for x = 1:ImageRow
        for y = 1:ImageColumn
            %colour selecting
            if ImageToBeProcessed(x,y) < Thresh
                BlackAndWhite(x,y) = 0;
            else
                BlackAndWhite(x,y) = 255;
            end

        end
    end
  imshow(BlackAndWhite)

%% BW comparison
clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window
GreyImage = imread('lena.png');
BW  = im2bw(GreyImage,0.5);
imshow(BW)
