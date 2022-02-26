%% Lab Assignment 2; 1D and 2D wave Function Simulation in Matlab
% Author: Emmanuel Mati
% ELEC2250 S2020

% ELEC-2250 W2020
% Lab assignment 2 Part A
% Solution of Schrödinger equation for a particle in a 1D box
%Reference; Solid state Electronic Devices, Streetman, Classnotes
% https://www.physicsforums.com/insights/visualizing-2-d-particle-box/
close all
clear all
clc
% Define constants and variables
h=6.63e-34; %Planck's constant in Joules
m=9.11e-31; % Free Electron mass
hbar=h/(2*pi);
outfile = '111DParticle.gif'; % File name to save the generated .gif file
for n=1:1:5; % Number of energy states
    Lx = 0.5e-6; %length for part 5
    x = linspace(0,Lx,500);
    t = linspace(0,1,500); %time scale)
    k = n*pi./Lx;
    E=n^2*pi^2*hbar^2/(2*m*Lx^2) % Total energy of the particle in a 1D box
    w =(hbar*k^2)/2*m % frequency from E=hf
    A = sqrt(2/Lx) % magnitude of the wave function
    PD_peak=A^2 %peak value of the probabilitydensity function
    Particle_velocity=sqrt(2*E/m) %particle velocity
    w = hbar*k.^2/2*m; % solving for frequency; E=hbar*w; =hbar^2*k^2/(2*m).=>w=hbar*k.^2/2*m

    % Define the position and time functions
    for ii=1:1:length (x)
        psi(ii)=A*sin(k*x(ii));
    end
    
    for kk=1:1:length(t)
        phi(kk)=exp(-j*w*t(kk));
        xx(kk)=psi(kk)*phi(kk);
    end

    plot(x,real(xx))
    title('Wave function in a 1D quantum well')
    xlabel('Length of the quantum well')
    ylabel ('Magnitude of the wave function')
    drawnow
    frame = getframe(1);
    im = frame2im(frame);
    [Q,map] = rgb2ind(im,256);

    if n == 1;
        imwrite(Q,map,outfile,'gif','LoopCount',Inf,'DelayTime',0);
    else
        imwrite(Q,map,outfile,'gif','WriteMode','append','DelayTime',0);
    end
    
end