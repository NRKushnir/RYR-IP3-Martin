library(dplyr)   # Required for the %>% operator and other functions
library(readr)   # Required for read_csv function
library(tidyr)   # Required for the complete function


##Script to Convert IP3 Data .CVS to Excel 

library(readr)
library(writexl)

# Function to process and write a single dataset
process_and_write <- function(group, ko_wt, index, dataset_type, output_name) {
  
  # Clean up the dataset type string by removing any extra spaces
  dataset_type_cleaned <- gsub(" ", "", dataset_type)
  
  # Define the correct file path for the current input file
  input_file <- paste0("/Users/nicolekushnir/Downloads/processed_IP3_30thresh-selected (1)/", 
                       group, " ", ko_wt, " ", index, "_Want_", dataset_type_cleaned, ".csv")
  
  # Check if the file exists
  if (!file.exists(input_file)) {
    cat("File does not exist:", input_file, "\n")
    return()
  }
  
  # Read the CSV file
  data <- read_csv(input_file)
  
  # Extract columns 1, 5, and 6 (adjust for column selection)
  data_new <- data[, c(1, 5, 6)]
  
  # Add "Outline" column with sequential labels starting from A2
  data_new <- cbind(Outline = paste("Outline", 1:nrow(data_new)), data_new)
  
  # Rename columns to place "Outline" in the first column, followed by the extracted data
  colnames(data_new) <- c("Outline", colnames(data)[c(1, 5, 6)])
  
  # Define the output file path
  output_file <- paste0("/Users/nicolekushnir/Documents/", output_name, ".xlsx")
  
  # Write to Excel
  tryCatch({
    write_xlsx(list(Output = data_new), output_file)
    cat("File successfully written to:", output_file, "\n")
  }, error = function(e) {
    cat("Error writing file:", e$message, "\n")
  })
}

# Define groups, KO/WT labels, iterations, and dataset types
groups <- c("IP3")
ko_wt_labels <- c("KO", "WT")
iterations <- 1:3
dataset_types <- c("Subset", "free (test)", "clusters (test)")  # Correct dataset types for Free and Cluster

# Process all combinations for IP3 KO and WT groups
for (group in groups) {
  for (ko_wt in ko_wt_labels) {
    for (index in iterations) {
      for (dataset_type in dataset_types) {
        # Generate the output file name based on dataset type
        if (dataset_type == "Subset") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", dataset_type, "_Thresh30_Total")
        } else if (dataset_type == "free (test)") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", "free", "_Thresh30_Free")
        } else if (dataset_type == "clusters (test)") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", "clusters", "_Thresh30_Clusters")
        }
        
        # Process and write the output file
        process_and_write(group, ko_wt, index, dataset_type, output_name)
      }
    }
  }
}

cat("Processing complete! Files saved in your Documents folder.")

##Script to Convert IP3 Data .CVS to Excel 
library(readr)
library(writexl)

# List all RYR files to verify correct input
list.files("/Users/nicolekushnir/Downloads/processed_RYR_30thresh-selected (1)/")

# Function to process and write a single dataset for RYR
process_and_write_RYR <- function(group, ko_wt, index, dataset_type, output_name) {
  
  # Clean up the dataset type string by removing any extra spaces
  dataset_type_cleaned <- gsub(" ", "", dataset_type)
  
  # Define the correct file path for the current input file
  input_file <- paste0("/Users/nicolekushnir/Downloads/processed_RYR_30thresh-selected (1)/", 
                       "Results_", group, " ", ko_wt, " ", index, "_Want_", dataset_type_cleaned, ".csv")
  
  # Check if the file exists
  if (!file.exists(input_file)) {
    cat("File does not exist:", input_file, "\n")
    return()
  }
  
  # Read the CSV file
  data <- read_csv(input_file)
  
  # Extract columns 1, 5, and 6
  data_new <- data[, c(1, 5, 6)]
  
  # Add "Outline" column with sequential labels starting from A2
  data_new <- cbind(Outline = paste("Outline", 1:nrow(data_new)), data_new)
  
  # Rename columns to place "Outline" in the first column, followed by the extracted data
  colnames(data_new) <- c("Outline", colnames(data)[c(1, 5, 6)])
  
  # Define the output file path
  output_file <- paste0("/Users/nicolekushnir/Documents/", output_name, ".xlsx")
  
  # Write to Excel
  tryCatch({
    write_xlsx(list(Output = data_new), output_file)
    cat("File successfully written to:", output_file, "\n")
  }, error = function(e) {
    cat("Error writing file:", e$message, "\n")
  })
}

# Define groups, KO/WT labels, iterations, and dataset types for RYR
groups <- c("RYR")
ko_wt_labels <- c("KO", "WT")
iterations <- 1:3
dataset_types <- c("Subset", "free (test)", "clusters (test)")  # Correct dataset types for Free and Cluster

# Process all combinations for RYR KO and WT groups
for (group in groups) {
  for (ko_wt in ko_wt_labels) {
    for (index in iterations) {
      for (dataset_type in dataset_types) {
        # Generate the output file name based on dataset type
        if (dataset_type == "Subset") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", dataset_type, "_Thresh30_Total")
        } else if (dataset_type == "free (test)") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", "free", "_Thresh30_Free")
        } else if (dataset_type == "clusters (test)") {
          output_name <- paste0(group, "_", ko_wt, "_", index, "_", "clusters", "_Thresh30_Clusters")
        }
        
        # Process and write the output file
        process_and_write_RYR(group, ko_wt, index, dataset_type, output_name)
      }
    }
  }
}

cat("Processing complete for RYR! Files saved in your Documents folder.")

##Script 1: Process Input Data

library(dplyr)
library(readr)

# Function to process input data and save as processed CSV
process_and_save_data <- function(file_path, output_file) {
  
  # Check if the input file exists
  if (!file.exists(file_path)) {
    cat("File not found at the specified path:\n", file_path, "\n")
    return()
  }
  
  tryCatch({
    # Read the input file
    data <- read_delim(file_path, delim = "\t", col_names = TRUE)
    
    # Rename columns (assuming the format in the .txt file is correct)
    colnames(data) <- c("Outline_Name", "Outline_Area", "X_Coordinate", "Y_Coordinate")
    
    # Remove leading/trailing whitespace from the first column (Outline_Name)
    data <- data %>%
      mutate(Outline_Name = trimws(Outline_Name))
    
    # Convert coordinates to pixel units
    data <- data %>%
      mutate(
        Pixel_X = floor(X_Coordinate / 0.114),
        Pixel_Y = floor(Y_Coordinate / 0.114)
      )
    
    # Define grid size (1024x1024 image divided into 5x5 grid)
    grid_size <- 1024 / 5
    
    # Assign grid positions (Grid_X and Grid_Y)
    data <- data %>%
      mutate(
        Grid_X = floor(Pixel_X / grid_size),
        Grid_Y = floor(Pixel_Y / grid_size)
      )
    
    # Save the processed data to a CSV file
    write_csv(data, output_file)
    cat(sprintf("Processed input data saved to: %s\n", output_file))
    
  }, error = function(e) {
    cat(sprintf("Error processing input file: %s\n", e$message))
  })
}

# List all .txt files in your Documents folder to process
txt_files <- list.files("/Users/nicolekushnir/Documents", pattern = "\\.txt$", full.names = TRUE)

# Loop through each .txt file and apply the processing function
for (file in txt_files) {
  # Generate the output file name by appending "_processed_data.csv" to the original file name
  output_file <- sub("\\.txt$", "_processed_data.csv", file)
  
  # Process and save the data
  process_and_save_data(file, output_file)
}

cat("Batch processing complete! Processed files saved as CSV in your Documents folder.")

##Script 2: Calculate ROI Counts
library(dplyr)
library(readr)

# Function to calculate ROI counts for processed data files
calculate_roi_counts <- function(processed_data_file, output_file) {
  
  # Check if the processed data file exists
  if (!file.exists(processed_data_file)) {
    cat("Processed data file not found:", processed_data_file, "\n")
    return()
  }
  
  tryCatch({
    # Read the processed data file
    data <- read_csv(processed_data_file)
    
    # Count outlines in each grid region (Grid_X, Grid_Y)
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

# List all processed data files (from Script 1) in the Documents folder
processed_files <- list.files("/Users/nicolekushnir/Documents", pattern = "_processed_data.csv$", full.names = TRUE)

# Loop through each processed file and calculate the ROI counts
for (file in processed_files) {
  # Generate the output file name by appending "_outline_counts.csv" to the processed file name
  output_file <- sub("_processed_data.csv$", "_outline_counts.csv", file)
  
  # Calculate ROI counts for the current file
  calculate_roi_counts(file, output_file)
}

cat("Batch processing complete! ROI counts saved as CSV in your Documents folder.")


##Script 1 Process Input Data Edited for Batch Processing
##modified to add ROI area and ensure a 5x5 square valid range during grid assignment and check whether the ROI is empty 

library(dplyr)
library(readr)

# Function to process input data and save as processed CSV
process_and_save_data <- function(file_path, output_file) {
  
  # Check if the input file exists
  if (!file.exists(file_path)) {
    cat("File not found at the specified path:\n", file_path, "\n")
    return()
  }
  
  tryCatch({
    # Read the input file
    data <- read_delim(file_path, delim = "\t", col_names = TRUE)
    
    # Rename columns (assuming the format in the .txt file is correct)
    colnames(data) <- c("Outline_Name", "Outline_Area", "X_Coordinate", "Y_Coordinate")
    
    # Remove leading/trailing whitespace from the first column (Outline_Name)
    data <- data %>%
      mutate(Outline_Name = trimws(Outline_Name))
    
    # Convert coordinates to pixel units
    data <- data %>%
      mutate(
        Pixel_X = floor(X_Coordinate / 0.114),
        Pixel_Y = floor(Y_Coordinate / 0.114)
      )
    
    # Define grid size (1024x1024 image divided into 5x5 grid)
    grid_size <- 1024 / 5
    
    # Assign grid positions (Grid_X and Grid_Y) and ensure valid range
    data <- data %>%
      mutate(
        Grid_X = pmin(floor(Pixel_X / grid_size), 4),  # Clip to range [0, 4]
        Grid_Y = pmin(floor(Pixel_Y / grid_size), 4)   # Clip to range [0, 4]
      )
    
    # Calculate the area of each ROI in microns²
    roi_area_microns <- grid_size^2 * (0.114^2)
    
    # Add a column for the ROI area
    data <- data %>%
      mutate(ROI_Area_microns = roi_area_microns)
    
    # Save the processed data to a CSV file
    write_csv(data, output_file)
    cat(sprintf("Processed input data saved to: %s\n", output_file))
    
  }, error = function(e) {
    cat(sprintf("Error processing input file: %s\n", e$message))
  })
}

# List all .txt files in your Documents folder to process
txt_files <- list.files("/Users/nicolekushnir/Documents", pattern = "\\.txt$", full.names = TRUE)

# Generate updated output filenames based on the new naming convention
generate_output_name <- function(file_path) {
  output_file <- basename(file_path)
  
  output_file <- gsub("_clusters_Thresh30_Clusters", "_Subset_Thresh30_Clusters", output_file)
  output_file <- gsub("_free_Thresh30_Free", "_Subset_Thresh30_Free", output_file)
  
  # No change for Total files
  sub("\\.txt$", "_processed_data.csv", output_file)
}

# Loop through each .txt file and apply the processing function
for (file in txt_files) {
  output_file <- generate_output_name(file)
  output_path <- file.path("/Users/nicolekushnir/Documents", output_file)
  
  # Process and save the data
  process_and_save_data(file, output_path)
}

cat("Batch processing complete! Processed files saved as CSV in your Documents folder.")


##Script 2:Calculate ROI Counts Edited for Batch Processing
##ensure that only 25 ROIs (5x5 grid) are included in the final output, even if the processed data contains outliers.

library(dplyr)
library(readr)
library(tidyr)  # Ensure the `complete()` function is available

# Function to calculate ROI counts for processed data files
calculate_roi_counts <- function(processed_data_file, output_file) {
  
  # Check if the processed data file exists
  if (!file.exists(processed_data_file)) {
    cat("Processed data file not found:", processed_data_file, "\n")
    return()
  }
  
  tryCatch({
    # Read the processed data file
    data <- read_csv(processed_data_file)
    
    # Count outlines in each grid region (Grid_X, Grid_Y)
    grid_counts <- data %>%
      count(Grid_X, Grid_Y, name = "Count") %>%
      complete(Grid_X = 0:4, Grid_Y = 0:4, fill = list(Count = 0)) %>%  # Ensure all 25 ROIs are included
      filter(Grid_X <= 4 & Grid_Y <= 4) %>%  # Ensure only valid ROIs are included
      mutate(ROI_Number = row_number())
    
    # Extract the ROI area (assume it's constant across all rows from Script 1)
    roi_area_microns <- unique(data$ROI_Area_microns)[1]
    
    # Prepare output: ROI number, count, empty status, and ROI area
    output_data <- grid_counts %>%
      mutate(
        ROI_Empty = Count == 0,
        ROI_Area_microns = roi_area_microns
      ) %>%
      select(ROI_Number, Count, ROI_Empty, ROI_Area_microns)
    
    # Save the ROI counts to a CSV file
    write_csv(output_data, output_file)
    cat(sprintf("ROI counts saved to: %s\n", output_file))
    
  }, error = function(e) {
    cat(sprintf("Error calculating ROI counts: %s\n", e$message))
  })
}

# List all processed data files (from Script 1) in the Documents folder
processed_files <- list.files("/Users/nicolekushnir/Documents", pattern = "_processed_data.csv$", full.names = TRUE)

# Generate updated output filenames based on the new naming convention
generate_output_name <- function(file_path) {
  output_file <- basename(file_path)
  
  output_file <- gsub("_clusters_Thresh30_Clusters", "_Subset_Thresh30_Clusters", output_file)
  output_file <- gsub("_free_Thresh30_Free", "_Subset_Thresh30_Free", output_file)
  
  # No change for Total files
  sub("_processed_data.csv$", "_outline_counts.csv", output_file)
}

# Loop through each processed file and calculate the ROI counts
for (file in processed_files) {
  output_file <- generate_output_name(file)
  output_path <- file.path("/Users/nicolekushnir/Documents", output_file)
  
  # Calculate ROI counts for the current file
  calculate_roi_counts(file, output_path)
}

cat("Batch processing complete! ROI counts saved as CSV in your Documents folder.")

##Script 3: Combine ROI Counts to 1 Excel Sheet
library(dplyr)
library(readr)
library(openxlsx)

# Define the input folder and output file
input_folder <- "/Users/nicolekushnir/Documents"
output_file <- "/Users/nicolekushnir/Documents/Combined_ROI_Counts.xlsx"

# Generate file paths with the corrected naming convention
generate_file_paths <- function(group, samples, subdivisions) {
  file_paths <- list()
  for (sample in samples) {
    for (subdivision in subdivisions) {
      # Handle "Clusters" naming specifically
      if (subdivision == "Cluster") {
        file_name <- paste(group, sample, "Subset_Thresh30", "Clusters", "outline_counts.csv", sep = "_")
      } else {
        file_name <- paste(group, sample, "Subset_Thresh30", subdivision, "outline_counts.csv", sep = "_")
      }
      file_path <- file.path(input_folder, file_name)
      file_paths[[paste(sample, subdivision, sep = "_")]] <- file_path
    }
  }
  return(file_paths)
}

# Define groups, samples, and subdivisions
groups <- c("IP3", "RYR")
samples <- list(
  WT = c("WT_1", "WT_2", "WT_3"),
  KO = c("KO_1", "KO_2", "KO_3")
)
subdivisions <- c("Total", "Free", "Cluster")  # Use "Cluster" consistently in the code

# Generate file paths for IP3 and RYR
ip3_file_paths <- generate_file_paths("IP3", unlist(samples), subdivisions)
ryr_file_paths <- generate_file_paths("RYR", unlist(samples), subdivisions)

# Function to combine data into a single sheet
create_combined_sheet <- function(file_paths, sheet_name, workbook) {
  combined_data <- data.frame()
  
  for (sample_subdivision in names(file_paths)) {
    file_path <- file_paths[[sample_subdivision]]
    
    if (!file.exists(file_path)) {
      cat("File not found:", file_path, "\n")
      next
    }
    
    # Read the ROI_Number and Count columns
    data <- read_csv(file_path) %>%
      select(ROI_Number, Count)
    
    # Rename columns to include the sample and subdivision
    colnames(data) <- paste(sample_subdivision, colnames(data), sep = "_")
    
    # Combine data
    if (nrow(combined_data) == 0) {
      combined_data <- data
    } else {
      combined_data <- cbind(combined_data, data)
    }
  }
  
  # Add the combined data as a new sheet
  addWorksheet(workbook, sheet_name)
  writeData(workbook, sheet_name, combined_data)
}

# Create a new workbook
workbook <- createWorkbook()

# Add IP3 and RYR sheets
create_combined_sheet(ip3_file_paths, "IP3", workbook)
create_combined_sheet(ryr_file_paths, "RYR", workbook)

# Save the workbook
saveWorkbook(workbook, output_file, overwrite = TRUE)

cat(sprintf("Combined Excel file saved to: %s\n", output_file))


