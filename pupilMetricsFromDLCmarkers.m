%% pupilMetricsFromDLCmarkers.m
% Process Markers from deeplabcut (DLC) files. 
% Authors with email: Manuel Carro Dominguez 
%                     (manuel.carrodominguez@hest.ethz.ch)
% Date of creation: 14.12.2024 (dd.mm.yyy)
% Packages required: 
% conicFitTools
% Matt J (2024). Object-oriented tools to fit/plot conics and quadrics 
%(https://www.mathworks.com/matlabcentral/fileexchange/87584-object-oriented-tools-to-fit-plot-conics-and-quadrics)y

% Copyright: (c) 2024. MANUEL CARRO DOMINGUEZ, 
%               Neural Control of Movement Lab, ETH Zurich. All rights reserved

%------------- BEGIN CODE --------------
% clear command window, clear all variables from workspace
% and close all figures
clc; clear; close all;

scriptFullPath = mfilename('fullpath');
scriptDir = fileparts(scriptFullPath);

% Add the folder to the MATLAB path
folderToAdd = fullfile(scriptDir, 'conicFitTools'); % Replace 'folderName' with the name of your folder
addpath(folderToAdd);

%% Settings
minPointsPupil = 6;  % minimum number of points around pupil to fit an ellipse
minPointsIris = 3; % minimum number of points around iris to calculate pupil iris ratio
likelihoodThreshold = 0.95; % likelihood minimum required to maintain label 
startRow =1;
endFrame = 100; % set to NaN if you want to look at entire dataset

% frame zero is not sleep onset time but the onset from which the recording started
load('DLCmarkers.mat') % video recording from one participant. sampling rate = 50Hz. 
likelihoodCols = find(contains(colName,'likelihood'));

% set label values to NaN when less than likelihoodThreshold
for lc=1:length(likelihoodCols)
    % find subthreshold labels and set pixels coords (=previous two cols) 
    % to NaN
   subThreshRows =  data(:,likelihoodCols(lc))<likelihoodThreshold;
   data(subThreshRows,likelihoodCols(lc)-2:likelihoodCols(lc)-1) = NaN;
end

data = array2table(data, 'VariableNames',colName);

if isnan(endFrame); endFrame = size(data,1); end % frame to finish

disp('Extracting features from DLC markers. This may take a while...')

%iterate through frames
numIterations= (endFrame-startRow);

%% initialize variables
pupilArea = NaN(numIterations,1);
pupilXYCoords = NaN(numIterations,2);
centroidEL = NaN(numIterations,2);
IntersectionsX = NaN(numIterations,12);
IntersectionsY = NaN(numIterations,12);
PIR = NaN(numIterations,1);
centroidCanthi = NaN(numIterations,6); % new in V5
centroidIris = NaN(numIterations,2); % new in V5
frameNum = [];

%% for each frame...
parfor rowToProcess=startRow:endFrame
%             for rowToProcess=startRow:endFrame
    % calculate centroid of eyelid (EL)
    [centroidEL_x, centroidEL_y] = centerOfEyelid(data(rowToProcess,:));
    centroidELTemp = [centroidEL_x, centroidEL_y];
    frameNum = [frameNum; rowToProcess-1];
    
    % calculate elliptical fit 
    fittedEllipseTemp = extractEllipse(data(rowToProcess,:),minPointsPupil);

    % calculate area within ellipse and centroid coordinates
    if ~isempty(fittedEllipseTemp)
        tempPupilArea = pi*fittedEllipseTemp.a*fittedEllipseTemp.b; % area = pi*majoAxisRadius*minorAxisRadius
        temppupilXYCoords = fittedEllipseTemp.center; %x,y (note that y axis is inverted)
    else
        tempPupilArea = NaN;
        temppupilXYCoords = [NaN,NaN];
    end

    % Calculate pupil size as ratio of pupil radius and iris radius = pupil
    [PIRtemp,IntersectionsXTemp, IntersectionsYTemp, centroidIrisTemp] = calculatePIR(data(rowToProcess,:),fittedEllipseTemp, minPointsIris);
    PIRtemp = mean(PIRtemp,'omitnan'); % average out all ratio for each iris point

    % add variables to array
    pupilXYCoords(rowToProcess,:) = temppupilXYCoords;
    centroidEL(rowToProcess,:) = centroidELTemp;
    PIR(rowToProcess,:) =PIRtemp;

end

pupilData= [frameNum,centroidEL,pupilXYCoords,PIR];
columnNames =   {'frameNum', 'eye_x','eye_y','pupil_x', 'pupil_y','PIR'};
pupilData = array2table(pupilData, 'VariableNames',columnNames);


function [x,y] = centerOfEyelid(d)
    x = [];
    y = [];
    
    for idx=1:12 % number of eyelid points
        idxStr =num2str(idx);
        eval(['x = [x,d.eyelid',idxStr,'_x];'])
        eval(['y = [y,d.eyelid',idxStr,'_y];'])
    end
    
    if sum(isnan(x))/length(x) > 3/12 % if more than 3 out of 12 points are nan
        % return empty object
        x =NaN;
        y=NaN;
        return;
    end
    polyin =polyshape(x,y,'KeepCollinearPoints',true);
    [x,y] = centroid(polyin);
    
end

function fobj = extractEllipse(d,minPoints)
    % perform elliptical fitting and return ellipse object
    % with major, minor axis radii and center(a,b,center)
    % For visual verification, the plot() method of the ellipticalFit class 
    % overlays an implicit function plot of the fitted ellipse onto a 
    % scatter plot of the data samples, returning handles hFit and hData to
    % each respectively.
    
    x = [];
    y = [];
    
    for idx=1:12 % number of pupil points
        idxStr =num2str(idx);
        eval(['x = [x,d.pupil',idxStr,'_x];'])
        eval(['y = [y,d.pupil',idxStr,'_y];'])
    end
    xy = [x;y];
    % note that nan values will appear in the same indices for both x and y
    if sum(isnan(x))/length(x) > (12-minPoints)/12 % if more than 3 out of 12 points are nan
        % return empty object
        fobj=[];
        return;
    end
    xy(:,isnan(x))=[];    
    fobj=ellipticalFit(xy); %Perform the fit: 
    
end

function [PIR, IntersectionsX,IntersectionsY,irisCentroid] = calculatePIR(d,fittedEllipse, minPoints)
    % Calculate pupil size as ratio of pupil radius and iris radius = pupil
    % iris ratio (PIR)
    PIR = NaN(1,12);
    x = [];
    y = [];
    IntersectionsX = NaN(1,12);
    IntersectionsY = NaN(1,12);

    for idx=1:12 % number of pupil points
        idxStr =num2str(idx);
        eval(['x = [x,d.iris',idxStr,'_x];'])
        eval(['y = [y,d.iris',idxStr,'_y];'])
    end
    xy = [x;y];
    
    % more than minPoints out of 12 points are nan;
    condition1 = sum(isnan(x))/length(x) > (12-minPoints)/12;
    % unsuccesful ellipse fitting
    condition2 = isempty(fittedEllipse);
    if ~condition1 && ~condition2
        
        for idx=1:size(xy,2) % number of iris points
            xI = xy(1, idx);
            yI = xy(2, idx);

            % if valid iris point
            if ~isnan(xI) && ~isnan(yI)
                ellipseX = fittedEllipse.center(1);
                ellipseY = fittedEllipse.center(2);
                % note that y axis is inverted in ellipse centroid
                [Intersection1,Intersection2] = lineEllipse(fittedEllipse.a,fittedEllipse.b,...
                                      fittedEllipse.center,[xI,yI],fittedEllipse.center);
                
                % distance between iris and pupil ellipse centroid
                d_iris_centroid = ((xI-ellipseX)^2+(yI-ellipseY)^2)^0.5;
                % distance between iris and intersections  
                d_iris_Intersection1 = ((xI-Intersection1(1))^2+(yI-Intersection1(2))^2)^0.5;
                d_iris_Intersection2 = ((xI-Intersection2(1))^2+(yI-Intersection2(2))^2)^0.5;
                
                % keep only smallest distance (as this is the first
                % intersection)
                [~, firstIntersectionIdx] = min([d_iris_Intersection1,d_iris_Intersection2]); 
                
                if firstIntersectionIdx ==1
                    d_iris_intersection = d_iris_Intersection1;
                    currIntersection = Intersection1;
                else 
                    d_iris_intersection = d_iris_Intersection2;
                    currIntersection = Intersection2;
                end
                PIRtemp = (d_iris_centroid-d_iris_intersection)/d_iris_centroid;
                
                PIR(1,idx) = PIRtemp;
                IntersectionsX(1,idx) = currIntersection(1);
                IntersectionsY(1,idx) = currIntersection(2);
            end
        end
    end
    
    condition3 = sum(isnan(x))/length(x) > 6/12; % missing more than 6 iris points to calculate iris centroid
    if ~condition3
        xy(:,isnan(x))=[];    
        fobj=ellipticalFit(xy); %Perform the fit: 
        irisCentroid = [fobj.center(1),fobj.center(2)];
    else
        % return empty 
        irisCentroid=[NaN,NaN];
    end
    
end

function [C1,C2] = lineEllipse(a,b,O,A,B) 
    % https://ch.mathworks.com/matlabcentral/fileexchange/68619-lineellipse
    % Get points of intersection of line and Ellipse 
    % INPUT : a - major axis of Ellipse
    %         b - minor axis of Ellipse
    %         O - center of ellipse i,e (h,k)
    %         A, P  - points of striaght line (x1,y1) and (x2,y2)
    % OUTPUT : C - Point of intersection of line and ellipse

    %% Ellipse center
    h = O(1); 
    k = O(2);
    %% Line, Get slope and y-intercept of the line
    AB = [A; B];
    line = polyfit(AB(:,1),AB(:,2),1) ;
    m = line(1) ;       % Slope of the line 
    c = line(2) ;       % y-intercept of the line
    
    %% Formula
    eps = c-k;
    delta = c+m*h;
    D = sqrt(a^2*m^2+b^2-delta^2-k^2+2*delta*k) ;
    E = a^2*m^2+b^2 ;
    x1 = (h*b^2-m*a^2*eps+a*b*D)/E;
    x2 = (h*b^2-m*a^2*eps-a*b*D)/E ;
    y1 = (b^2*delta+k*a^2*m^2+a*b*m*D)/E;
    y2 = (b^2*delta+k*a^2*m^2-a*b*m*D)/E ;
    C1 = [x1 y1] ; C2 = [x2 y2] ;
    %% Check if intersection points exists
    if ~isreal(C1)
        C1 = [NaN NaN] ;
        C2 = C1 ;
    end

end

