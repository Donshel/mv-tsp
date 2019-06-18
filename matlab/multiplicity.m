function m = multiplicity(n, D, mult, d, filet)
    % Parameters
    
    e = 4;
    
    % Computation
    
    m = zeros(n, 1);
    
    filet.population = filet.population / sum(filet.population);
    
    for i = 1:n
        if ~isempty(find(filet.n == i, 1))
            m(i) = ceil(mult * filet(filet.n == i, :).population^(1 / 2));
        else
            m(i) = ceil(mult * e^(- 1 / sum(d .* filet.population ./ D(filet.n, i))));
        end
    end
end