%% Load

name = 'belgium';
file = ['products/mat/' name '.mat'];

if exist(file, 'file') == 2
    load(file);
else
    initialize;
end

%% Metropolis-Hastings

% Initialization

t = readtable(['products/txt/' name '_MV_NNA.txt']);

[x, x_min, x_i] = deal(t.x);
[l, l_min, l_i] = deal(f(D, x));

n = length(x);

% Parameters

m = 1e6;
c = min(1e6, m);
beta = 10;
beta_rel = beta * n / l;

% Algorithm

k = 1;

tic
while k < m
    if mod(k - 1, c) == 0
        I = randi([1 n], [c 2]);
    end
    
    i = I(mod(k - 1, c) + 1, 1);
    j = I(mod(k - 1, c) + 1, 2);
        
    delta = delta_f(n, D, x, i, j);
    
    a = alpha(beta_rel, delta);
    
    if a >= 1 || rand() < a
        l = l + delta;
        temp = x(i);
        x(i) = x(j);
        x(j) = temp;
        
        if l < l_min
            l_min = l;
            x_min = x;
        end
    end
    
    k = k + 1;
end
toc

%% Display

disp(['Initial length : ' num2str(l_i)]);
disp(['Best length in ' num2str(m) ' iterations : ' num2str(l_min)]);

tsp_plot(tsp{x_min, 2}, tsp{x_min, 3}, 0.1);

%% Functions

function a = alpha(beta, x)
    if x < 0
        a = 1;
    else
        a = exp(-beta * x);
    end
end

function delta = delta_f(n, D, x, i, j)
    if i == j
        delta = 0; 
        return;
    elseif i > j
        temp = i;
        i = j;
        j = temp;
    end
    
    if i == 1 && j == n
        i_m = i + 1;
        j_p = j - 1;
    elseif i == 1
        i_m = n;
        j_p = j + 1;
    elseif j == n
        i_m = i - 1;
        j_p = 1;
    else
        i_m = i - 1;
        j_p = j + 1;
    end
    
    delta = -D(x(i_m), x(i));
    delta = delta - D(x(j), x(j_p));
    
    delta = delta + D(x(i_m), x(j));
    delta = delta + D(x(i), x(j_p));
    
    if i ~= j - 1 && (i ~= 1 || j ~= n)
        delta = delta - D(x(i), x(i + 1));
        delta = delta - D(x(j - 1), x(j));

        delta = delta + D(x(j), x(i + 1));
        delta = delta + D(x(j - 1), x(i));
    end
end
