%% Load

name = 'belgium';
file = ['products/mat/' name '.mat'];

if exist(file, 'file') == 2
    load(file);
else
    initialize;
end

%% Nearest neighbour algorithm

% Initialization

t = readtable(['products/txt/' name '_MV_HC.txt']);

dom = sort(t.x);
n = length(dom);

% Algorithm

x_nna = zeros(n, 1);
x_nna(1) = dom(1);
dom = dom(2:end);

tic
for j = 2:n
    [~, k] = min(D(x_nna(j - 1), dom));
    x_nna(j) = dom(k);
    dom = dom([1:k - 1, k + 1:end]);
end
toc

l_nna = f(D, x_nna);

%% Display

disp(['Nearest neighbour algorithm length : ' num2str(l_nna)]);

tsp_plot(tsp{x_nna, 2}, tsp{x_nna, 3}, 0.1);