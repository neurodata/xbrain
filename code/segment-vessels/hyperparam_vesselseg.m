% hyperparameter search on V0-A0
load('/Users/evadyer/Documents/repos/xbrain/data/groundtruth/Anno-V0-A0.mat')

inProbMap = 'Ilastikpixel_trainingcube.h5';
outVesselMap = 'outvessels';

ptrvec = 0.6:.02:0.96;
dilatevec = 4:2:8;
minsize = 200;

Err = zeros(length(ptrvec),length(dilatevec));
for i=1:length(ptrvec)
    for j=1:length(dilatevec)
        segmentvessels(inProbMap,ptrvec(i),dilatevec(j),minsize,outVesselMap)
        load(outVesselMap)
        tmperr = compute_segmentmetrics(Vmap0, Vmap);
        clear Vmap
        Err(i,j) = mean(tmperr);
        length(dilatevec)-j
    end
    length(ptrvec)-i
end



