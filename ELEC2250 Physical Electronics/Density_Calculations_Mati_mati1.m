%% Matlab Code to Calculate and Show Crystalline properties of Germanium
% ELEC-2250 S2020
% Lab assignment 1
%
clear all; %Deletes all variables
close all; % Closes all figure windows
clc; %Clears the command window
%
Lattice_constant=5.658e-8; % In Centimeters

% Calculting number of atoms in (100) fcc
atomshundred = 1/8*4 + 1;

% Calculating Surface Density
SurDen = atomshundred/Lattice_constant^2;

% Calculate number of atoms per unit cell
Number_of_atoms_per_unit_cell=8*(1/8)+6*(1/2)+4 ;

% Calculate the volume of a unit cell
volume_of_unit_cell = (Lattice_constant)^3;

% Calculate atomic density
Atomic_density = Number_of_atoms_per_unit_cell/volume_of_unit_cell;

%Mass density
Molar_weight=72.64 %g/mole
Avogadro_number=6.023e23;
Mass_Density=Atomic_density*Molar_weight/Avogadro_number

% Fraction occupied by atoms
Atom_radius=Lattice_constant*sqrt(3)/8; % Atom radius=nearest atom distance
Atom_sphere_volume=4/3*pi*(Atom_radius)^3;
Fraction_occupied=8*Atom_sphere_volume/volume_of_unit_cell

% Display results in pop-up text box
message=sprintf ('Material: Germanium\n\nMass Density of Germanium: %.2fg/cm^3 \n\nFraction occupied by atoms: %.2f \n\nAtomic_density: %.2fatoms/cm^3 \n\nSurface Density(100): %.2f atoms/cm^2\n\nName: Emmanuel Mati\n\nStudent Number: 104418019\n\n',Mass_Density,Fraction_occupied,Atomic_density,SurDen); % format data into string
uiwait (msgbox(message,'Assignment1')); % display string in message box
