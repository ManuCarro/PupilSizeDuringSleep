%% Figure3.m
% Authors with email: Manuel Carro Dominguez 
%                     (manuel.carrodominguez@hest.ethz.ch)
% Date of creation: 14.12.2024 (dd.mm.yyy)
% Validation date/version:
% Validated by:
% Copyright: (c) 2024. MANUEL CARRO DOMINGUEZ, 
%               Neural Control of Movement Lab, ETH Zurich. All rights reserved

%------------- BEGIN CODE --------------
% clear command window, clear all variables from workspace
% and close all figures
clc; clear; close all;

load('Figure3.mat')

%% plot figure 3

%% 3A
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
Nparticipants = size(validPupil_kComplex,1);
% % title('Cross-correlation of Pupil Size vs. Lagged Sigma Power')
suptitle(['K-complexes (N= ', num2str(Nparticipants),')'])
yline(0,'K-', 'Linewidth', 2);
hold on
for i=1:size(validPupil_kComplex,1)
    plot(pupilKcomplexTime, validPupil_kComplex(i,:),'color', [.5 .5 .5])
end

% group average
[meanLine(1), semFill(1)] = stdshade(validPupil_kComplex, 0.3, pupilColor, pupilKcomplexTime); 
ylabel('\Delta Pupil Size (%)')
ylim([-20 50]) 
yticks(-20:10:50)
hxl = line([0 0],[-20, 50],'Color','k','Linewidth',2);
xlim([-windowSize windowSize])

%% 3D
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
Nparticipants = size(validHR_kComplex,1);
suptitle(['K-complexes (N= ', num2str(Nparticipants),')'])
yline(0,'k-', 'Linewidth',2);
hold on
for i=1:size(validHR_kComplex,1)
    plot(HRkcomplexTime, validHR_kComplex(i,:),'color', [.5 .5 .5])
end

% group average
[meanLine(1), semFill(1)] = stdshade(validHR_kComplex, 0.3, HRcolor, HRkcomplexTime); 
ylabel('\Delta HR Rate (%)')
ylim([-10 15]) 
hxl = line([0 0],[-10, 15],'Color','k','Linewidth',2);
xlim([-windowSize windowSize])

%% 3C
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
Nparticipants = size(valid_pupil_ST,1);

suptitle(['Spindle Trains (N= ',num2str(size(valid_pupil_ST,1)),')'])
yline(0,'k-', 'Linewidth',2);
hold on
for i=1:size(valid_pupil_ST,1)
    plot(pupilTrainTime, valid_pupil_ST(i,:),'color', [.5 .5 .5])
end

% group average
[meanLine(1), semFill(1)] = stdshade(valid_pupil_ST, 0.3, pupilColor, pupilTrainTime);
ylabel('\Delta Pupil Size (%)')
ylim([-20 50]) 
yticks(-20:10:50)
   
hxl = line([0 0],[-20, 50],'Color','k','Linewidth',2);
mean_pupil_medianEndOfTrain_all = mean(pupil_medianEndOfTrain_all,'omitnan');
lb_pupil_medianEndOfTrain_all = (mean_pupil_medianEndOfTrain_all-std(pupil_medianEndOfTrain_all,'omitnan')); % lower bound 
ub_pupil_medianEndOfTrain_all = (mean_pupil_medianEndOfTrain_all+std(pupil_medianEndOfTrain_all,'omitnan')); % upper bound
roi = lb_pupil_medianEndOfTrain_all:0.1:ub_pupil_medianEndOfTrain_all; % region of interest for shading
% hx2 = line([lb_pupil_medianEndOfTrain_all lb_pupil_medianEndOfTrain_all],[-20, 45],'Color','k','Linewidth',2,'LineStyle',':');
area(roi,50*ones(size(roi)) ,"FaceColor",spindleTrainEndRegionColor,"FaceAlpha",0.2,'LineStyle',':')
area(roi,-20*ones(size(roi)) ,"FaceColor",spindleTrainEndRegionColor,"FaceAlpha",0.2, 'LineStyle',':')
hxl = line([mean_pupil_medianEndOfTrain_all mean_pupil_medianEndOfTrain_all],[-20, 50],'Color',spindleTrainEndRegionColor,'Linewidth',2);

xlim([-windowSize windowSize])
xlabel('Time (s)')


%% 3F
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
suptitle(['Spindle Trains (N= ',num2str(size(valid_HR_ST,1)),')'])
yline(0,'K-', 'Linewidth', 2);
hold on;
for i=1:size(valid_HR_ST,1)
    plot(HRtrainTime, valid_HR_ST(i,:),'color', [.5 .5 .5])
end

% group average
[meanLine(1), semFill(1)] = stdshade(valid_HR_ST, 0.3, HRcolor, HRtrainTime);
ylabel('\Delta Heart Rate (%)')
ylim([-10 15])  

hxl = line([0 0],[-20, 50],'Color','k','Linewidth',2);
mean_pupil_medianEndOfTrain_all = mean(pupil_medianEndOfTrain_all,'omitnan');
lb_pupil_medianEndOfTrain_all = (mean_pupil_medianEndOfTrain_all-std(pupil_medianEndOfTrain_all,'omitnan')); % lower bound 
ub_pupil_medianEndOfTrain_all = (mean_pupil_medianEndOfTrain_all+std(pupil_medianEndOfTrain_all,'omitnan')); % upper bound
roi = lb_pupil_medianEndOfTrain_all:0.1:ub_pupil_medianEndOfTrain_all; % region of interest for shading
% hx2 = line([lb_pupil_medianEndOfTrain_all lb_pupil_medianEndOfTrain_all],[-20, 45],'Color','k','Linewidth',2,'LineStyle',':');
area(roi,50*ones(size(roi)) ,"FaceColor",spindleTrainEndRegionColor,"FaceAlpha",0.2,'LineStyle',':')
area(roi,-20*ones(size(roi)) ,"FaceColor",spindleTrainEndRegionColor,"FaceAlpha",0.2, 'LineStyle',':')
hxl = line([mean_pupil_medianEndOfTrain_all mean_pupil_medianEndOfTrain_all],[-20, 50],'Color',spindleTrainEndRegionColor,'Linewidth',2);
xlim([-windowSize windowSize])
xlabel('Time (s)')

%% 3B
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
suptitle(['Arousals (N= ',num2str(size(valid_pupil_Arousal,1)),')'])
yline(0,'k-', 'Linewidth',2);
hold on
for i=1:size(valid_pupil_Arousal,1)
    plot(arousalEpochTime, valid_pupil_Arousal(i,:),'color', [.5 .5 .5])
end

% group average
[meanLine(1), semFill(1)] = stdshade(valid_pupil_Arousal, 0.3, pupilColor, arousalEpochTime);
ylabel('\Delta Pupil Size (%)')
ylim([-20 50]) 
yticks(-20:10:50)

hxl = line([0 0],[-20, 50],'Color','k','Linewidth',2);
xlim([-windowSize windowSize])

xlabel('Time (s)')

%% 3E
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',24)
Nparticipants = size(valid_HR_Arousal,1);
suptitle(['Arousals (N= ',num2str(Nparticipants),')'])
yline(0,'k-', 'Linewidth',2);
hold on;
for i=1:size(valid_HR_Arousal,1)
    plot(HRkcomplexTime, valid_HR_Arousal(i,:),'color', [.5 .5 .5])
end
% group average
[meanLine(1), semFill(1)] = stdshade(valid_HR_Arousal, 0.3, HRcolor, arousalEpochTime);

ylabel('\Delta HR Rate (%)')
ylim([-10 15]) 
hxl = line([0 0],[-10, 15],'Color','k','Linewidth',2);
xlim([-windowSize windowSize])
xlabel('Time (s)')
