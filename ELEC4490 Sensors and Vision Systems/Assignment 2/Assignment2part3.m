%%Image Processing Assignment
%ELEC-4490 S2020
%Assignment 2
%Author: Emmanuel Mati

% Part 3
clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window

%Retreived image location
RetrievedImage = imread('lena.png');
[rows cols] = size(RetrievedImage);

%Making the image double so we can work on it
DoubledImage = double(RetrievedImage);
newImage = zeros(rows, cols); %sizing a new image

% What we want to display in the user prompt
prompt={'Enter one of the following colour intensity levels: 2, 4, 8, 16, 32, 64, 128, 256'};
name='Intensity picker';
numlines=1;
defaultanswer={'256'};
%Taking user input and converting it to double
Input=str2double(inputdlg(prompt,name,numlines,defaultanswer));

%Calculating Step Value
StepVal = floor(256/(Input-1));

%loops to each pixel and reduces the intensity accordingly
for row = 1:1:rows
    for col = 1:1:cols
        for i =0:StepVal:256
            if abs(i + StepVal - DoubledImage(row, col)) >= abs(DoubledImage(row, col) - i)
                newImage(row, col)= i;
                break
            end
        end
    end
end

figure, imshow(RetrievedImage);
figure, imshow(newImage/255)