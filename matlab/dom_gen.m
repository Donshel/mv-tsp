function dom = dom_gen(m)
    dom = zeros([sum(m) 1]);

    v = 1;
    i = 1;
    while v <= length(m)
       if m(v) > 0
           dom(i) = v;
           i = i + 1;
           m(v) = m(v) - 1;
       else
           v = v + 1;
       end
    end
end