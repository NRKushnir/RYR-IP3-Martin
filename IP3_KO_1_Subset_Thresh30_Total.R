##Script 1: Process Input Data

library(dplyr)
library(readr)

# Define the file path for the raw input
file_path <- "/Users/nicolekushnir/Desktop/IP3_KO_1_Subset_Thresh30_Total.txt"

# Define the output path for the processed input data
processed_data_file <- "/Users/nicolekushnir/Desktop/IP3_KO_1_Subset_Thresh30_Total_processed_data.csv"

# Check if the input file exists
if (!file.exists(file_path)) {
  cat("File not found at the specified path.\n")
} else {
  tryCatch({
    # Read the input file
    data <- read_delim(file_path, delim = "\t", col_names = TRUE)
    
    # Rename columns
    colnames(data) <- c("Outline_Name", "Outline_Area", "X_Coordinate", "Y_Coordinate")
    
    # Remove leading/trailing whitespace from the first column
    data <- data %>%
      mutate(Outline_Name = trimws(Outline_Name))
    
    # Convert coordinates to pixel units
    data <- data %>%
      mutate(
        Pixel_X = floor(X_Coordinate / 0.114),
        Pixel_Y = floor(Y_Coordinate / 0.114)
      )
    
    # Define grid size
    grid_size <- 1024 / 5  # Divide the 1024x1024 image into a 5x5 grid
    
    # Assign grid positions
    data <- data %>%
      mutate(
        Grid_X = floor(Pixel_X / grid_size),
        Grid_Y = floor(Pixel_Y / grid_size)
      )
    
    # Save the processed data to a CSV file
    write_csv(data, processed_data_file)
    cat(sprintf("Processed input data saved to: %s\n", processed_data_file))
  }, error = function(e) {
    cat(sprintf("Error processing input file: %s\n", e$message))
  })
}


##Script 2: Calculate ROI Counts
library(dplyr)
library(readr)

# Define the file path for the processed input data
processed_data_file <- "/Users/nicolekushnir/Desktop/IP3_KO_1_Subset_Thresh30_Total_processed_data.csv"

# Define the output path for the ROI counts
output_file <- "/Users/nicolekushnir/Desktop/IP3_KO_1_Subset_Thresh30_Total_outline_counts.csv"

# Check if the processed data file exists
if (!file.exists(processed_data_file)) {
  cat("Processed data file not found. Please run process_input_data.R first.\n")
} else {
  tryCatch({
    # Read the processed data file
    data <- read_csv(processed_data_file)
    
    # Count outlines in each grid region
    grid_counts <- data %>%
      count(Grid_X, Grid_Y, name = "Count") %>%
      mutate(ROI_Number = row_number())
    
    # Prepare output as two columns: ROI number and count
    output_data <- grid_counts %>%
      select(ROI_Number, Count)
    
    # Save the ROI counts to a CSV file
    write_csv(output_data, output_file)
    cat(sprintf("ROI counts saved to: %s\n", output_file))
  }, error = function(e) {
    cat(sprintf("Error calculating ROI counts: %s\n", e$message))
  })
}
