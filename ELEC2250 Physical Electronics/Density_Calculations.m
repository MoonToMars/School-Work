%% Lab Assignment 1; calculing atomic and surface density of Germanium
% Author: Emmanuel Mati
% ELEC2250 S2020

clear all;
close all;
clc;

% Declaring Germanium lattice constant
GermLatConst = 5.658e-8;

% Calculating number of atoms in fcc unit cell
atoms = 1/8*8 + 1/2 * 6 + 4;

% Calculting number of atoms in (100) fcc
atomshundred = 1/8*4 + 1;

% Calculating Surface Density
SurDen = atomshundred/GermLatConst^2;

% Volume of fcc
volume = GermLatConst^3;

% Atomic Dencity of FCC
aden = atoms/volume;

% Molar weight of Germanium and Avogadro's
molWeight = 72.64;
Avogadro=6.023e23;

% Calculating mass density 
MassDensity = molWeight*aden/Avogadro;

% Atomic Radius
AtomicRad = GermLatConst*sqrt(3)/8;

% Atomic volume of sphere
SphereVol = 4/3 * pi * (AtomicRad)^3;

% Calculating Fraction occupied
Fracupied = 8*SphereVol/volume;

% Text Value
pop = sprintf('Material: Germanium\nMass Density: %.2f g/cm^3\nFraction occupied by atoms: %.2f\nAtomic Density: %.2f atoms/cm^3\nSurface Density(100): %.2f atoms/cm^2\nName: Emmanuel Mati\nStudent Num: 104418019\n', MassDensity, Fracupied, aden, SurDen);

% Message Box
uiwait (msgbox(pop,'Assignment1'));