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

%Size of adjacency Array
arraysize = UserInput/2 + 1

%creating an empty m-adjacency array
mAdj = zeros(arraysize, arraysize);


%Creating the Binary Array
BinSet =  [ 0 0 0 0 0 0 1 0 ;...
    0 0 0 0 0 1 0 0;...
    0 0 0 0 0 1 0 0;...
    0 0 0 0 0 1 0 0;...
    0 1 1 0 0 0 1 0;...
    0 1 0 0 0 0 0 1;...
    0 1 0 0 0 0 0 0;...
    0 1 0 0 0 0 0 0];

%Getting array size
[rows, columns] = size(BinSet);

%Setting new array to be larger
newBinArray = zeros(rows + (arraysize-1), columns + (arraysize-1));

FinalArray = zeros(rows, columns);

%Entering old array values to new array
for x = 1:1:rows
    for y = 1:1:columns
        newBinArray(x + (arraysize-1)/2, y + (arraysize-1)/2) = BinSet(x, y);
    end
end

FourAdjacent =  [ 0 1 0 ;...
    1 0 1;...
    0 1 0 ];

EightAdjacent =  [ 0 0 2 0 0;...
     0 2 1 2 0;...
     2 1 0 1 2;...
     0 2 1 2 0;...
     0 0 2 0 0]

%makes half of m-adjacent mask
for x = 1:1:arraysize
    for y = 1:1:(arraysize+1)/2
            mAdj(x,y) = abs(y-x)
        end
    end
end
mAdj
%completes the mask
mAdj= mAdj + flipdim(flipdim( mAdj, 2),1)

%traversing the array from top-bottom, left to right
for x = 2:1:rows + 1
    for y = 2:1:columns + 1
                FinalArray(x - 1,y - 1) = FourAdjacent(1,1)* newBinArray(x - 1, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(1,2)* newBinArray(x - 1, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(1,3)* newBinArray(x - 1, y + 1);
                
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,1)* newBinArray(x, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,2)* newBinArray(x, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,3)* newBinArray(x, y + 1);
                
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,1)* newBinArray(x + 1, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,2)* newBinArray(x + 1, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,3)* newBinArray(x + 1, y + 1);
    end
end

%traversing the Array from bottom-top, right to left
for x = rows + 1:1:2
    for y = columns + 1:1:2
                FinalArray(x - 1,y - 1) = FourAdjacent(1,1)* newBinArray(x - 1, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(1,2)* newBinArray(x - 1, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(1,3)* newBinArray(x - 1, y + 1);
                
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,1)* newBinArray(x, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,2)* newBinArray(x, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(2,3)* newBinArray(x, y + 1);
                
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,1)* newBinArray(x + 1, y - 1);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,2)* newBinArray(x + 1, y);
                FinalArray(x - 1,y - 1) = FinalArray(x - 1,y - 1) + FourAdjacent(3,3)* newBinArray(x + 1, y + 1);
    end
end

disp('Our Input value: ');
disp(BinSet)

disp('Our Final value: ');
disp(FinalArray)

disp('Using the imfilter function to compare: ');
imfilter(BinSet, FourAdjacent)