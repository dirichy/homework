clear;
%  T is the temprature, the third dimension represents different expenriment.
%  H is external field
% [T,H] = meshgrid(0.5:0.1:4,0:1:0);
[T,H] = meshgrid(1:2,0.2:0.1:0.4);
%  Because I only prepared one dimension for thread, so I need to make T and H one-dimentional.
X = size(T,1);
Y = size(T,2);
T = T(:);
H = H(:);
T = permute(T,[3,2,1]);
H = permute(H,[3,2,1]);
Thread = size(T,3);
main;
%% Step 4: caculate the averange magnet, m.
M = sumMag ./ (Times - Accepttime);
m = M ./ Size2;
%% Step 5: plot picture.
m = permute(m,[3,2,1]);
% H = permute(H,[3,2,1]);
% restore T and H as matrix
T = reshape(T,X,Y);
H = reshape(H,X,Y);
m = reshape(m,X,Y);
surf(T,H,m);
saveas(gcf,"THM.fig");
