# wk4project
Coursera week 4 project for getting and cleaning data
The files loaded into the repository include: (1) the R code run_analysis.R (2) final text file Tidydata.txt and (3) Codebook.md that describes codes and values
run_analysis.R has the following steps:
1. Download and unzip the UCI HAR Dataset
2. Load all the datasets into the tables
3. Activity table has the code and the activity name; features table has the list of all attributes measured; Subject table has the subject codes for each of the measurements; these 3 tables are like reference tables for the actual recordings in the test and train data sets
4. Xdata combines test and training data sets, Ydata has the combined set of labels
5. Singlesetdata is the table that has Subject, Activity Code, and the test/ train measurements
6. Meansddata table selects columns containing mean and sd function, with activity code replaced by activity name
7. Labels are then properly texted by replacing the abbreviations - Acc with Accelerometer, Gyro with Gyroscope, words starting with t with time, words starting with f with frequency, freq with frqeuncy, BodyBody with Body
8. Tidydata table is created by grouping by subject and activity code, and then calculating means
9. Lastly, the text file is created of tidy data set by writing from the table
