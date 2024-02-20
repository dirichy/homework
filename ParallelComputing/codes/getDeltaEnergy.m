%% This function is to caculate the change of energy after convert a point. 
%  Input  grid: the grid before change
%            J: the spin-spin interaction
%            H: the external field
%         Size: the size of the grid
%         coordinate: the coordinate of the converted point. 
%  Output  DeltaEnergy: The change of the energy. 

function DeltaEnergy = getDeltaEnergy(Size, grid, J, H, coordinate)
%% Step 1: caculate the change of external energy
 DeltaExternalEnergy = 2 * H .* grid(coordinate(1),coordinate(2),:);
%% Step 2: caculate the change of interaction energy
 SurroundMagnet = grid(mod(coordinate(1),Size)+1,coordinate(2),:) + ...
                  grid(coordinate(1),mod(coordinate(2),Size)+1,:) + ...
                  grid(mod(coordinate(1)-2,Size)+1,coordinate(2),:) + ...
                  grid(coordinate(1),mod(coordinate(2)-2,Size)+1,:);
 DeltaInternalEnergy = 2 * J * SurroundMagnet .* grid(coordinate(1),coordinate(2),:);
 %% Step 3: caculate the total change of energy
 DeltaEnergy = DeltaExternalEnergy + DeltaInternalEnergy;
end