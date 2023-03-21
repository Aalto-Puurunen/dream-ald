% Function for ODE solver to calculate surface coverage for the ALD model. 
% Used in ALDmodel.m and ALDfilmthickness.m

% Written by Emma Verkama in July-August 2019, by request of prof. R.L. Puurunen

% Copyright 2023 (c) Emma Verkama and Riikka Puurunen, Aalto University. See README.md for details. 

% Based on Ylilammi, M., Ylivaara, O.M.E. and Puurunen, R.L., Modeling
% growth kinetics of thin films made by atomic layer deposition in lateral
% high-aspect-ratio structures, J. Appl. Phys. 123 (2018) 205301 (8p.) 
% DOI: 10.1063/1.5028178

%%
function theta = dthetadt(t,a)
global q c Q x Pd
persistent pA
    if isempty(pA) %For t=0
        pA_prev = zeros(length(x),1);
    else
        pA_prev = pA; % Pressures of the previous time step
    end 
theta1 = a; %Initial conditions. Same for all locations.     
pA = dpAdt(t,pA_prev); %Calculating pressures corresponding to time step

theta = zeros(length(x),1); %Initializing matrix
for i = 1:length(x) %calculating surface coverage for each location
    theta(i,1)= (c*Q*pA(i)/q - (c*Q*pA(i)/q + Pd)*theta1(i))';
end
