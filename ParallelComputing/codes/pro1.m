clear;
%  T is the temprature, the third dimension represents different expenriment.
%  H is external field
T = 0.5:0.01:4;
Thread = size(T,2);
H = zeros(Thread,1);
T = permute(T,[1,3,2]);
H = permute(H,[3,2,1]);
main;
%% Step 4: caculate the averange internal energy, u, and the specific heat, c.
U = sumH ./ (Times - Accepttime);
C = Kb ./ T ./ T .* (sumH2 ./ (Times - Accepttime) - U .* U);
u = U ./ Size2;
c = C ./ Size2;
u = permute(u,[3,2,1]);
T = permute(T,[3,2,1]);
c = permute(c,[3,2,1]);
%% Step 5: plot picture.
plot(T,u);
saveas(gcf,"Tu.fig");
plot(T,c);
saveas(gcf,"Tc.fig");
