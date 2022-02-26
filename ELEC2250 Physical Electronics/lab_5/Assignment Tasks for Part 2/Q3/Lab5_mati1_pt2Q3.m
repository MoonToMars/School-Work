% Lab Assignment 5
% ELEC-2250: Physical Electronics S2020
%Part 2: Simple Diffusion process simulation using a 1-D box
%The Matlab codes below help to visualize the diffusion process.
%The program provider a pseudo-animation of a one-dimensional particle system 
%as described in the textbook (Page 138-140).
%The y [ ] statement in the program controls the initial condition,
%N specifies the maximum number of monitored “jumps,” and
%the number in the pause statements controls the time between jumps.

%Initialization

clear all
close all
clc

x=[0.5 1.5 2.5 3.5 4.5]; % Position of the bin center
y=[0 0 100 0 0]; %Initial number of particles in a Bin
bar(x,y); %Draw bar graph
text (0.5,max(y)+.1*max(y),['t=0']); %Position start time t=0
axis([0,5,0,max(y)+.2*max(y)]) % Limit the axis for better visualization
xlabel ('Bin position')
ylabel('Particle Count')
pause (0.5)
N= 7; %time unit. Adjust N for a longer time until the bin values reach (quilibrium.
%Computations and plotting
figure
for i=1:N,
%Diffusion step calculation
bin(1)=(y(1)/2+y(2)/2) % Without the 'Semicolons', the bin values are output in the command window to see how the particles are moving left or right until an equilibrium is reached.
bin(2)=(y(1)/2+y(3)/2) % You can turn the command window output by inserting the 'Semicon back'.
bin(3)=(y(2)/2+y(4)/2)
bin(4)=(y(3)/2+y(5)/2)
bin(5)=(y(4)/2+y(5)/2)
t=i % Display the time internal, t=1, 2, 3, etc.
y=bin;
%plotting the result
bar(x,y);
axis(axis);
text(0.5,max(y)+.1*max(y),['t=', num2str(i)]);
axis([0,5,0,max(y)+.2*max(y)]);
xlabel ('Bin position')
ylabel('Particle Count')
pause (0.5)
end