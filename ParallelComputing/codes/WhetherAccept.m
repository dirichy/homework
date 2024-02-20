%% This function is to judge whether to accept the change of a point. 
%  Input  DeltaEnergy: The change of the energy
%                   T: the temprature
%                  Kb: the Boltzmann constant.
%  Outpur        Flag: 1 is accept, 0 is not accept. 
function Flag = WhetherAccept(DeltaEnergy, Kb, T,Thread)
 Flag = DeltaEnergy <= 0 | rand(1,1,Thread) < exp(-DeltaEnergy ./ (Kb .* T));
end