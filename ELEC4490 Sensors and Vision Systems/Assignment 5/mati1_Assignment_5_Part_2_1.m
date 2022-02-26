%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Assignment 5-2.1

%Clearing previous results
close all;
clear all;
clc;

%%part a

%User input for SE
SE = input('Enter your structuring element. Press enter for deault [1 1 1;1 1 1;1 1 1]: ');

if isempty(SE)
    SE = [1 1 1;1 1 1;1 1 1]
end
% Code from lecture
% Creating 256x256 image

B=zeros(256,256);
for i=128:160
    for j=128:160
        B(i,j)=1;
    end
end

for i=20:25
    for j=30:190
        B(i,j)=1;
    end
end

i=1;
while i<40 % generate 40 random pixels
    x=uint8(rand*254)+1;
    y=uint8(rand*254)+1;
    B(x,y)=1;i=i+1;
end

figure;imshow(B);title('Original Image created'); %Original Image


%dialation
padB = padarray(B,[1,1]);
newImg = zeros(size(B));
for x = 1: size(B,1)
    for y = 1: size(B,2)
        newImg(x, y) = sum(SE & padB(x:x+2, y:y+2), 'all'); %summing matrix of values that are to be dialated
    end
end

figure;imshow(newImg);title('Dilation from calculations');
figure;imshow(imdilate(B, SE));title('imdilate results'); %part b

%erosion
padBe = padarray(B,[1,1],1);
newImge = zeros(size(B));
for x = 1:size(padBe, 1)-2
    for y = 1:size(padBe, 2)-2
       xx = padBe(x:x+2,y:y+2);
       yy = find(SE == 1);
        
        if(xx(yy)==1)
            newImge(x,y)=1; %erroding the values in the image outside of mask
        end
    end
end

figure;imshow(newImge);title('erosion from calculations');
figure;imshow(imerode(B, SE));title('imerode results'); %part b