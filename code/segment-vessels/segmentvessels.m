function segmentvessels(inProbMap,ptr,dilatesz,minsize,outVesselMap)
% inProbMap = 'Ilastikpixel_1.output_filename_format-029.h5'

hh = h5read(inProbMap,'/exported_data');
bsz = 20;

Vmap = (squeeze(hh(2,bsz+1:end-bsz,bsz+1:end-bsz,6:end-bsz))>ptr);
Vmap2 = imdilate(Vmap,strel3d(dilatesz));
[~,~,Vmap] = removesmallcc(Vmap2,minsize);

save(outVesselMap,'Vmap')

end