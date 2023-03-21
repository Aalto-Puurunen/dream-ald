% ALD conformality model, film thickness
% Calculates film thickness, requires functions dpAdt.m and dthetadt.m

% Written by Emma Verkama, July-August 2019, by request of prof R.L. Puurunen.

% Copyright 2023 (c) Emma Verkama and Riikka Puurunen, Aalto University. See README.md for details. 

% Based on Ylilammi, M., Ylivaara, O.M.E. and Puurunen, R.L., Modeling
% growth kinetics of thin films made by atomic layer deposition in lateral
% high-aspect-ratio structures, J. Appl. Phys. 123 (2018) 205301 (8p.) 
% DOI: 10.1063/1.5028178

close all;
global H W T pA0 pI MA MI dA dI N0 R kb K q c Q x Pd vA
%% Constants:
N0 = 6.02214*10^23; %1/mol, Avogadro's number
R = 8.3144626; %J/molK, gas constant
kb = 1.38064852*10^-23; %m2kg/s2K, Boltzmann constant

%% Physical properties and parameters, must be provided:
T = 573.15; %K, temperature

pA0 = 147; %Pa, initial partial pressure of reactant A (TMA)
pI = 3000; %Pa, partial pressure of B (Nitrogen), assumed to stay constant

MA = 0.0749; %  kg/mol, molar mass of A (TMA), MA = 0.189679; %kg/mol (TiCl4)
MI = 0.0280134; %kg/mol, molar mass of B (Nitrogen)

dA = 591*10^-12; %m, diameter of molecule A (TMA), dA = 703.9*10^-12; %m (TiCl4)
dI = 374*10^-12; %m, diameter of molecule B (Nitrogen)

vA = (8*R*T/(pi*MA))^(1/2); %m/s, average speed of A molecules

%% Reaction kinetics (Langmuir)
%Modifications to dthetadt.m must be made if another model is used

gpc_sat = 105.6*10^-12; %m, saturated growth per cycle, Al2O3. 54.4*10^-12 used for TiO2

b_film=2; %Number of metal atoms per formula unit of film (2 for Al2O3, 1 for TiO2)
b_A=1; %Number of metal atoms in reactant molecule (1 for TMA, 1 for TiCl4)
rho= 3900; %kg/m3, density of the condensed phase (Al2O3), 3680 used for TiO2
M_film=0.10196; %kg/mol (Al2O3), 0.079866 for TiO2

q = b_film/b_A*rho*gpc_sat/M_film*N0; %m^2, adsorption density of molecules in saturation
c = 0.00572;%lumped sticking coefficient
Q = N0/sqrt(2*pi*MA*R*T); %Unit pressure
K = 219; %1/Pa, equilibrium coefficient
Pd = c*Q/(q*K); % Desorption probability in unit time


%% Time span:
t_end = 0.1; %s, desired (max) pulse length
t_span =[0.001 0.05 t_end]; %Several other pulse lengths can be simulated as well.

%% Length coordinates
x_steps = 100; %Desired amount of steps (resolution). If changed, clear workspace before running.
x_max = 200*10^-6; %m, insert desired max length
x = linspace(0,x_max,x_steps); %Equidistant points, can be changed.

%% Test structure information:
W = 0.1*10^-3; %m, width
H = 0.5*10^-6; %m,  height (at the start). If only one height tested, input value here.

%% Number of cycles:
N = 500; %Number of cycles

%% If several heights are desired, use this loop and modify accordingly. Comment away if not.
% for k = 1:4 %Number of different heights to be used
%     if k == 1 %Specify heights
%         H=0.2*10^-6;
%     elseif k == 2
%         H= 0.5*10^-6;
%     elseif k == 3
%         H = 1*10^-6;
%     else
%         H = 2*10^-6;
%     end 
%% Surface coverage for each cycle
    thetatot=zeros(length(t_span), length(x)); %Initiating matrix where the total surface coverage is stored
    for i=1:N % Solving surface coverage for each cycle:
        inittheta = zeros(1,length(x)); %Boundary conditions, no surface covered at t=0
        options = odeset('RelTol', 1e-3,'Abstol',1e-5); %Solver tolerances: as large as possible for speed, but without risking accuracy
        [t, thetat] = ode23(@dthetadt, t_span,[inittheta],options); %Calling ode23
        
        H=H-2*gpc_sat; %Updating the free channel height after each cycle
        
        if H < 0 
            break %Free channel height cannot be negative.
        end
        thetatot = thetatot+thetat; %Adding surface coverage contribution for each cycle
    end  
    %% Film thickness:
    s=thetatot.*gpc_sat; %m, Film thickness.
       
    %% Comment away if multiple heights are not simulated. Modify loop structure according to heights.
%     if k == 1     
%         H1 = s(end,:).*10^9;%nm
%     elseif k == 2
%         H2 = s(end,:).*10^9;%nm
%     elseif k == 3
%         H3 = s(end,:).*10^9;%nm
%     else
%         H4 = s(end,:).*10^9;%nm
%     end
% 
% end %Comment away if multiple heights are not simulated.

%% Plotting results:

    %For one height:  
    figure()
    plot(x.*10^6,s(end,:).*10^9, 'b', 'Linewidth',1);
    legend 'H = 0.5 \mum'

%     %For several heights:
%     figure()
%     plot(x.*10^6,H1, 'k--', 'Linewidth',1)
%     hold on;
%     plot(x.*10^6,H2, 'k-.', 'Linewidth',1)
%     hold on;
%     plot(x.*10^6,H3, 'k:', 'Linewidth',1)
%     hold on;
%     plot(x.*10^6,H4, 'k', 'Linewidth',1)
%     legend 'H = 0.2 \mum' 'H = 0.5 \mum' 'H = 1 \mum' 'H = 2 \mum'

    xlabel 'Location (\mum)'
    ylabel 'Film thickness (nm)'
    %title 'Thickness profiles, Al_2O_3'
    %grid on;
    %set(gca,'GridLineStyle',':')
    set(gca,'FontSize',14)
    set(gca,'FontName','Times')
    
    
