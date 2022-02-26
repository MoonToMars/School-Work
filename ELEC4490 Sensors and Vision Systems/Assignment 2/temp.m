%%Image Processing Assignment
%ELEC-4490 S2020
%Assignment 2
%Author: Emmanuel Mati

%% Part 4: A, B, C
clear all; %Deletes all variables
close all; %Closes all figure windows
clc; %Clears the command window

% What we want to display in the user prompt
prompt={'Enter Desired Adjacency(4, 8, 16, 32, m)'};
name='Adjacenecy picker';
numlines=1;
defaultanswer={'4'};
%Taking user input and converting it to double
UserInput=str2double(inputdlg(prompt,name,numlines,defaultanswer));

%Creating the Binary Array
BinSet =  imread('lena.png');

BinSet = im2bw(BinSet);

%Getting its size
[rows, columns] = size(BinSet);


%Showing Input
figure, imshow(BinSet)
title('Original Binary Image');
fprintf('User Input: %d-adjacent', UserInput);

%Creating the mask
OurMask = true(rows, columns);
for x=1:1:rows
    for y=1:1:columns
        if BinSet(x,y) == 1
            OurMask(x,y) = false;
        end
    end
end

%Creating our Adjacent Array
Adjacent = zeros(rows, columns);


%Generate 4-Adjecent
for x=1:1:rows
    for y=1:1:columns
        if OurMask(x,y) == false
            Adjacent(x,y)= 0;
        elseif OurMask(x,y) == true
            %checks up
            if x ~= 1 & OurMask(x-1,y)== false
               Adjacent(x,y)= 1;
            %checks up
            elseif  x ~= rows & OurMask(x+1,y)== false
                Adjacent(x,y)= 1;
            %checks left
            elseif  y ~= 1 & OurMask(x,y-1)== false
                Adjacent(x,y)= 1;
            %checks right
            elseif  y ~= columns & OurMask(x,y+1)== false
                Adjacent(x,y)= 1; 
            end
        end
    end
end

%Calculates adjacency above 4
if UserInput ~= 4
    for t = 2:1:log2(UserInput)
        for x=1:1:rows
            for y=1:1:columns
                if OurMask(x,y) == true & Adjacent(x,y) == 0 & t ~= 0
                    %checks up
                    if x ~= 1 & Adjacent(x-1,y) == t - 1 & OurMask(x-1,y) == true
                       Adjacent(x,y)= t;
                    %checks up
                    elseif  x ~= rows & Adjacent(x+1,y) == t - 1 & OurMask(x+1,y) == true
                        Adjacent(x,y)= t;
                    %checks left
                    elseif  y ~= 1 & Adjacent(x,y-1) == t - 1 & OurMask(x,y-1) == true
                        Adjacent(x,y)= t;
                    %checks right
                    elseif  y ~= columns & Adjacent(x,y+1) == t - 1 & OurMask(x,y+1) == true
                        Adjacent(x,y)= t;
                    end
                end
            end
        end
    end
end

imshow(Adjacent)