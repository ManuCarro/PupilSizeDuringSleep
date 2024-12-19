%% Figure2.m
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

load('Figure2.mat')

%% plot figure 2
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',12)
%% 2A
subplot(3,5,[1,2])
yyaxis right
plot(sigmaTimeN2, sigmaN2, 'Color', 'k','LineWidth',2); % N2
ylh1= ylabel('Central Sigma Power (\muV^2)');
yticks(0:20:60)
ylim([0 60])

yyaxis left
plot(pupilTimeN2, pupilN2, 'Color', pupilColor,'LineWidth',2); % N2
ylh2 = ylabel('Pupil Size (arb. units)');
xlabel('Time (s)')
ylim([0.2 0.5])
yticks(0.2:0.1:0.5)

xlim([8050 8250])
pause(0.2)
ylh1.Position(1)=ylh1.Position(1)-dx;
ylh1.FontSize=10;
set(gca,'XColor', 'black','YColor','black')
ax = gca;
ax.YAxis(1).Color = pupilColor;
ax.YAxis(2).Color = 'k';

%% 2B
subplot(3,5,[6,7])
yyaxis right
plot(sigmaTimeN2, sigmaN2, 'Color', 'k','LineWidth',2); % N2
ylh2 = ylabel('Central Sigma Power (\muV^2)');
yticks(0:20:60)
ylim([0 60])

yyaxis left
plot(HRTimeN2, HRN2, 'Color', HRcolor,'LineWidth',2); % N2
ylabel('Heart Rate (BPM)');
xlabel('Time (s)')
% ylim([0.2 0.5])
yticks(64:6:76)

xlim([8050 8250])
pause(0.2)
ylh2.Position(1)=ylh2.Position(1)-dx;
ylh2.FontSize=10;

set(gca,'XColor', 'black','YColor','black')
ax = gca;
ax.YAxis(1).Color = HRcolor;
ax.YAxis(2).Color = 'k';

%% 2C
subplot(3,5,[11,12])
yyaxis right
plot(sigmaTimeN2, sigmaN2, 'Color', 'k','LineWidth',2); % N2
ylh3 = ylabel('Central Sigma Power (\muV^2)');
yticks(0:20:60)
ylim([0 60])

yyaxis left
hold on
for k=1:length(isKCtime) % k-complex points
    scatter(isKCtime(k), 80, 80,KCcolor, "filled");
end
plot(FPZTimeN2, FPZN2, 'Color', FPZcolor,'LineWidth',2); % N2

ylabel('Frontal Electrode (\muV)')
xlabel('Time (s)')
ylim([-500 100])
yticks(-200:100:100)

xlim([8050 8250])
pause(0.2)
ylh3.Position(1)=ylh3.Position(1)-dx;
ylh3.FontSize=10;

set(gca,'XColor', 'black','YColor','black')
ax = gca;
ax.YAxis(1).Color = FPZcolor;
ax.YAxis(2).Color = 'k';

%% 2D
ax1 = subplot(3,5,[3,4]); 
set(ax1,'ColorOrder', [0,0,0]);
yyaxis right
[meanLine(1), semFill(1)] = stdshade(sigmaPower, 0.3, 'k', percentageCycle);
label(1,1) = "Sigma Power";
% ylabel('Sigma Power (\muV^2) ')
ylim([4 16])
yticks(5:5:15)

yyaxis left
[meanLine(2), semFill(2)] = stdshade(pupilSize_Norm, 0.3, pupilColor, percentageCycle);
label(2,1) = "Pupil";
ylh4 = ylabel('\Delta Pupil Size (%)');
pause(0.2)
ylh4.Position(1)=ylh4.Position(1)+dx;
ylh4.FontSize=10;
ylim([-10 10])

set(ax1,'XColor', 'black','YColor','black')
ax1.YAxis(1).Color = pupilColor;
ax1.YAxis(2).Color = 'k';
xlabel('Cycle %')

%% 2E
ax3 = subplot(3,5,[8,9]); 
set(ax3,'ColorOrder', [0,0,0]);
yyaxis right
[meanLine(1), semFill(1)] = stdshade(sigmaPower, 0.3, 'k', percentageCycle);
label(1,1) = "Sigma Power";
% ylabel('Sigma Power (\muV^2) ')
ylim([4 16])
yticks(5:5:15)

yyaxis left
[meanLine(2), semFill(2)] = stdshade(HR_Norm, 0.3, HRcolor, percentageCycle);
label(2,1) = "Heart Rate";
ylh5 = ylabel('\Delta Heart Rate (%)');
pause(0.2)
ylh5.Position(1)=ylh5.Position(1)+0.5*dx;
ylh5.FontSize=10;
ylim([-3 3])

set(ax3,'XColor', 'black','YColor','black')
ax3.YAxis(1).Color = HRcolor;
ax3.YAxis(2).Color = 'k';
xlabel('Cycle %')

%% 2F
ax5 = subplot(3,5,[13,14]); 
yyaxis right
[meanLine(1), semFill(1)] = stdshade(sigmaPower, 0.3, 'k', percentageCycle);
label(1,1) = "Sigma Power";
% ylabel('Sigma Power (\muV^2) ')
ylim([4 16])
yticks(5:5:15)

yyaxis left
[meanLine(2), semFill(2)] = stdshade(KCs, 0.3, KCcolor, percentageCycle);
label(2,1) = "K-Complexes";
ylh6 = ylabel('K-Complex Likelihood (%)');
pause(0.2)
ylh6.Position(1)=ylh6.Position(1)+0.25*dx;
ylh6.FontSize=10;
ylim([0 7])
yticks([0 2 4 6])
xlabel('% Cycle')

set(ax5,'XColor', 'black','YColor','black')
ax5.YAxis(1).Color = KCcolor;
ax5.YAxis(2).Color = 'k';

%% 2G
% bins
lw = 4; % linewidth
ax2 = subplot(3,5,5); 
hold on
for p=1:size(sigmaPower,1)
    plot([1,2,3,4], [pupilRegions_Norm(p,1), pupilRegions_Norm(p,2), pupilRegions_Norm(p,3), pupilRegions_Norm(p,4)], 'Color', FPZcolor, 'Linewidth', lw/4) 
end

plot([1,2,3,4], mean([pupilRegions_Norm(:,1), pupilRegions_Norm(:,2), pupilRegions_Norm(:,3), pupilRegions_Norm(:,4)],1), 'Color', pupilColor, 'Linewidth', lw) 
plot([1,2,3,4], mean([pupilRegions_Norm(:,1), pupilRegions_Norm(:,2), pupilRegions_Norm(:,3), pupilRegions_Norm(:,4)],1),'o','MarkerEdge','k','MarkerFace',pupilColor,'MarkerSize',9)

ylabel('\Delta Pupil Size (%)')
xticks(1:4)
xticklabels({'Rise', 'Peak', 'Fall', 'Trough'})
xlim([0.5 4.5])
ax2.YAxis(1).Color = pupilColor;

%% 2H
ax4 = subplot(3,5,10); 
hold on
for p=1:size(sigmaPower,1)
    plot([1,2,3,4], [hrRegions_Norm(p,1), hrRegions_Norm(p,2), hrRegions_Norm(p,3), hrRegions_Norm(p,4)], 'Color', FPZcolor, 'Linewidth', lw/4) 
end

plot([1,2,3,4], mean([hrRegions_Norm(:,1), hrRegions_Norm(:,2), hrRegions_Norm(:,3), hrRegions_Norm(:,4)],1), 'Color', HRcolor, 'Linewidth', lw) 
plot([1,2,3,4], mean([hrRegions_Norm(:,1), hrRegions_Norm(:,2), hrRegions_Norm(:,3), hrRegions_Norm(:,4)],1),'o','MarkerEdge','k','MarkerFace',HRcolor,'MarkerSize',9)
ylabel('\Delta Heart Rate (%)')
xticks(1:4)
xticklabels({'Rise', 'Peak', 'Fall', 'Trough'})
xlim([0.5 4.5])
ax4.YAxis(1).Color = HRcolor;

%% 2I
ax6 = subplot(3,5,15); 
hold on
for p=1:size(sigmaPower,1)
    plot([1,2,3,4], [kcRegions(p,1), kcRegions(p,2), kcRegions(p,3), kcRegions(p,4)], 'Color', FPZcolor, 'Linewidth', lw/4) 
end

plot([1,2,3,4], mean([kcRegions(:,1), kcRegions(:,2), kcRegions(:,3), kcRegions(:,4)],1), 'Color', KCcolor, 'Linewidth', lw) 
plot([1,2,3,4], mean([kcRegions(:,1), kcRegions(:,2), kcRegions(:,3), kcRegions(:,4)],1),'o','MarkerEdge','k','MarkerFace',KCcolor,'MarkerSize',9)
ylabel('K-Complex Likelihood (%)')
xticks(1:4)
xticklabels({'Rise', 'Peak', 'Fall', 'Trough'})
xlim([0.5 4.5])
ax6.YAxis(1).Color = KCcolor;

