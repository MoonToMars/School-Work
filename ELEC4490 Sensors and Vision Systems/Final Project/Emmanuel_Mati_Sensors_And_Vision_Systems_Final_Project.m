%Emmanuel Mati
%Summer 2020
%Sensors and Vision Systems
%Final Project; Label detector

%Clearing Workspace
close all,clear all,clc;

%Calling all of our sample images into a single cell array
bottles = {imread('Glue1.jpg'), imread('Glue2.jpg'), ...
    imread('Glue3.jpg'), imread('Glue4.jpg'),...
    imread('Glue5.jpg'), imread('Glue6.jpg')};
 
for i=1:6
    [widths, mask,maskedImage] = InputImage(bottles{i}); 
    labelChecker(mask, bottles{i}); %%checking labels with mask
    isIntact(widths, maskedImage);
end

%%Question 2 & 3, Check to see if the label is not straight or folded/ripped
function isIntact(baseWidths, inputImage)
ourTitle = "";
[x,y, z] = size(inputImage);
Hs = zeros(1,5);
%Using Hough Transform to find if the images edges are level or not
for i=1:5
    gray = rgb2gray(inputImage(floor(x/1.85:x*0.95),baseWidths(i,1):baseWidths(i,2),:));
    sampleGray = rgb2gray(inputImage(floor(x*.89:x*0.9),baseWidths(i,1)+10:baseWidths(i,2)-10,:));
    removeGray = mean(sampleGray(:));
    mask1 = removeGray - 30 < gray;
    mask2 = gray < removeGray+30;
    gray(mask1 & mask2) = 0;
    BW = edge(gray,'canny');
    [H,T,R] = hough(BW,'RhoResolution',0.5,'Theta',-90:0.5:89.5);
    Hs(i)=sum(H,'all');
end

% Displaying List of images and using different thresholds for different
% types of coloured images
for i=1:5
    %Hough Threshold values for different RGB elements with respect to
    %their label condition
    if Hs(i) < 300000
        ourTitle = strcat(ourTitle,{' '}, num2str(i), ': missing label,');
    elseif Hs(i) < 377000 ||386000 < Hs(i) && Hs(i) < 390000 || 420000 < Hs(i) && Hs(i) < 480000|| 520000 < Hs(i) && Hs(i) < 538000|| 565000 < Hs(i) && Hs(i) < 570000||Hs(i) > 750000
        ourTitle = strcat(ourTitle,{' '}, num2str(i), ': not Straight,');
   elseif 480000 < Hs(i) && Hs(i) < 520000|| 540000 < Hs(i) && Hs(i) < 565000|| 570000 < Hs(i) && Hs(i) < 600000
        ourTitle = strcat(ourTitle,{' '}, num2str(i), ': torn/folded,');
    else
        ourTitle = strcat(ourTitle,{' '}, num2str(i), ': passes,');
    end
end
figure;imshow(inputImage);title(ourTitle);
end



%%Question 1)Check to see if label is on the bottle
function labelChecker(binaryMask, glueBottles)
inputImage = glueBottles;
bottle = [0 0 0 0 0];  %used to keep track of the bottles
ourTitle = "Bottles in the following positions have labels: ";

%erode the bottles so that sticker details are emphasized
SE = strel('diamond', 3);
glueBottles = imerode(glueBottles, SE);

[x,y,z]=size(glueBottles);
%separating the 5 glue bottles
bottle(1) = sum(im2bw(glueBottles(x/2:x,1:floor(y/5),:),0.5),'all')/sum(binaryMask(x/2:x,1:floor(y/5)),'all');
bottle(2) = sum(im2bw(glueBottles(x/2:x,floor(y/5):floor(2*y/5),:),0.5),'all')/sum(binaryMask(x/2:x,floor(y/5):floor(2*y/5)),'all');
bottle(3) = sum(im2bw(glueBottles(x/2:x,floor(2*y/5):floor(3*y/5),:),0.5),'all')/sum(binaryMask(x/2:x,floor(2*y/5):floor(3*y/5)),'all');
bottle(4) = sum(im2bw(glueBottles(x/2:x,floor(3*y/5):floor(4*y/5),:),0.5),'all')/sum(binaryMask(x/2:x,floor(3*y/5):floor(4*y/5)),'all');
bottle(5) = sum(im2bw(glueBottles(x/2:x,floor(4*y/5):y,:),0.5),'all')/sum(binaryMask(x/2:x,floor(4*y/5):y),'all');

for i=1:1:5
    if bottle(i) < 0.75
        newText = num2str(i);
        ourTitle = strcat(ourTitle, newText, ', ');
    end
end

figure;imshow(inputImage);title(ourTitle);
end


%%Function that creates our mask
function [widths, mask, maskedImage] = InputImage(sampleImage)
figure;imshow(sampleImage);title('Input Image');%displaying input image

%adjusting the rgb compents to build our mask
r = ~im2bw(sampleImage(:,:,1),0.3);g = ~im2bw(sampleImage(:,:,2),0.25);b = ~im2bw(sampleImage(:,:,3),0.19);
mask=(r.*g).*b; %matrix element-wide operations
%filling up holes
mask = ~imfill(~mask, 'holes');
%Morphological operations to remove noise
SE = strel('square',5);
mask = imopen(~mask, SE);
figure;imshow(mask);title('Binary Mask');

%manipulating eag RGB component to get the mask
rMask = double(sampleImage(:,:,1));gMask = double(sampleImage(:,:,2));bMask = double(sampleImage(:,:,3));
%Removing the background from our input image
maskedImage=cat(3, uint8(rMask.*mask),uint8(gMask.*mask) ,uint8(bMask.*mask));

%finding the width of each bottle's base region
[x,y] = size(mask);
width = zeros(5, 2);
rowPos = 1;
for i=2:1:y
    if mask(floor(x/1.6),i) == 1 && mask(floor(x/1.6),i - 1)== 0
        width(rowPos,1) = i;
    elseif mask(floor(x/1.6),i) == 0 && mask(floor(x/1.6),i - 1) == 1
        width(rowPos,2) = i-1 ;
        rowPos = rowPos + 1;
    end
end
widths = width;
end