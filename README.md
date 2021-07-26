# MVP-inflight-behavior
Code for MVP inflight behavior
Spaceflight Video Analysis of Drosophila melanogaster Matlab Code Notes

The following document outlines how four Matlab codes interact to obtain the results reported in:
Artificial Gravity Delays Space-induced Neurological Deficits in Drosophila melanogaster (Mhatre and Iyer et al. 2021)
The four Matlab codes are stored in four separate files and are as follows:
1.	Importfile
2.	Extracting_images
3.	Background_intensity
4.	Gallery_analysis
# General Notes:
•	A very specific file naming convention was used in the collection and storage of the videos. This is reflected in each code. Should the naming convention change, the code must also be adjusted.
•	Each code makes use of DIP Image, which may be stored differently depending on the individual computer being used for analysis. The file path for this library should be adjusted in each code.
•	There are line-by-line comments highlighting each step of the programs. They should be referred to for more information on each.
# Importfile
This code was generated by Matlab and is used in the Extracting _images code to open video files. This code is not used on its own.
Extracting_images
This code is used first to create maximum projection images from videos. The videos of interest should be copied into the “extracting_images” folder using the correct naming convention. The images that are produced will be saved in the same folder. Also in this folder is a copy of the importfile code which is called upon within the extracting_images code.
# Background_intensity
This code is used to find the background intensity of the images created by extracting_images. Several images showing only the background (no flies) should be saved in this folder (these were found within the first several days of video recording when flies have not yet entered the chambers of interest). This code finds the background intensity of each image and averages it. This value is then used in the Gallery_analysis to normalize the intensity of each image created from videos with flies present (manually inputted to Gallery_analysis where instructed to by line-by-line comments). 
# Gallery_analysis
This code finds the intensity of each image and stores it in an array. This array can be exported for statistical analysis. Furthermore, heatmaps of intensity (over time, since image files are ordered by date using the naming convention) are created along with collages of the original images for visual inspection and interpretation. Images of interest should be separated into folders by module, and each of these folders should be copied into the Gallery_analysis folder prior to use. 

