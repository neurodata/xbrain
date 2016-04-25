# xbrain (code/celldetect)
***
This repository contains methods for _analyzing and quantifying neuroanatomy in X-ray microtomography images_. You can find further details about how we apply the methods in this repo to analyze mm-scale brain volumes in the following paper:

__Dyer, Eva L., et al. "Quantifying mesoscale neuroanatomy using X-ray microtomography." arXiv preprint, [arXiv:1604.03629](https://arxiv.org/abs/1604.03629) (2016).__

If you use any of the code or datasets in this repo, please cite this paper. 
Please direct any questions to Eva Dyer at edyer{at}northwestern{dot}edu.
***

### What's here... ###
* __analysis__: matlab scripts for retrieving results from OCP.
* __celldetect__: matlab code for cell detection.
* __cellsize__: matlab code for estimating the size of detected cells.
* __hyperparam__: matlab code for running hyper-parameter sweeps to optimize celldetect and vessel-segment modules.
* __masking__: matlab code for semi-supervised masking of data volumes.
* __metrics__: matlab code for computing centroid-based and pixel-wise precision and recall.
* __segment-gmm__: matlab code for segmenting foreground (cells and vessels) from the background (old version of segmentation codes). 
* __segment-vessels__: matlab code for computing vessel segmentation (from ilastik output).
* __scripts__: matlab scripts for running different segmentation and analysis modules.
* __spatialstats__: code to compute density and other spatial statistics.
* __utils__: extra helper functions needed in multiple modules.
* __visualize__: matlab and python code to visualize data + pull down a obj representation of annotations (for 3D visualization with Blender).
***
### Celldetect Module ###
The main aim of this module is to infer the position (and eventually size) of all cells in a 3D volume of image data. We assume that we already have computed a "probability map" which encodes the probability that each voxel corresponds to a cell body. 

To begin, first you must include the following folders in your path in Matlab:  
* /xbrain/code/utils
* /xbrain/code/celldetect

Second, run the script ___script_cellfinder.m___. This will run the main cell finding routine ___OMP_ProbMap.m___ on the test data in the celldetect folder. The output is a 10x4 matrix (Centroids) with the first 10 detected cells centroids (columns 1-3) and the correlation value obtain for all centroids (column 4).

##### What's included in the celldetect module #####
* __OMP_ProbMap.m__: This is the main function used for cell detection, as it implements our greedy sphere finding approach described in [Dyer et al. 2016](https://arxiv.org/abs/1604.03629). This algorithm takes a 3D probability map (the same size as the image data) as its input and returns the centroids and confidence value (between 0-1) of all detected cell bodies.
* __cellfinder_nd.m__: This is the function we use to implement our greedy sphere finder algorithm for datasets in NeuroData and push the resulting annotations back to the NeuroData server.
* __compute3dvec.m__: This function places an input 3D template (vec) at a fixed position (which_loc) in a bounding box of width = Lbox*2 + 1. 
* __convn_fft.m__: This computes a n-dimensional convolution in the Fourier domain (uses fft rather than spatial convolution to reduce complexity).
* __create_synth_dict.m__: This function creates a collection of spherical templates of different sizes. The output is a dictionary of template vectors, of size (Lbox^3 x length(radii)), where Lbox = box_radius*2 +1 and radii is an input to the function which contains a vector of different sphere sizes.
***
