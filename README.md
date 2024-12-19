# PupilSizeDuringSleep
Part A. Calculate pupil size and position from extracted eye markers from video stream using DeepLabCut™
Part B. Generate main graphs from Nature Communications 2025 paper: (link)

Note that this repository only contains the code. The data can be downloaded from (link to eth research collection). Once you download the data, make sure to move the data to this repository! 

Created with Matlab 2019a and R v3.6.3

For part A: run pupilMetricsFromDLCmarkers.m
Packages required:
Matt J (2024). Object-oriented tools to fit/plot conics and quadrics (https://www.mathworks.com/matlabcentral/fileexchange/87584-object-oriented-tools-to-fit-plot-conics-and-quadrics), MATLAB Central File Exchange. Retrieved.

For part B: 
Each figure has a script and an accompanying .mat or .csv file with the data and variables used in the paper. 
e.g. Figure2.m and Figure2.mat
Libraries required for R scritps:
ggplot2

Have fun 🧐😄

Additional sources used in pupilMetricsFromDLCmarkers.m:
KSSV (2024). lineEllipse (https://www.mathworks.com/matlabcentral/fileexchange/68619-lineellipse), MATLAB Central File Exchange.

