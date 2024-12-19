%% Figure4.m
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

load('Figure4.mat')

%% plot figure 4
figure('units','normalized','outerposition',[0 0 1 1])
set(gcf,'color','w','defaultAxesFontSize',12)

%% 4A
subplot(2,3,1)
hold on
% title(['Pupil Size: N=', num2str(nValid_Participants)])
yline(0,'K-', 'Linewidth', 2);
[meanLine(1), semFill(1)] = stdshade(pupil_sham_all,shading, shamColor, epochTime);
[meanLine(2), semFill(2)] = stdshade(pupil_verum_all, shading, verumColor, epochTime);   

ylabel('\Delta Pupil Size (%)') 
ylim([-30 120]) 
yticks([-10, 0, 20, 40, 60, 80, 100, 120])
hxl = line([0 0],[-30 120],'Color','k','Linewidth',2);

xlim(plotRange)

legend(meanLine([1,2]),{'Sham', 'Verum'}, 'Location', 'northeast')
xlabel('Time (s)')

%% 4B
subplot(2,3,2)
hold on
% title(['Sigma: N=', num2str(nValid_Participants)])
yline(0,'K-', 'Linewidth', 2);
[meanLine(1), semFill(1)] = stdshade(sigma_sham_all,shading, shamColor, epochTime);
[meanLine(2), semFill(2)] = stdshade(sigma_verum_all, shading, verumColor, epochTime);   

ylabel('Sigma Power (\muV^2)')
ylim([-4.44 20]) 
yticks(0:4:20)
hxl = line([0 0],[-4.44 20],'Color','k','Linewidth',2);

xlim(plotRange)
legend(meanLine([1,2]),{'Sham', 'Verum'}, 'Location', 'northeast')
xlabel('Time (s)')

%% 4C

subplot(2,3,3)
hold on
% title(['Delta: N=', num2str(nValid_Participants)])
yline(0,'K-', 'Linewidth', 2);
[meanLine(1), semFill(1)] = stdshade(delta_sham_all,shading, shamColor, epochTime);
[meanLine(2), semFill(2)] = stdshade(delta_verum_all, shading, verumColor, epochTime);   

ylabel('Delta Power (\muV^2)')
ylim([-1000 4500]) 
yticks(0:500:4500)
hxl = line([0 0],[-1000 4500],'Color','k','Linewidth',2);

xlim(plotRange)
legend(meanLine([1,2]),{'Sham', 'Verum'}, 'Location', 'northeast')
xlabel('Time (s)')

%% 4D
subplot(2,3,4)
yline(0,'K-', 'Linewidth', 2);
hold on;
for s=1:size(pupil_sham_all_roi,1)
        plot(x, pupil_sham_all_roi(s,:), 'color', shamColor)
end


for s=1:size(pupil_verum_all_roi,1)
    plot(x, pupil_verum_all_roi(s,:), 'color', verumColor)
end

plot(x, mean(pupil_sham_all_roi,1,'omitnan'), 'Color', shamColor, 'Linewidth', lw) 
plot(x, mean(pupil_sham_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',shamColor,'MarkerSize',9)

plot(x, mean(pupil_verum_all_roi,1,'omitnan'), 'Color', verumColor, 'Linewidth', lw) 
plot(x, mean(pupil_verum_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',verumColor,'MarkerSize',9)

ylabel('\Delta Pupil Size (%)') 
ylim([-30 120]) 
yticks([-10, 0, 20, 40, 60, 80, 100, 120])
xticks([-5,0, 2.5,7.5,12.5,15])

hxl = line([0 0],[-30 120],'Color','k','Linewidth',2);
xlim(plotRange)
xlabel('Time (s)')

%% 4E
subplot(2,3,5)
yline(0,'K-', 'Linewidth', 2);
hold on;
for s=1:size(sigma_sham_all_roi,1)
        plot(x, sigma_sham_all_roi(s,:), 'color', shamColor)
end


for s=1:size(sigma_verum_all_roi,1)
    plot(x, sigma_verum_all_roi(s,:), 'color', verumColor)
end

plot(x, mean(sigma_sham_all_roi,1,'omitnan'), 'Color', shamColor, 'Linewidth', lw) 
plot(x, mean(sigma_sham_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',shamColor,'MarkerSize',9)

plot(x, mean(sigma_verum_all_roi,1,'omitnan'), 'Color', verumColor, 'Linewidth', lw) 
plot(x, mean(sigma_verum_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',verumColor,'MarkerSize',9)

ylabel('Sigma Power (\muV^2)')

ylim([-4.44 20]) 
yticks(0:4:20)
xticks([-5,0, 2.5,7.5,12.5,15])

hxl = line([0 0],[-4.44 20],'Color','k','Linewidth',2);
xlim(plotRange)
xlabel('Time (s)')

%% 4F
subplot(2,3,6)
yline(0,'K-', 'Linewidth', 2);
hold on;
for s=1:size(delta_sham_all_roi,1)
        plot(x, delta_sham_all_roi(s,:), 'color', shamColor)
end


for s=1:size(delta_verum_all_roi,1)
    plot(x, delta_verum_all_roi(s,:), 'color', verumColor)
end

plot(x, mean(delta_sham_all_roi,1,'omitnan'), 'Color', shamColor, 'Linewidth', lw) 
plot(x, mean(delta_sham_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',shamColor,'MarkerSize',9)

plot(x, mean(delta_verum_all_roi,1,'omitnan'), 'Color', verumColor, 'Linewidth', lw) 
plot(x, mean(delta_verum_all_roi,1,'omitnan'),'o','MarkerEdge','k','MarkerFace',verumColor,'MarkerSize',9)

ylabel('Delta Power (\muV^2)')

ylim([-1000 4500]) 
yticks(0:500:4500)
xticks([-5,0, 2.5,7.5,12.5,15])
hxl = line([0 0],[-1000 4500],'Color','k','Linewidth',2);
xlim(plotRange)

xlabel('Time (s)')

