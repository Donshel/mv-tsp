function tsp_plot(x, y, alpha)
    p = plot(x, y, 'k-', 'linewidth', 1.5);
    p.Color(4) = alpha;
    axis equal;
    axis off;
end