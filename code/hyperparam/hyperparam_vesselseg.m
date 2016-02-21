% Hyperparameter search for vessel segmentation 

% load ground truth A0-V0 (cells + vessels)
load('Anno-V0-A0.mat')
Vmap0(:,:,1:15)=[]; 
bsz = 20; % size of padding in each dimension       

inPMap = 'final-ilastik-probmap-vessel.mat';
outVMap = 'outvessels';

ptrvec = 0.6:.02:0.96;
dilatevec = 2:2:8;
minsize = 4000;

Err = zeros(length(ptrvec),length(dilatevec));
for i=1:length(ptrvec)
    for j=1:length(dilatevec)
        segmentvessels(inPMap,outVMap,ptrvec(i),dilatevec(j),minsize)
        load(outVMap)
        Vmap = cube.data;
        Vmap2 = Vmap(bsz+1:end-bsz,bsz+1:end-bsz,bsz+1:end-bsz); Vmap = Vmap2;
        
        % compute segmentation error
        tmperr = compute_segmentmetrics(Vmap0, Vmap);
        tmp = mean(tmperr),
        Err(i,j) = tmp;
    end
    length(ptrvec)-i
end

[~,id] = min(Err(:));
[r1,r2] = ind2sub(size(Err),id);

display(['Selected threshold: ' num2str(ptrvec(r1),2)])
display(['Selected dilate size: ' num2str(dilatevec(r2),2)])

segmentvessels(inPMap,ptrvec(r1),dilatevec(r2),minsize,outVMap)
load(outVMap); Vmap = cube.data;
Vmap2 = Vmap(bsz+1:end-bsz,bsz+1:end-bsz,bsz+1:end-bsz); Vmap = Vmap2;

