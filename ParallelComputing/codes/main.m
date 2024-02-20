%% This program is used to make a 2D-Model of Ising.
%% Initialize:
%  Thread is the number of experiments
%  Kb is the Boltzmann constant.
Kb = 1;
%  Size is the size of grid.
Size = 60;
Size2 = Size * Size;
%  Times is the number of steps.
Times = 100000 * Size2;
%  J is the spin-spin interaction
J = 1;
%  Accepttime: we only use energy when time geq Accepttime
Accepttime = floor(Times * 0.8);
%  sumH2: The sum of Energy^2.
sumH2 = zeros(1,1,Thread);
%  sumH: The sum of Energy.
sumH = zeros(1,1,Thread);
%  sumMag: The sum of Mag.
sumMag = zeros(1,1,Thread);
%
%% Step 1: Generate a grid.
grid = GenerateGrid(Size,Thread);
%  Magnet: The internal Magnet of grid.
Magnet = sum(sum(grid));
%% Step 2: Initiallize. caculate energy,
Energy = getEnergyOfGrid(Size, grid, J, H);
%% Step 3: 循环
for time = 1:Times
  %% Step 3.1: Choose a point randomly.
  coordinate = ceil(rand(2,1,Thread) .* Size);
  %% Step 3.2： Caculate the DeltaEnergy.
  DeltaEnergy = getDeltaEnergy(Size, grid, J, H, coordinate);
  %% Step 3.3: judge whether to accept the change or not.
  Flag = WhetherAccept(DeltaEnergy, Kb, T,Thread);
  %% Step 3.4: If accept, change the grid and energy.
  Energy = Energy + DeltaEnergy .* Flag;
  Magnet = Magnet - 2 .* Flag .* grid(coordinate(1),coordinate(2),:);
  Flag = Flag * 2 - ones(1,1,Thread);
  Flag = - Flag;
  grid(coordinate(1),coordinate(2),:) = grid(coordinate(1),coordinate(2),:) .* Flag;
  %% Step 3.5: sum Z and uZ.
  if time > Accepttime
    sumH = sumH + Energy;
    sumH2 = sumH2 + Energy .* Energy;
    sumMag = sumMag + Magnet;
  end
  %% Step 3.5: plot picture of grid.
  if mod(time,floor(Times/100))==0
    % show the progress
    time/Times
  end
end
