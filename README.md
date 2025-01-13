# RYR-IP3-Martin

These scripts were designed to process data exported from the AIVIA software (DRVISION Technologies), which is used to count protein structures within our 2D images.

There are two scripts: one for batch processing, which considers all data sets, and one for individual data sets, which is arbitrary and applies to only a single file. The individual data set used here was chosen solely for example purposes.

In the individual data set script, the initial input data is processed by converting pixels to microns using the provided pixel-to-micron conversion specific to our images. This conversion factor must be updated if applied to different data sets. The processed data is then converted into a .csv file and used to generate ROIs (regions of interest) that divide our 1024x1024 image into a 5x5 grid, creating 25 equal-sized segments.

The resulting .csv file can then be used in the batch processing script, which performs a series of steps to isolate the necessary columns (x and y centroids and the outlined area of each individual structure) and processes this data to generate a file. This file highlights the area of each ROI, the number of structures within each ROI, and confirmation of whether an area is empty. Note that the .csv file is optional, as the batch processing script includes functionality to generate a data sheet directly from the original export. However, the targeted columns and labels may vary for different data sets and should be adjusted accordingly.

Additional functions in the scripts include proper labeling, differentiation between samples, and safeguards to ensure accurate data processing.

The final output consists of two data sets, each divided into two subsets: WT and KO. Each subset includes three replicates, with three data categories per replicate (free, cluster, and total).
