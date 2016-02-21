function Centroids = celldetect2centroids(foldername,maxnum)

if ~isempty(foldername)
    cd(foldername)
end

if nargin<2
    maxnum = 10;
end

listing_C1 = dir('*CellDetection_1.centroidOut*.mat');
listing_paint1 = dir('*CellDetection_1.paintOut*.mat');
Num = length(listing_C1);

Centroids =[];
for i=1:min(Num,maxnum)
    load(listing_paint1(i).name)
    xyzOffset = cube.xyzOffset;
    load(listing_C1(i).name)
    N = size(C1,2);
    C2 = zeros(3,N);
    C2(1,:) = C1(1,:) + xyzOffset(1).*ones(1,N);
    C2(2,:) = C1(2,:) + xyzOffset(2).*ones(1,N);
    C2(3,:) = C1(3,:) + xyzOffset(3).*ones(1,N);
    Centroids = [Centroids, C2];
end


end