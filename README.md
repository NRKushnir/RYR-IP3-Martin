# RYR - IP3 Structure Count Batch Processing 5x5 ROIs

This script is designed to process data exported from the AIVIA software (DRVISION Technologies), which is used to count protein structures within 2D images.

This batch processing script is designed to optimize processing time for bulk datasets. Specifically, it processes two types of data sets—IP3R and RYR protein structures within murine smooth muscle cells (SMCs)—each divided into two subsets: WT and KO. Each subset includes three replicates, with three data categories per replicate (free, cluster, and total).

The script processes the initial input data by extracting specific columns from the original .csv file to create a new file. The targeted columns and labels may vary across datasets and should be adjusted accordingly. The extracted values, originally in pixel format, are converted to microns using a provided pixel-to-micron conversion factor specific to the images. This factor must be updated when applied to different datasets. The processed data is then used to generate ROIs (regions of interest) based on the x,y coordinates of each point. Each point is assigned to an ROI depending on its location within the image, which is divided into a 5x5 grid of 25 equal-sized segments. 

Safeguards are in place to ensure accurate processing, such as validating that the required files exist and that the ROIs are not empty. The .csv file is converted into an .xlsx file for easier viewing. The output includes the area of each ROI to confirm equal division, the number of structures within each ROI, and whether an ROI is empty.

Additional functions of the script include proper labeling and sample differentiation to ensure accurate data processing.

The final output consists of the following files:

A .xlsx file containing the selected columns of interest, including structure number, area, and x,y coordinates.
A processed .xlsx file detailing the positions of structures within the grid and the area of each ROI.
A counts .xlsx file indicating the number of structures in each ROI and whether any ROIs are empty.




