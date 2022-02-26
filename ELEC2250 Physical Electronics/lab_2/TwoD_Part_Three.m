%% Lab Assignment 2; 1D and 2D wave Function Simulation in Matlab
% Author: Emmanuel Mati
% ELEC2250 S2020

% ELEC-2250 S2020
% Lab assignment 2 Part B
% Solution of Schrödinger equation for a particle in a 2D box
%Reference; Solid state Electronic Devices, Streetman, Classnotes
% https://www.physicsforums.com/insights/visualizing-2-d-particle-box/
clear all
close all
clc

% Define constants and variables
h=6.63e-34; %Planck's constant in Joules
m=9.11e-31; % Free Electron mass
hbar=h/(2*pi);
for n=1:1:5 %modified to 5 from 3
    nx=n; % number of energy states along x direction
    ny=n; % number of energy states along x direction
    Lx = 1e-6; % Box length along the x-direction; length for part 3
    Ly = 1e-6; % Box length along the y-direction; lngeth for part 3


    kx =nx*pi/Lx;
    ky =ny*pi/Ly;
    E=n^2*pi^2*hbar^2/(2*m)*(1/Lx^2+1/Ly^2) % Energy of a particle in a 2D box
    w =hbar*(kx^2+ky^2)/2*m % frequency from E=hf
    w=5*w./max(w) % Frequency scaling forvisualization
    A = sqrt(4/(Lx*Ly)) % Wave function amplitude
    PD_peak=A^2 %peak value of the probability density function
    Particle_velocity=sqrt(2*E/m) %particle velocity
    t = linspace(0,5,100); %Time vector
    x=0:Lx/100:Lx;
    y=0:Ly/100:Ly;

    for ii=1:1:length(x)
        for jj=1:1:length(y)
            psi(ii,jj)=A*sin(kx*x(ii)).*sin(ky.*y(jj)); % Time independent wave function
        end
    end
    
    for kk=1:1:length(t)
        phi(kk)=exp(-j.*w.*t(kk)); % Time dependent wave function
        xx=psi.*phi(kk);
        surf (x,y,real(xx)); % 2DPlotting
        xlim([0 Lx]), ylim([0 Ly]), zlim([-A A]); %Axes range setting
        title('Wave Function for a Particle in a 2D Box')
        xlabel('Length of the quantum well')
        ylabel('Width of the quantum well')
        zlabel ('Magnitude of the wave function')% Title
        drawnow
        frame = getframe(1);
        im = frame2im(frame);
        [Q,map] = rgb2ind(im,256);
        outfile = '2DParticle44.gif'; % FIle name to save the generated .gif file
        if n==1
            imwrite(Q,map,outfile,'gif','LoopCount',Inf,'DelayTime',0);
        else
            imwrite(Q,map,outfile,'gif','WriteMode','append','DelayTime',0);
        end
    end
end