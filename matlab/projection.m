%% Load

name = '';
file = ['resources/txt/' name '.txt'];

[tsp, copy] = deal(readtable(file));

%% Equirectangular projection

R = 6371; % km

tsp.x = R * deg2rad(copy.y / 10^3);
tsp.y = R * deg2rad(copy.x / 10^3);

%% Save

writetable(tsp, file);