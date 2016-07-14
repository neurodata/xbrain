function y = cell2bgSNR(IM,Seg)

bgcc = bwconncomp(Seg==1); 
bgrp = regionprops(bgcc);

cellcc = bwconncomp(Seg==2);
cellrp = regionprops(cellcc);
numsamp = length(cellcc.PixelIdxList);

BgMat = zeros(3,numsamp);
CellMat = zeros(3,numsamp);
for i=1:numsamp
    BgMat(:,i) = bgrp(i).Centroid;
    CellMat(:,i) = cellrp(i).Centroid;
end

id = zeros(numsamp,1);
for i=1:numsamp
    [~,id(i)] = min(pdist2(BgMat(:,i)',CellMat')); 
end

y = zeros(numsamp,1);
for i=1:numsamp
    y(i) = 20*log10(mean(IM(cellcc.PixelIdxList{i}))/mean(IM(bgcc.PixelIdxList{i}))); 
end


end
