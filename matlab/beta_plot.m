close all;

%% Setup

set(0, 'defaultLineLineWidth', 1.3, 'defaultAxesLineWidth', 1.3);
set(0, 'defaultAxesFontSize', 14, 'defaultAxesFontName', 'Times New Roman');
set(0, 'defaultTextInterpreter', 'latex');

%% Load

name = 'belgium';
type = 'MV_HC';

file = ['products/mat/' name '.mat'];

if exist(file, 'file') == 2
    load(file);
else
    initialize;
end

t = readtable(['products/txt/' name '_' type '.txt']);

%% Parameters

m = 10^8;
Beta = [5 10 50 100].';

%% Plot

figure('Position', [100 100 900 600]);

beta = Beta(1);
metropolis_hastings;
plot(L);

hold on;

for i = 2:length(Beta)
    beta = Beta(i);
    metropolis_hastings;
    plot(L);
end

hold off;

grid on;
xlabel('$i$');
ylabel('$f(x_i)$ [km]');
lgd = legend(cellstr(num2str(Beta)), 'Interpreter', 'latex', 'Location', 'Best');
title(lgd, '$\beta$');

clearvars all;
saveas(gcf, ['products/pdf/' name '_' type '.pdf']);