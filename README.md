## Before starting:

The run_analysis.R script has to be placed in the working directory.
The data files (features.txt, X_train.txt, subject_train.txt, y_train.txt, X_test.txt, subject_test.txt and y_test.txt) are to be extracted and placed in the same working directory as the script run_analysis.R for the script to execute successfully and generate the desired output.

Steps to take to execute the script and generate the output:
<ol>
<li> source("run_analysis.R") </li>
<li> CourseProjectGettingCleaningData() </li>
 
## Extraction:

The script will read features.txt and pass it to variable <em>columnnames</em>.
It will then read X_train.txt and pass it to variable <em>trainingdata</em>.
<em>tempcompletetrain</em> is used to store <em>trainingdata</em> and variable <em>columnnames</em> is used to set as its column names.
Variable <em>subjecttrain</em> is used to store subject_train.txt and had its column name changed to subjectid
Variable <em>activitytrain</em> is used to store y_train.txt and had its column name changed to activitylabel
Variable <em>temp</em> is created to store and column bind both variables, <em>subjecttrain</em> and <em>activitytrain</em> 
Variable <em>temp</em> is then column binded with <em>tempcompletetrain</em> 
Similar steps were taken for X_test.txt, subject_test.txt and y_test.txt to achieve <em>tempcompletetest</em>.

Variable <em>completedata</em> is created to store the row binded <em>tempcompletetrain</em> and <em>tempcompletetest</em> to complete the extraction and merging of the datas. 

## Manipulation:

<em>completedata2</em> is created as a copy of <em>completedata</em>. Column activitylabel in <em>completedata2</em> contains key value which is being substituted with the text labels for easier understanding of the dataset.
Specific columns were then selected from <em>completedata2</em> and passed into <em>completedata3</em>. A total of 81 columns were passed into <em>completedata3</em>. The last 9 columns were then removed as the names contained "BodyBody" which is not supposed to mean anything as no explanation was provided in features_info.txt 

The column names of <em>completedata3</em> were passed into variable <em>namesconversion</em>. The names were then replaced with descriptive naming. The descriptive naming of the columns names are demarcated via the use of capital letters for each word in the string for easier reading.
Once the names were converted, it is being passed back into <em>completedata3</em> as its new column names.
<em>completedata3</em> is then grouped by activitylabel and subjectid with the average of each column being calculated, and all these is being passed into the variable <em>finaldataset</em>.

## Output:

<em>finaldataset</em> is then being generated onto a text file CourseProjectSubmission.txt.
In order to view the dataset on rstudio, the following code can be used:

* courseproject <- read.table("CourseProjectSubmission.txt", header = TRUE)
* View(courseproject)
 
The above code has been included in the script so that upon the execution of the script, the generated output will be shown in rstudio. 