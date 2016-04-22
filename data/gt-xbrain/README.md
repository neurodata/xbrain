# README for /neurodata/xbrain/data #

This repo contains manually annotated (training and test) volumes of X-ray microtomography data. Currently, we have these volumes saved in matfiles, however we plan to include other formats in a future release. Further details about the data collection and methods use to annotate these volumes can be found at https://arxiv.org/abs/1604.03629

***
If you use any of these data, please cite the following preprint:
Dyer, Eva L., et al. "Quantifying mesoscale neuroanatomy using X-ray microtomography." arXiv preprint arXiv:1604.03629 (2016).

@article{dyer2016quantifying,
  title={Quantifying mesoscale neuroanatomy using X-ray microtomography},
  author={Dyer, Eva L and Roncal, William Gray and Fernandes, Hugo L and G{\"u}rsoy, Doga and Xiao, Xianghui and Vogelstein, Joshua T and Jacobsen, Chris and K{\"o}rding, Konrad P and Kasthuri, Narayanan},
  journal={arXiv preprint arXiv:1604.03629},
  year={2016}
}

***
# Information about Volume 1 (V1) #

(0) ## Size of volume ## : 300 x 300 x 100 voxels at 0.65 um isotropic

(1) Image Data (imgdata_gt.mat): micro-CT data collected from 2-BM at Argonne National Laboratory
		- IM is a 300x300x100 array containing the image data in 8 bit format

(3) Manual annotation (Anno-V1-A1.mat):
		- Nmap0 is a 300x300x100 array containing non-zero labels for all voxels that are labeled (by A1) as cells
		- Vmap0 is a 300x300x100 array containing non-zero labels for all voxels that are labeled (by A1) as vessels

(4) Cell centroids ('ReconMap-V1-A1.mat'):
		- Centroids_ed0 is a 3x321 matrix containing the centroid of each labeled cell body
		- ReconMap_ed0 is a 300x300x100 array containing non-zero labels for all detected cells 
		  (each cell has a unique label, starting with label = 1)




