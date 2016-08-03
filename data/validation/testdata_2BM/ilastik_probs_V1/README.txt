The test data ‘Ilastikpixel_trainingcube.h5’ is of size (Nz,Ny,Nx,3). 


To visually inspect the probability channels:
(1) Download and open Fiji (Just imageJ)
(2) File > Import > HDF5
(3) Select ‘Ilastikpixel_trainingcube.h5’ file for import
(4) Click on dataset under data set path (125 x 340 x 340 x 3)
(5) Load as… Individual hyper stacks (custom layout)
(6) For data set layout, type zyxt
(7) Click Load
(8) To see probability maps for different classes, scroll along bottom 
(First channel = background class, Second channel = vessel class, Third channel = cell class) 