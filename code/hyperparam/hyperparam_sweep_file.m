%% sweep
%(18,8) (16,10) (14,12) (12,14)
sb_size_all = [20, 18, 16, 14, 12];% 15%[18, 20]%[12,14,16,18, 20];
d_size_all = [6, 8, 10, 12, 14];%[4, 8, 10];%[2, 6, 10]%[2, 4, 6, 8, 10];
k = 500;

if length(sb_size_all ~= d_size_all)
    error('lengths must be equal - change in interface')
end

for i = 1:length(sb_size_all)
    sb_size = sb_size_all(i);
    d_size = d_size_all(i);
    
    probFile = '~/applymask_1.outProbcube-TRAINING.mat';
    OMP_ProbMap_deploy(probFile, 0.4, sb_size, d_size, k, ['paint_',num2str(sb_size), '_', num2str(d_size), '.mat'], ['centroid_',num2str(sb_size), '_', num2str(d_size), '.mat']);
    
end
