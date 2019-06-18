%% Load

tsp = readtable(['resources/txt/' name '.txt']);

%% Computations

% Distances
n = size(tsp, 1);
D = zeros(n);

coo = tsp{:, 2:end};

tic
for i = 1:n
    for j = (i + 1):n
        D(i, j) = euclidean(coo(i, :), coo(j, :));
        D(j, i) = D(i, j);
    end
    D(i, i) = 2 * max(D(i, :));
end
toc

%% Save

if ~exist('products', 'dir')
    mkdir products;
    mkdir products/mat;
elseif ~exist('products/mat', 'dir')
    mkdir products/mat;
end

save(['products/mat/' name '.mat'], 'tsp', 'n', 'D');

%% Functions

function d = euclidean(c1, c2)
    d = sum((c1 - c2).^2, 2).^(1 / 2);
end