# Getting-and-Cleaning-Data-Project

##### Course project for the Getting and Cleaning Data course of the Coursera Data Science track.

The R Script file "run_analysis.R" is used to load the data sets and perform
the necessary tasks as listed below. The R script assumes you have downloaded
the data file and unzipped it to a directory called "UCI HAR Dataset" in your
working directory.

The "run_analysis.R" file performs the following tasks:

1. Sets up data frames from all the necessary files in the dataset directory.
2. Applies the variable names to the training and test data frames.
3. Replaces the activity labels with the descriptions rather than number values.
4. Inserts the subject and activity variables to each training and testing data
...frames.
5. Combines the training and test data frames into one combined data frame
...called "meansandstds" by using the rbind command.
6. Fixes the variable names of "meansandstds" so there are no duplicates and
...it excludes any characters that would cause errors in the following steps.
7. Reduces the meansandstds data frame to include only subject variables, the
...activity variable, and the means and standard deviations of each measurement.
...Note: This excludes the "...meanFreq" variables as those were not requested
...to be pulled.
8. Updates the variable names to with variable name text standards as follows:
	* Removes the periods
	* Removes duplicate "Body"s in variable names
	* Changes all the characters to lower case
9. Create new data frame called "meansandstdsavgs" that groups the measurements
...by subject and activity and calculates the mean of each variable for each
...group.
10. Writes the final data frame to a .txt file called "meansandstds_avgs.txt".


View the CodeBook.md file for descriptions of each of the variables and how
they apply to the original data.