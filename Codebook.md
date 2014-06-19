Codebook for "Getting and Cleaning Data" Course Project
========================================================

The data set used for this project comes from data collected from the accelerometers from the Samsung Galaxy S smartphone. Further details of the project are available here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The goal of this project was to create a script that would read the data, merge two datasets, a training set and a test set, add attributes stored in other files, subject and activity labels and names to the main data set, and create a new data set of the means per subject and activity using tidy data principles.

For a description of the variables in the data, see the file features_info.txt included with the original data. For this project, since the same names are used to identify the variables, the data consist of 3-axial time domain signals from an accelerometer and gyrosocpe that have been processed in various ways, to provide the following signals:

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

Where XYZ represent the axis, and Mag the signal magnitude.  These are processed to estimate a number of variables.  The ones of interest in our case are the ones the provide mean and standard deviation, i.e.

mean(): Mean value
std(): Standard deviation
meanFreq(): Weighted average of the frequency components to obtain a mean frequency

Other variables that estimate means are:
gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

Based on the above there are 79 columns of interest:
Ind      Variable_Name                        
1     tBodyAcc-mean()-X              
2     tBodyAcc-mean()-Y              
3     tBodyAcc-mean()-Z              
4     tBodyAcc-std()-X               
5     tBodyAcc-std()-Y               
6     tBodyAcc-std()-Z               
41    tGravityAcc-mean()-X           
42    tGravityAcc-mean()-Y           
43    tGravityAcc-mean()-Z           
44    tGravityAcc-std()-X            
45    tGravityAcc-std()-Y            
46    tGravityAcc-std()-Z            
81    tBodyAccJerk-mean()-X          
82    tBodyAccJerk-mean()-Y          
83    tBodyAccJerk-mean()-Z          
84    tBodyAccJerk-std()-X           
85    tBodyAccJerk-std()-Y           
86    tBodyAccJerk-std()-Z           
121   tBodyGyro-mean()-X             
122   tBodyGyro-mean()-Y             
123   tBodyGyro-mean()-Z             
124   tBodyGyro-std()-X              
125   tBodyGyro-std()-Y              
126   tBodyGyro-std()-Z              
161   tBodyGyroJerk-mean()-X         
162   tBodyGyroJerk-mean()-Y         
163   tBodyGyroJerk-mean()-Z         
164   tBodyGyroJerk-std()-X          
165   tBodyGyroJerk-std()-Y          
166   tBodyGyroJerk-std()-Z          
201   tBodyAccMag-mean()             
202   tBodyAccMag-std()              
214   tGravityAccMag-mean()          
215   tGravityAccMag-std()           
227   tBodyAccJerkMag-mean()         
228   tBodyAccJerkMag-std()          
240   tBodyGyroMag-mean()            
241   tBodyGyroMag-std()             
253   tBodyGyroJerkMag-mean()        
254   tBodyGyroJerkMag-std()         
266   fBodyAcc-mean()-X              
267   fBodyAcc-mean()-Y              
268   fBodyAcc-mean()-Z              
269   fBodyAcc-std()-X               
270   fBodyAcc-std()-Y               
271   fBodyAcc-std()-Z               
294   fBodyAcc-meanFreq()-X          
295   fBodyAcc-meanFreq()-Y          
296   fBodyAcc-meanFreq()-Z          
345   fBodyAccJerk-mean()-X          
346   fBodyAccJerk-mean()-Y          
347   fBodyAccJerk-mean()-Z          
348   fBodyAccJerk-std()-X           
349   fBodyAccJerk-std()-Y           
350   fBodyAccJerk-std()-Z           
373   fBodyAccJerk-meanFreq()-X      
374   fBodyAccJerk-meanFreq()-Y      
375   fBodyAccJerk-meanFreq()-Z      
424   fBodyGyro-mean()-X             
425   fBodyGyro-mean()-Y             
426   fBodyGyro-mean()-Z             
427   fBodyGyro-std()-X              
428   fBodyGyro-std()-Y              
429   fBodyGyro-std()-Z              
452   fBodyGyro-meanFreq()-X         
453   fBodyGyro-meanFreq()-Y         
454   fBodyGyro-meanFreq()-Z         
503   fBodyAccMag-mean()             
504   fBodyAccMag-std()              
513   fBodyAccMag-meanFreq()         
516   fBodyBodyAccJerkMag-mean()     
517   fBodyBodyAccJerkMag-std()      
526   fBodyBodyAccJerkMag-meanFreq() 
529   fBodyBodyGyroMag-mean()        
530   fBodyBodyGyroMag-std()         
539   fBodyBodyGyroMag-meanFreq()    
542   fBodyBodyGyroJerkMag-mean()    
543   fBodyBodyGyroJerkMag-std()     
552   fBodyBodyGyroJerkMag-meanFreq()

In the final output dataset, "av" has been appended to the variable name to indicate that an average has been calculated.

The final tidy dataset was created using the following steps:
1. Extract the above columns from both the training and test data, and merged into on data set.
2. Add Subject and activity information from corresponding subject and activity files for both training and test data
3. Split data by subject and activity
4. Calculate column means for each part and combine again into a dataframe
5. Add subject and activity data, and appropriate column names, with "avg" appended to indicate a calculated value.

The column names have been contracted where possible, with the following modifications:
mean -> mn
std -> sd
Acc -> Ac
Body -> Bd
Gravity -> Grv
Gyro -> Gyr
avg -> av
Freq -> Fr
Jerk -> Jk
The resulting columns are as follows:
1  subject               
2  activity              
3  tBdAc-mn-X-av       
4  tBdAc-mn-Y-av       
5  tBdAc-mn-Z-av       
6  tBdAc-sd-X-av       
7  tBdAc-sd-Y-av       
8  tBdAc-sd-Z-av       
9  tGrAc-mn-X-av       
10 tGrAc-mn-Y-av       
11 tGrAc-mn-Z-av       
12 tGrAc-sd-X-av       
13 tGrAc-sd-Y-av       
14 tGrAc-sd-Z-av       
15 tBdAcJr-mn-X-av     
16 tBdAcJr-mn-Y-av     
17 tBdAcJr-mn-Z-av     
18 tBdAcJr-sd-X-av     
19 tBdAcJr-sd-Y-av     
20 tBdAcJr-sd-Z-av     
21 tBdGy-mn-X-av       
22 tBdGy-mn-Y-av       
23 tBdGy-mn-Z-av       
24 tBdGy-sd-X-av       
25 tBdGy-sd-Y-av       
26 tBdGy-sd-Z-av       
27 tBdGyJr-mn-X-av     
28 tBdGyJr-mn-Y-av     
29 tBdGyJr-mn-Z-av     
30 tBdGyJr-sd-X-av     
31 tBdGyJr-sd-Y-av     
32 tBdGyJr-sd-Z-av     
33 tBdAcMag-mn-av      
34 tBdAcMag-sd-av      
35 tGrAcMag-mn-av      
36 tGrAcMag-sd-av      
37 tBdAcJrMag-mn-av    
38 tBdAcJrMag-sd-av    
39 tBdGyMag-mn-av      
40 tBdGyMag-sd-av      
41 tBdGyJrMag-mn-av    
42 tBdGyJrMag-sd-av    
43 fBdAc-mn-X-av       
44 fBdAc-mn-Y-av       
45 fBdAc-mn-Z-av       
46 fBdAc-sd-X-av       
47 fBdAc-sd-Y-av       
48 fBdAc-sd-Z-av       
49 fBdAc-mnFr-X-av     
50 fBdAc-mnFr-Y-av     
51 fBdAc-mnFr-Z-av     
52 fBdAcJr-mn-X-av     
53 fBdAcJr-mn-Y-av     
54 fBdAcJr-mn-Z-av     
55 fBdAcJr-sd-X-av     
56 fBdAcJr-sd-Y-av     
57 fBdAcJr-sd-Z-av     
58 fBdAcJr-mnFr-X-av   
59 fBdAcJr-mnFr-Y-av   
60 fBdAcJr-mnFr-Z-av   
61 fBdGy-mn-X-av       
62 fBdGy-mn-Y-av       
63 fBdGy-mn-Z-av       
64 fBdGy-sd-X-av       
65 fBdGy-sd-Y-av       
66 fBdGy-sd-Z-av       
67 fBdGy-mnFr-X-av     
68 fBdGy-mnFr-Y-av     
69 fBdGy-mnFr-Z-av     
70 fBdAcMag-mn-av      
71 fBdAcMag-sd-av      
72 fBdAcMag-mnFr-av    
73 fBdBdAcJrMag-mn-av  
74 fBdBdAcJrMag-sd-av  
75 fBdBdAcJrMag-mnFr-av
76 fBdBdGyMag-mn-av    
77 fBdBdGyMag-sd-av    
78 fBdBdGyMag-mnFr-av  
79 fBdBdGyJrMag-mn-av  
80 fBdBdGyJrMag-sd-av  
81 fBdBdGyJrMag-mnFr-av