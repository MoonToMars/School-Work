%%Emmanuel Mati
% ELEC-2250 S2020
% Lab assignment 4
% Resistivity and Mobility calculations for different doping concentrations

close all
clear all
clc

% N is doping concentration
% rn - resistivity of n-type
% rp - resistivity of p-type
% mun - Electron Mobility
% mup - Hole mobility

% Resistivity calculation using empirical method; Equation (1)
q=1.6e-19; % Electron charge
N = logspace(14,20); %Doping concentration
rn = (3.75e15 + N.^0.91)./(1.47e-17*N.^1.91 + 8.15e-1*N); %Empirical equation for n type resitivity
rp = (5.86e12 + N.^0.76)./(7.63e-18*N.^1.76 + 4.64e-4*N); %Empirical equation for p type resitivity
semilogx(N,rn,'b',N,rp,'r') %Plot using a semilog scale

title('Resistivity versus Doping (Empirical)')
ylabel('Resistivity (ohm-cm)')
xlabel('Doping Concentration cm-3')
text(1.1e14,12,'N-type')
text(3.0e14,50,'P-type')

% Mobility calculation using empirical method; Equation (2)

NDref=1.3e17; %Table 1 variable
NAref=2.35e17; %Table 1 variable
mu_n_min=92; %Table 1 variable
mu_p_min=54.3; %Table 1 variable
mu_n_0=1268; %Table 1 variable
mu_p_0=406.9; %Table 1 variable
alpha_n=0.91; %Table 1 variable
alpha_p=0.88; %Table 1 variable

mu_n=mu_n_min+mu_n_0./(1+(N/NDref).^alpha_n); %Equation (2) for electron
mu_p=mu_p_min+mu_p_0./(1+(N/NAref).^alpha_p); %Equation (2) for holes
figure
semilogx(N,mu_n,'b',N,mu_p,'r')
text(8.0e16,1000,'Electron Mobility')
text(5.0e14,560,'Hole Mobility')
title('Mobility versus Doping (Empirical)')
xlabel('Doping Concentration in cm-3')
ylabel('Bulk Mobility (cm2/v.s)')

%Resistivity calculation using analytical method; Equation (4)
sigma=q*N.*mu_n; %Equation (4) for electrons (neglecting hole concetration)
rhon=1./sigma;

sigma=q*N.*mu_p; %Equation (4) for holes (neglecting electron concetration)
rhop=1./sigma;
figure
semilogx(N,rhon,'b',N,rhop,'r')
title('Resistivity versus Doping (Analytical)')
ylabel('Resistivity (ohm-cm)')
xlabel('Doping Concentration cm-3')
grid on;
text(1.1e14,12,'N-type')
text(3.0e14,50,'P-type')


%Comparison Code
figure
%Graph Comparison
semilogx(N,rhon,'b',N,rhop,'r',N,rn,'c',N,rp,'m')
title('Resistivity versus Doping (Analytical and Empirical Comparison)')
ylabel('Resistivity (ohm-cm)')
xlabel('Doping Concentration cm-3')
grid on;
text(1.1e14,12,'N-type')
text(3.0e14,50,'P-type')
legend('Empirical N-type','Empirical P-type','Analytical N-type','Analytical P-type')

%Displaying the formula that was used to compare the graphs
disp('Empirical and Analytical concentration comparison percentages = (1 - (analytical/empirical)) * 100%');

%Percentage Comparison Code
figure
%Graph Comparison using the percentage values
xx = ((rn - rhon)./rn)*100;
yy = ((rp - rhop)./rp)*100;
semilogx(N,xx,'b', N, yy, 'r')
title('Analytical and Empirical Resistivity Percentage Comparison')
ylabel('Percentage %')
xlabel('Doping Concentration cm-3')
grid on;
legend('N-type','P-type')


%Comparing specific n-type points from question 2
e1 = (1-(9.325/9.336))*100;
e2 = (1-(0.5048/0.5054))*100;
e3 = (1-(0.03666/0.03669))*100;
fprintf('\nUsing the values obtained in question 2, the N-type empirical values \nare greater than the analytical values for doping concentrations of 5e14, 1e16, 4e17 by:\n %f%% \n %f%% \n %f%%\nrespectively\n',e1, e2, e3)

%Comparing specific p-types points from question 2
a1 = (1-(27.44/26.05))*100;
a2 = (1-(1.44/1.549))*100;
a3 = (1-(0.07437/0.1154))*100;
fprintf('\nUsing the values obtained in question 2, the P-type empirical values \nare greater than the analytical values for doping concentrations of 5e14, 1e16, 4e17 by:\n %f%% \n %f%% \n %f%%\nrespectively\n',a1, a2, a3)


%Part 4 & 5
T = [400, 500, 900, 1500, 3000]; %Temperature Variables

%Scaling table 1 values for different temperatures
NDref=1.3e17*(T./300).^(2.4);
NAref=2.35e17*(T./300).^(2.4);
mu_n_min=92*(T./300).^(-0.57);
mu_p_min=54.3*(T./300).^(-0.57);
mu_n_0=1268*(T./300).^(-2.33);
mu_p_0=406.9*(T./300).^(-2.23);
alpha_n=0.91*(T./300).^(-0.146);
alpha_p=0.88*(T./300).^(-0.146);

%Calculations for the various concentrations at different temperatures
mu_n = mu_n_min(1) + (mu_n_0(1)./(1 + (N/NDref(1)).^(alpha_n(1)))); %mobility of n-type
mu_n400= mu_n;%mobility of n-type
mu_p = mu_n_min(1) + (mu_p_0(1)./(1 + (N/NAref(1)).^(alpha_p(1)))); %mobility of p-type
mu_p400 = mu_p;%mobility of p-type
rn400 = 1./(q*mu_n.*N);%Resistivity for n type
rp400 = 1./(q*mu_p.*N);%Resistivity for p type

mu_n = mu_n_min(2) + (mu_n_0(2)./(1 + (N/NDref(2)).^(alpha_n(2))));
mu_n500= mu_n;
mu_p = mu_n_min(2) + (mu_p_0(2)./(1 + (N/NAref(2)).^(alpha_p(2))));
mu_p500 = mu_p;
rn500 = 1./(q*mu_n.*N);
rp500= 1./(q*mu_p.*N);

mu_n = mu_n_min(3) + (mu_n_0(3)./(1 + (N/NDref(3)).^(alpha_n(3))));
mu_n900= mu_n;
mu_p = mu_n_min(3) + (mu_p_0(3)./(1 + (N/NAref(3)).^(alpha_p(3))));
mu_p900 = mu_p;
rn900 = 1./(q*mu_n.*N);
rp900 = 1./(q*mu_p.*N);

mu_n = mu_n_min(4) + (mu_n_0(4)./(1 + (N/NDref(4)).^(alpha_n(4))));
mu_n1500= mu_n;
mu_p = mu_n_min(4) + (mu_p_0(4)./(1 + (N/NAref(4)).^(alpha_p(4))));
mu_p1500 = mu_p;
rn1500 = 1./(q*mu_n.*N);
rp1500 = 1./(q*mu_p.*N);

mu_n = mu_n_min(5) + (mu_n_0(5)./(1 + (N/NDref(5)).^(alpha_n(5))));
mu_n3000= mu_n;
mu_p = mu_n_min(5) + (mu_p_0(5)./(1 + (N/NAref(5)).^(alpha_p(5))));
mu_p3000 = mu_p;
rn3000 = 1./(q*mu_n.*N);
rp3000 = 1./(q*mu_p.*N);

figure
semilogx(N ,rn400, N, rn500, N, rn900, N, rn1500, N, rn3000, N ,rp400, '--', N, rp500, '--', N, rp900, '--',N, rp1500,'--', N, rp3000, '--') %Plot out concentrations based on temp
title('Resistivity versus Doping at different Temps(400K, 500K, 900K, 1500K, 3000K)')
ylabel('Resistivity (ohm-cm)')
xlabel('Doping Concentration cm-3')
legend('400K N-type','500K N-type','900K N-type','1500K N-type','3000K N-type','400K P-type','500K P-type','900K P-type','1500K P-type','3000K P-type')
grid on;

figure
semilogx(N ,mu_n400, N, mu_n500, N, mu_n900, N, mu_n1500, N, mu_n3000, N ,mu_p400, '--', N, mu_p500, '--', N, mu_p900, '--',N, mu_p1500,'--', N, mu_p3000, '--') %Plot out concentrations based on temp
title('Mobility versus Doping at different Temps(400K, 500K, 900K, 1500K, 3000K)')
ylabel('Bulk Mobility (cm2/V-s))')
xlabel('Doping Concentration cm-3')
legend('400K N-type','500K N-type','900K N-type','1500K N-type','3000K N-type','400K P-type','500K P-type','900K P-type','1500K P-type','3000K P-type')
grid on;

%End of codes