Code Book for UCI HAR Dataset
========================================================

Data Source
-------------------------
This dataset was compiled for use in the following publication: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012. It was made available thanks to the courtesy of the named authors.

Data
-------------------------
The dataset was collected in an experiment where 30 differnt subjects performed six different activities while wearing a smartphone. The activies were walking, walking upstairs, walking downstairs, sitting, standing, and laying. The reslting data was designed to explore machine learning techniques for determining which of the six activites a person was doing from the smartphone sensor data. 

Two sensors, an accelerometer and a gyroscope, were used to capture the raw data. For each sensor there were time-based measurements in each axis, X, Y, and Z. For each sensor the effect of gravity was split from the effect of the subject's movements. From these measurements both the Jerk signals and the magnitude of the signals were calculated. Lastly the time-based measurements were transformed into frequency measurements via a Fast Fourier Transform (FFT). 

Finally for each of these measurements several statistics were calculated.  
* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.


Variables
-------------------------
There are a total of 561 core variables in the dataset. There are 10 time-based measures and 7 frequency measures. The variable names have a structure that denotes where the underlying data came from and what they measure.  
* The variables for the time-based measures are prefixed with a 't' while the frequency measures are prefixed with an 'f'.  
* For each measure there are two components, that due to the subject (denoted as Body) and that due to gravity (denoted as Gravity).  
* The source of the data is denoted next. Accelerometer data is denoted as 'Acc' and the gyroscope as 'Gyro'.  
* A label that describes the type of signal, either raw (blank) or jerk (Jerk), and its nature, either raw (blank) or magnitude (Mag), comes next.  
* Next is the type of statstic computed on this measurement. This is one of the name statistics listed in the data section above.  
* Lastly, is the axis on which the measurement was taken, X, Y, or Z. For some statistics there are two axes, in which case the axes are seperated by a comma.  


Cleaning
-------------------------
The raw data was already split into a training and a testing set. In addition, the the identifiers, both the activity performed and the subject who performed it are listed in seperate files for each of the training and testing sets. To reincorporate the data in preparation for extracting the desired data table the following steps were followed:  
### Data Labels
1. The data file containing the column labels is loaded  

### Training Data
1. Training data is loaded  
2. The vector of activity codes for the training data is loaded.  
3. Activity code vector is appended as the last column in the training data.  
4. The vector of subject codes for the training data is loaded.  
5. Subject code vector is prepended as the first column in the training data.  
6. The columns in the training data are labelled.  

### Testing Data
1. Testing data is loaded  
2. The vector of activity codes for the testing data is loaded.  
3. Activity code vector is appended as the last column in the testing data.  
4. The vector of subject codes for the training data is loaded.  
5. Subject code vector is prepended as the first column in the testing data.  
6. The columns in the testing data are labelled.  

### Data Merger and Transformation
1. The testing data is appended to the training data  
2. The vector of descriptive names for the Activity codes is loaded  
3. The numeric Activity codes are replaced with thier more descriptive names  
4. The merged data is transformed from its long form to a compact form  
5. The compact data is grouped by the Activity followed by the Subject and the values all the variables are aggregated by taking their mean.  
6. The resultant table is written to disk for later use.  