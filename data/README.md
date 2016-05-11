# Downloading Image Data and Annotated Volumes #

This repo contains manually annotated (training and test) volumes of X-ray microtomography data. Currently, we have these volumes saved in matfiles, however we plan to include other formats in a future release. Further details about the data collection and methods use to annotate these volumes can be found at https://arxiv.org/abs/1604.03629

If you have any questions, please contact Eva Dyer at edyer{at}northwestern{dot}edu. 

***
If you use any of the datasets contained in this repository, please cite the following preprint:

__Dyer, Eva L., et al. "Quantifying mesoscale neuroanatomy using X-ray microtomography." arXiv preprint arXiv:1604.03629 (2016).__

***
## What's available ##
* Each folder in this repo contains some amount of X-ray image data and manual annotations. To start, check out V1. More details about this volume are provided below. 
* V0, V1, V2, V3 are all different (non-overlapping) subvolumes we labeled within an unsectioned cubic mm volume of mouse cortex. 
- V1 is the largest annotated volume (300 x 300 x 100) and currently the only volume that we have full (dense) reconstructions of cells and vessels. 
- V0 is a smaller cube in the middle of V1 for which we have two annotations from different annotators (A1 and A2).
- V2 can be used as a small test set for cell detection algorithms (full cell bodies, some vessels).
- V3 was the final held out test set that we used to evaluate xbrain (only cell centroids, not full cell bodies).
* To download the annotations from all training volumes, go to CombinedMats folder and download 'AllGroundTruthVolumes.mat'

***
## Information about Volume 1 (V1) ##

__Details of volume__: micro-CT data collected from 2-BM at Argonne National Laboratory. 
* The image data is a 300 x 300 x 100 voxel subvolume of a cubic mm volume of mouse somatosensory cortex (S1).
* The resolution is 0.65 um isotropic (each voxel = 0.65x0.65x0.65 um^3) 

__Image Data (imgdata_gt.mat)__: 
* IM is a 300x300x100 array containing the image data (8 bit format).

__Manual annotation (Anno-V1-A1.mat)__:
* Nmap0 is a 300x300x100 array containing non-zero labels for all voxels that are labeled (by A1) as cells
* Vmap0 is a 300x300x100 array containing non-zero labels for all voxels that are labeled (by A1) as vessels

__Cell centroids (ReconMap-V1-A1.mat)__:
* Centroids_ed0 is a 3x321 matrix containing the centroid of each labeled cell body
* ReconMap_ed0 is a 300x300x100 array containing non-zero labels for all detected cells (each cell has a unique label, starting with label = 1)

## Example - Training and test data to evaluate cell counting algorithms
__(1) Load the raw image data and location of all cells in the ground truth volume V1__
```matlab
load('/data/groundtruth/V1/traindata-celldetect-V1')
```
This mat file contains the following: 
* IM contains the raw data from the image volume V1 (300x300x100 pixels)
* Centroids_gt is a 3x321 matrix containing the (x,y,z) centroid of all __manually labeled__ cell bodies in V1 (in global coordinates). This list of centroids was manually curated to ensure accuracy. 
* Centroids_xb is a 3x302 matrix containing the (x,y,z) centroid of all __detected__ cell bodies in V1 (in global coordinates) using xbrain's cell detection method.

__(2) Load the test set (raw data + ground truth centroids) (V3)__
```matlab
load('/data/groundtruth/V3/traindata-celldetect-V3.mat')
```
This mat file contains the following:
* IM3 contains the raw data from the image volume V2 (200x200x200 pixels). 
* Centroids_gt3 is a 3x291 matrix containing the (x,y,z) centroid of all __manually labeled__ cell bodies in V1 (in global coordinates). This set of labels has not been manually curated to ensure accuracy. We simply load the annotated nii files for this volume (located in /data/groundtruth/V3) and simply find connected components in the annotated volume.


