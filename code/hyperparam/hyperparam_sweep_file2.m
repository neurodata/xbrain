%% sweep
%(18,8) (16,10) (14,12) (12,14)
%26, 28, 30, 32, 20, 22, 24
%12-20
sb_size_all = [16, 14, 12, 20, 18, 16]%, 14, 12] %20, 18, 16, 14, 12, 20, 18, 16, 14, 12];
d_size_all =  [4,  6,  8,12, 14, 16]%, 18, 20]  %2,  4,  6,  8, 10,  4,  6,  8, 10, 12];
k = 500;


if length(sb_size_all) ~= length(d_size_all)
    error('lengths must be equal - change in interface')
end

parfor i = 1:length(sb_size_all)
    sb_size = sb_size_all(i);
    d_size = d_size_all(i);
    
    probFile = '~/code/xbrain/data/xbrain_feb20_train_probmask_cube.mat';
    OMP_ProbMap_deploy(probFile, 0.4, sb_size, d_size, k, ['paint_',num2str(sb_size), '_', num2str(d_size), '.mat'], ['centroid_',num2str(sb_size), '_', num2str(d_size), '.mat']);
    
end
