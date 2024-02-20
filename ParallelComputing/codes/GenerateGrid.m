function grid = GenerateGrid(Size,Thread)
grid = rand(Size,Size,Thread);
grid = grid > 0.5;
grid = 2 * grid - ones(Size,Size,Thread);
end
