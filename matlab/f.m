function l = f(D, x)
    l = D(x(1), x(end));
    
    for i = 1:length(x) - 1
        l = l + D(x(i), x(i + 1));
    end
end