%% Author: Emmanuel Mati
% ELEC4490 Assignment 1

%% Pt1 Vectors and Matrices

% Column vectors/matrices declaration
v1 = [1 2 ; 3 4];
v2 = [5 6 ; 7 8];
v12 = [v1, v2];
sec = 1:1:60; 

% Accessing elements
v12(1:2, 1:3)
sec(1:3)

% Dot operations
v12.^2
v12./v12

% Inverse & Transpose
inv(v2)
v12'

% Flipping, rotating, and reshaping 
reshape(rot90(flipud(fliplr(v12))), 2, 4)

% Fuction
y = sin(2*pi*sec/60);
plot(sec, y)

%% Pt3  Loops
EarningByMonth = [1:12; 100:50:650]
TotalEarnings = [1:12; 0 : 0 : 12];

for Month = 1:length(EarningByMonth)
    TotalEarnings(2,Month) = sum(EarningByMonth(2,1:Month));
    y(Month) = sum(EarningByMonth(2,1:Month));
end

TotalEarnings
plot(TotalEarnings(1,1:12), TotalEarnings(2,1:12))

%% Pt4 Indexing and Masking
 
FirstArray = [1 0 1 0; 0 1 0 1];

% Slicing and slice shifting
SecondArray = reshape(FirstArray, 4, 2)
SecondArray(:,1)
FirstArray(1,1:4) = FirstArray(2, 1:4)

% Array as subscript
Position = [2 3 4 5];
FirstArray(Position)

% Comparison
FirstArray(:,1:2) == FirstArray(:,3:4)

% Masks
newVariable = [6 9 6 9];
mask = [true true true false];
newVariable(mask) = [100 101 102]
newVariable(mask)
Position.*mask