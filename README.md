# GettingAndCleaningData
Peer Assessment project for the Getting and Cleaning Data Class

The run_analysis.R script contains three functions:
  load_data()
  get_subsetfields()
  run_analysis()
  
The load_data() function simply reads data from the indicated directory in the working directory and follows the naming conventions of the data set then returns a dataframe containing the records and the column information

The get_subsetfields() function creates a character vector of relevant columns to be used with the subset command.  This currently returns a hard-coded set of values.

The run_analysis() function retrieves all the data from the test and train datasets using the load_data() function then rbinds() and subsets them to only the columns specified in the get_subsetfields() function.*  The function then iterates over the unique values for subject and activity through nested loops to return the mean of each of the associated columns.  Finally, the Activity_Id values are assigned the descriptive labels from the activity_labels.txt file.

*Additionally, there is commented out code to allow reading the subset fields from a file, this was disabled due to the requirement to be able to run as long as the working directory is set to the main data folder. I've included the file incase you find it interesting.
