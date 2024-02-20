%% this function is to caculate the energy of a grid. 
% Input: grid: the grid
%           J: the spin-spin interaction
%           H: the external field
%           Size: the size of the grid
% Output: Energy: energy of the grid


function Energy = getEnergyOfGrid(Size, grid, J, H)
 %% Step 1: Caculate the external field energy
 ExternalEnergy = -H .* sum(sum(grid));
 %% Step 2: Caculate the interaction energy
 Leftgrid = [grid(:,2:Size,:),grid(:,1,:)];
 Upgrid = [grid(2:Size,:,:);grid(1,:,:)];
 InterEnergy = -J*sum(sum(Leftgrid .* grid + Upgrid .* grid));
 %% Step 3: Caculate the total energy
 Energy = ExternalEnergy + InterEnergy;
end