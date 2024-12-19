%% Figure1_CDE.m
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

load('Figure1_CDE.mat')

%% plot figure 1_CDE
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',18)
ax0 = subplot(7,1,1);
hold on; 
plot(time, ss, 'Color', 'k','LineWidth',2); % N3
plot(ssTimeN3, ssN3, 'Color', colors{1},'LineWidth',2); % N3
plot(ssTimeN2, ssN2, 'Color', colors{2},'LineWidth',2); % N2
plot(ssTimeN1, ssN1, 'Color', colors{3},'LineWidth',2); % N1
plot(ssTimeWake,ssWake, 'Color', colors{4},'LineWidth',2); % Wake
plot(ssTimeREM,ssREM, 'Color', colors{5},'LineWidth',2); % REM
yticks([-3 -2 -1 0 1]) 
yticklabels({'N3','N2','N1', 'R', 'W'})
datetick('x', 'HH:MM')
xlim([[0 3.5*3600]+23*3600]/(24 * 60 * 60)) % limits from time 0 to 3.5 hours
ax1 = subplot(7,1,[2,3]);
hold on; 
plot(pupilTimeN3, pupilN3, 'Color', colors{1},'LineWidth',2); % N3
plot(pupilTimeN2, pupilN2, 'Color', colors{2},'LineWidth',2); % N2
plot(pupilTimeN1, pupilN1, 'Color', colors{3},'LineWidth',2); % N1
plot(pupilTimeWake,pupilWake, 'Color', colors{4},'LineWidth',2); % Wake
plot(pupilTimeREM,pupilREM, 'Color', colors{5},'LineWidth',2); % REM
ylabel('Pupil Size (arb. units)')
xlim([0 3.5])
xticks(0:0.5:3.5)
datetick('x', 'HH:MM')
xlim([[0 3.5*3600]+23*3600]/(24 * 60 * 60)) % limits from time 0 to 3.5 hours
ylim([0.1 0.7])
yticks([0.1 0.3 0.5 0.7])

ax2 = subplot(7,1,[4,5]);
hold on; 
plot(slopeTimeN3, slopeN3, 'Color', colors2{1},'LineWidth',2); % N3
plot(slopeTimeN2, slopeN2, 'Color', colors2{2},'LineWidth',2); % N2
plot(slopeTimeN1, slopeN1, 'Color', colors2{3},'LineWidth',2); % N1
plot(slopeTimeWake,slopeWake, 'Color', colors2{4},'LineWidth',2); % Wake
plot(slopeTimeREM,slopeREM, 'Color', colors2{5},'LineWidth',2); % REM
ylabel('Spectral Slope (arb. units)')
xlim([0 3.5])
xticks(0:0.5:3.5)
datetick('x', 'HH:MM')
xlim([[0 3.5*3600]+23*3600]/(24 * 60 * 60)) % limits from time 0 to 3.5 hours

ylim([-8 5])
yticks([-8 -4 0 4])

ax3 = subplot(7,1,[6,7]);
hold on; 
plot(IHRTimeN3, IHRN3, 'Color', colors{1},'LineWidth',2); % N3
plot(IHRTimeN2, IHRN2, 'Color', colors{2},'LineWidth',2); % N2
plot(IHRTimeN1, IHRN1, 'Color', colors{3},'LineWidth',2); % N1
plot(IHRTimeWake,IHRWake, 'Color', colors{4},'LineWidth',2); % Wake
plot(IHRTimeREM,IHRREM, 'Color', colors{5},'LineWidth',2); % REM
ylabel('Heart Rate (BPM)')
xlim([0 3.5])
xticks(0:0.5:3.5)
datetick('x', 'HH:MM')
xlim([[0 3.5*3600]+23*3600]/(24 * 60 * 60)) % limits from time 0 to 3.5 hours

ylim([50 100])
yticks([50 70 90])
xlabel('Time')
