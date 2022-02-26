% Lab Assignment 5
% ELEC-2250: Physical Electronics S2020
% Part 1: Animation of thermal carrier motion
% Spatial dimensions are in units of mean free paths (lambda)
% Time is in units of mean free times (tau_c)
% Initial (random) velocity is then stdev=1, normal distribution
% Initial positions are randomly distributed on y axis
% Uniformly distributed on x axis to show evolution of location histogram
% due to random diffusion
%initialization
close all
clear all
clc
% "Electric Field" in arbitrary units (2, 4, 7, -5, etc.)
ex=input('x-direction electric field, ex = ');
ey=input('x-direction electric field, ey = ');
% Set to zero for diffusion
% Figures
% Figure 1:
% follow individual carriers and show paths in red, blue, green, black
% Figure 2:
% plot current vs. time (using Shockley Ramo)
% number of electrons
ne=input('number of electrons (Must be =>4), ne = ');
% time step in mean free times
ts=1;
% Number of frames in movie
nframes = 100;
% Number of total time points
npts=100;
% number of mean free paths (lc) in x, y directions (You can change it to some other values) .
nx=50;
ny=50;
% Dimension position, velocity arrays
xpos=zeros(ne,npts);
ypos=zeros(ne,npts);
xvel=zeros(ne,npts);
yvel=zeros(ne,npts);
% initialize electron positions x positions all on left side
% random
% xpos(:,1)= nx*(rand(ne,1)-1);
% evenly spaced to illustrate diffusion
xpos(:,1)= nx*linspace(-1,0,ne);
ypos(:,1)=2*ny*(rand(ne,1)-0.5);
% start carrier 1,2,3,4 at origin for color plotting
xpos(1:4,1)=0;
ypos(1:4,1)=0;
% array of random velocities
rxv=randn(ne,npts+1);
ryv=randn(ne,npts+1);
% initialize electron velocities
xvel(:,1)=rxv(:,1);
yvel(:,1)=ryv(:,1);
% probability of collision
pc=1/2;
% Collisions
% matrix entry = 1 if that carrier has a lattice collision
% during that time slot
coll=rand(ne,npts)<pc;
% Set up plot
figure(1)
set(gcf,'units','normalized')
set(gcf,'Position',[.1 .4 .45 .5])
grid off
% Generate the movie and use getframe to capture each frame.
for k = 1:npts
 clf
 subplot(2,1,1)
 xlabel('Carriers (2-D Representation)')
 axis([-nx nx -ny ny])
 % Resistor boundaries
 rectangle('Position',[-nx -ny 2*nx 2*ny],'FaceColor',[.9 .9 .9],'EdgeColor',[0 0 0])
 % plot electrons
 plot(xpos(:,k),ypos(:,k),'ok','MarkerFaceColor',[.5 .5 .5])
 % Check for exceeding limits and bounce velocities if necessary
 for kx=1:ne
 % calculate next position by calculating next velocity first
 % electric field
 xvel(kx,k+1)=xvel(kx,k)+ex;
 yvel(kx,k+1)=yvel(kx,k)+ey;
 % collisions
 xvel(kx,k+1)=(1-coll(kx,k))*xvel(kx,k+1)+coll(kx,k)*rxv(kx,k+1);
 yvel(kx,k+1)=(1-coll(kx,k))*yvel(kx,k+1)+coll(kx,k)*ryv(kx,k+1);
 % if abs(xpos(kx,k)+ts*xvel(kx,k+1))>nx % If next position outside
 % xpos(kx,k)=-xpos(kx,k); % move position to other end (KCL)
% end
 if abs(ypos(kx,k)+ts*yvel(kx,k+1))>ny % If next position outside
 yvel(kx,k+1)=-yvel(kx,k+1); % reverse velocity
 end
 if abs(xpos(kx,k)+ts*xvel(kx,k+1))>nx % If next position outside
 xvel(kx,k+1)=-xvel(kx,k+1); % reverse velocity
 end
 end
 % update positions
 xpos(:,k+1)=xpos(:,k)+ts*xvel(:,k+1);
 ypos(:,k+1)=ypos(:,k)+ts*yvel(:,k+1);
 % track path of carrier 1
 line(xpos(1,1:k),ypos(1,1:k),'Color',[1 0 0],'LineWidth',2)
 line(xpos(2,1:k),ypos(2,1:k),'Color',[0 1 0],'LineWidth',2)
 line(xpos(3,1:k),ypos(3,1:k),'Color',[0 0 0],'LineWidth',2)
 line(xpos(4,1:k),ypos(4,1:k),'Color',[0 0 1],'LineWidth',2)
 axis([-nx nx -ny ny])
 % histogram of positions
 subplot(2,1,2)
 hist(xpos(:,k),-45:10:45)
 ylim([0 ne/3])
 title('Histogram of Carrier Locations (x-axis)')
 % Only put nframes frames into movie
 if k<=nframes
 M(k) = getframe(gcf);
 end
end