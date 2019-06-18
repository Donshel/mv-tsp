%% Load

name = 'belgium';
file = ['products/mat/' name '.mat'];

if exist(file, 'file') == 2
    load(file);
else
    initialize;
end

%% Plot

close all;

types = {
    'CH'; 'CH_MH_6'; 'CH_MH_8'; 'NNA'; 'NNA_MH_6'; 'NNA_MH_8';
    'MV_HC'; 'MV_HC_MH_8'; 'MV_NNA'; 'MV_NNA_MH_8';
    'MV_HC_filet'; 'MV_HC_filet_MH_8'; 'MV_NNA_filet'; 'MV_NNA_filet_MH_8'
};

disp(['Map : ' name]);

for i = 1:length(types)
    type = types{i};
    
    if ~exist(['products/txt/' name '_' type '.txt'], 'file')
        continue;
    end
    
    t = readtable(['products/txt/' name '_' type '.txt']);
    x = t.x;
    
    disp([type ' length : ' num2str(f(D, x))]);
    
    if contains(type, 'MV')
        tsp_plot(tsp{x, 2}, tsp{x, 3}, 0.1);
    else
        tsp_plot(tsp{x, 2}, tsp{x, 3}, 1);
    end
    
    set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0 0 8 6]);
    print('-djpeg', ['products/jpg/' name '_' type '.jpg'], '-r600');
end