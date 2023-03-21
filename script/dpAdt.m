% Function to calculate reactant partial pressure for the ALD model. 
% Used in ALDmodel.m and ALDfilmthickness.m

% Written by Emma Verkama in July-August 2019, by request of prof. R.L. Puurunen

% Copyright 2023 (c) Emma Verkama and Riikka Puurunen, Aalto University. See README.md for details. 

% Based on Ylilammi, M., Ylivaara, O.M.E. and Puurunen, R.L., Modeling
% growth kinetics of thin films made by atomic layer deposition in lateral
% high-aspect-ratio structures, J. Appl. Phys. 123 (2018) 205301 (8p.) 
% DOI: 10.1063/1.5028178

%%
function pressure = dpAdt(t,pA_prev)
global h vA DKn H W T pA0 pI MA MI dA dI N0 R kb K q c Q x

pAlist = zeros(length(x),1); %Initiating pressure array

h = 2/(1/H + 1/W); %m, Hydraulic diameter  
DKn = h*(8*R*T/(9*pi*MA))^(1/2);% m2/s Diffusion constant in molecular flow

for i = 1:length(x)
    
        pA = pA_prev(i); %Uses pressure one from one time step earlier.
        
        %Mass transfer and x_s:
        zA= pi/4*(dA+dI)^2*((8*R*T/pi*(1/MA + 1/MI))^(1/2))*pI*N0/(R*T)+pi*(dA)^2*((16*R*T/(pi*MA))^(1/2))*pA*N0/(R*T); %1/s, collision rate
        DA = 3*pi*(vA^2)/(16*zA); %m2/s, Gas-phase diffusion constant of A molecules
        Deff = 1/(1/DA + 1/DKn); %m2/s, Effective diffusion constant
        D = pA0*H*Deff/(q*kb*T*(1-(log(K*pA0+1))/(K*pA0))); %m2/s, longitudinal diffusion constant
        x_s = sqrt(D*t);

        %% Defining x_t:
        aux = sqrt(h*N0*Deff/(4*R*T*c*Q)); %auxiliary variable
        if x_s > aux
            x_t = x_s - aux;
        else
            x_t = 0;
        end
        %% Calculating pA
        if x(i) < x_t
            pA = pA0*(1-x(i)/x_s);
        else 
            pt = pA0*(1-x_t/x_s);
            pA= pt*exp(-(x(i)-x_t)/(x_s-x_t));
        end
        pAlist(i) = pA;

end

pressure = pAlist; % Returns calculated pressures.
end