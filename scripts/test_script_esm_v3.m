%% ESM
%% SCRIPT to visualize concentrations in month June by creating an image with scaled colors and to compare traffic data for stations LHA, Stachus, Landshuter Allee with their mixing ratios.
close all;
clc;
clear;

% read data
stachus_data = readtable('munchenstachus.NO2.csv');
allach_data = readtable('munchenallach.NO2.csv');
johanneskirchen_data = readtable('munchenjohanneskirchen.NO2.csv');
lothstrasse_data = readtable('munchenlothstrae.NO2.csv');
landshuter_allee_data = readtable('munchenlandshuter-allee.NO2.csv');

% read mass concentrations
% column 2 corresponds to concentrations
stachus_NO2_mass_concentration = table2array(stachus_data(:,2));
stachus_NO2_mass_concentration= fillmissing(stachus_NO2_mass_concentration,'movmean',10); % fills missing entries
allach_NO2_mass_concentration = table2array(allach_data(:,2));
allach_NO2_mass_concentration= fillmissing(allach_NO2_mass_concentration,'movmean',10); % fills missing entries
johanneskirchen_NO2_mass_concentration = table2array(johanneskirchen_data(:,2));
johanneskirchen_NO2_mass_concentration= fillmissing(johanneskirchen_NO2_mass_concentration,'movmean',10); % fills missing entries
lothstrasse_NO2_mass_concentration = table2array(lothstrasse_data(:,2));
lothstrasse_NO2_mass_concentration= fillmissing(lothstrasse_NO2_mass_concentration,'movmean',10); % fills missing entries
landshuter_allee_NO2_mass_concentration = table2array(landshuter_allee_data(:,2));
landshuter_allee_NO2_mass_concentration= fillmissing(landshuter_allee_NO2_mass_concentration,'movmean',10); % fills missing entries


% define constants
molar_mass_NO2 = 46; % in g/mol
number_density_dry_air = 41.6; % in mol/m3

% calculate mixing ratio using the formula
% multiply with 1e9 to convert it to ppb
% do not forget to multiply the concentrations with 1e-6 as they are given
% in µg
% mass density NO2 / molar mass NO2 = number density NO2
% mixing ratio NO2 = number density NO2 / number density dry air
mixing_ratio_stachus=1e9*(stachus_NO2_mass_concentration*1e-6)/(molar_mass_NO2*number_density_dry_air); % in ppb
mixing_ratio_allach=1e9*(allach_NO2_mass_concentration*1e-6)/(molar_mass_NO2*number_density_dry_air); % in ppb
mixing_ratio_johanneskirchen=1e9*(johanneskirchen_NO2_mass_concentration*1e-6)/(molar_mass_NO2*number_density_dry_air); % in ppb
mixing_ratio_lothstrasse=1e9*(lothstrasse_NO2_mass_concentration*1e-6)/(molar_mass_NO2*number_density_dry_air); % in ppb
mixing_ratio_landshuter_allee=1e9*(landshuter_allee_NO2_mass_concentration*1e-6)/(molar_mass_NO2*number_density_dry_air); % in ppb

% create matrices
% each column corresponds to a single day
matrix_mr_stachus=reshape(mixing_ratio_stachus,[24 30]);
matrix_mr_allach=reshape(mixing_ratio_allach,[24 30]);
matrix_mr_johanneskirchen=reshape(mixing_ratio_johanneskirchen,[24 30]);
matrix_mr_lothstrasse=reshape(mixing_ratio_lothstrasse,[24 30]);
matrix_mr_landshuter_allee=reshape(mixing_ratio_landshuter_allee,[24 30]);

% STACHUS
f1 = figure;
imagesc(matrix_mr_stachus);
ylabel('time','Fontsize',18);
xlabel('Days');
title('Stachus');
set(gca,'Fontsize',18);
xticks([5,6,12,13,19,20,26,27]); % weekends
h = colorbar;
colormap jet;
caxis([0,40]);
set(get(h,'label'),'string','mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(f1, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f1,'matrix_mr_stachus', '-depsc');  % uncomment if you want to
% print

% LOTHSTRASSE
f2 = figure;
imagesc(matrix_mr_lothstrasse);
ylabel('time','Fontsize',18);
xlabel('Days');
title('Lothstraße');
set(gca,'Fontsize',18);
xticks([5,6,12,13,19,20,26,27]); % weekends
h = colorbar;
colormap jet;
caxis([0,40]);
set(get(h,'label'),'string','mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(f2, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f2,'matrix_mr_lothstrasse', '-depsc');  % uncomment if you want to
% print

% Landshuter Allee
f3 = figure;
imagesc(matrix_mr_landshuter_allee);
ylabel('time','Fontsize',18);
xlabel('Days');
title('Landshuter Allee');
set(gca,'Fontsize',18);
xticks([5,6,12,13,19,20,26,27]); % weekends
h = colorbar;
colormap jet;
caxis([0,40]);
set(get(h,'label'),'string','mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(f3, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f3,'matrix_mr_landshuter_allee', '-depsc');  % uncomment if you
% want to print


% for plotting purposes need to extract time points
date = table2array(stachus_data(:,1));
t = datetime(date,'InputFormat','uuuu-MM-dd''T''HH-mm-ss');

% find mean and standard error mean of STACHUS, LHA, Lothstraße
mean_mr_stachus = mean(matrix_mr_stachus,2);
sem_mr_stachus = std( matrix_mr_stachus,0,2 ) / sqrt( size( matrix_mr_stachus,2 ));
mean_mr_lothstrasse = mean(matrix_mr_lothstrasse,2);
sem_mr_lothstrasse = std( matrix_mr_lothstrasse,0,2 ) / sqrt( size( matrix_mr_lothstrasse,2 ));
mean_mr_landshuter_allee = mean(matrix_mr_landshuter_allee,2);
sem_mr_landshuter_allee = std( matrix_mr_landshuter_allee,0,2 ) / sqrt( size( matrix_mr_landshuter_allee,2 ));


% read traffic data
traffic_data = readtable('traffic.csv');
traffic_info = table2array(traffic_data(:,4:end));
% col. 1 LHA; col. 2 LOT; col. 3 STA


%%%%%%%%%% this part is manual
% in 't' vector first time point is 01:00 therefore I assigned manually
% the corresponding traffic info as the initial point in
% 'traffic_lothstrasse' vector
traffic_lothstrasse = [traffic_info(2,2:end),traffic_info(2,1)];
interpolated_traffic_lothstrasse = interp1(1:24,traffic_lothstrasse,1:0.1:24,'spline'); % smooth data by interpolating
% in 't' vector first time point is 01:00 therefore I assigned manually
% the corresponding traffic info as the initial point in my
% 'traffic_landshuter_allee' vector
traffic_landshuter_allee = [traffic_info(1,2:end),traffic_info(1,1)];
interpolated_traffic_landshuter_allee = interp1(1:24,traffic_landshuter_allee,1:0.1:24,'spline');  % smooth data by interpolating
% in 't' vector first time point is 01:00 therefore I assigned manually
% the corresponding traffic info as the initial point in my
% 'traffic_stachus' vector
traffic_stachus = [traffic_info(3,2:end),traffic_info(3,1)];
interpolated_traffic_stachus = interp1(1:24,traffic_stachus,1:0.1:24,'spline'); % smooth data by interpolating
%%%%%%%%%% this part is manual

% COMPARE TRAFFIC DATA AND MIXING RATIOS FOR STACHUS
interpolated_mean_mr_stachus = interp1(1:24,mean_mr_stachus,1:0.1:24,'spline'); % smooth data by interpolating
interpolated_sem_mr_stachus = interp1(1:24,sem_mr_stachus,1:0.1:24,'spline'); % smooth data by interpolating
f4=figure;
yyaxis left;
plot(1:0.1:24,interpolated_mean_mr_stachus,'b','LineWidth',2); hold on;
plot(1:0.1:24,interpolated_mean_mr_stachus-interpolated_sem_mr_stachus,'c--','LineWidth',1); hold on;
plot(1:0.1:24,interpolated_mean_mr_stachus+interpolated_sem_mr_stachus,'c--','LineWidth',1);
ylabel('mixing ratio NO_2 [unit : ppb]','Fontsize',18)
yyaxis right;
plot(1:0.1:24,interpolated_traffic_stachus,'r','LineWidth',2); hold on;
ylabel('traffic sensor data','Fontsize',18);
xlabel('time');
title('Stachus');
set(gca,'Fontsize',18);
xlim([1 24]);
ax = gca;
ax.YAxis(1).Color = 'b';
ax.YAxis(2).Color = 'r';
set(f4, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f4,'traffic_MR_Stachus', '-depsc'); % uncomment if you want to
% print


% COMPARE TRAFFIC DATA AND MIXING RATIOS FOR LOTHSTRASSE
interpolated_mean_mr_lothstrasse = interp1(1:24,mean_mr_lothstrasse,1:0.1:24,'spline'); % smooth data by interpolating
interpolated_sem_mr_lothstrasse = interp1(1:24,sem_mr_lothstrasse,1:0.1:24,'spline'); % smooth data by interpolating
f5=figure;
yyaxis left;
plot(1:0.1:24,interpolated_mean_mr_lothstrasse,'b','LineWidth',2); hold on;
plot(1:0.1:24,interpolated_mean_mr_lothstrasse-interpolated_sem_mr_lothstrasse,'c--','LineWidth',1); hold on;
plot(1:0.1:24,interpolated_mean_mr_lothstrasse+interpolated_sem_mr_lothstrasse,'c--','LineWidth',1);
ylabel('mixing ratio NO_2 [unit : ppb]','Fontsize',18)
yyaxis right;
plot(1:0.1:24,interpolated_traffic_lothstrasse,'r','LineWidth',2); hold on;
ylabel('traffic sensor data','Fontsize',18);
xlabel('time');
title('Lothstrasse');
set(gca,'Fontsize',18);
xlim([1 24]);
ax = gca;
ax.YAxis(1).Color = 'b';
ax.YAxis(2).Color = 'r';
set(f5, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f5,'traffic_MR_Lothstrasse', '-depsc'); %uncomment if you want to
% print



% COMPARE TRAFFIC DATA AND MIXING RATIOS FOR LHA
interpolated_mean_mr_landshuter_allee = interp1(1:24,mean_mr_landshuter_allee,1:0.1:24,'spline'); % smooth data by interpolating
interpolated_sem_mr_landshuter_allee = interp1(1:24,mean_mr_landshuter_allee,1:0.1:24,'spline'); % smooth data by interpolating
f6=figure;
yyaxis left;
plot(1:0.1:24,interpolated_mean_mr_landshuter_allee,'b','LineWidth',2); hold on;
plot(1:0.1:24,interpolated_mean_mr_landshuter_allee-interpolated_sem_mr_landshuter_allee,'c--','LineWidth',1); hold on;
plot(1:0.1:24,interpolated_mean_mr_landshuter_allee+interpolated_sem_mr_landshuter_allee,'c--','LineWidth',1);
ylabel('mixing ratio NO_2 [unit : ppb]','Fontsize',18)
yyaxis right;
plot(1:0.1:24,interpolated_traffic_landshuter_allee,'r','LineWidth',2); hold on;
ylabel('traffic sensor data','Fontsize',18);
xlabel('time');
title('Landshuter Allee');
set(gca,'Fontsize',18);
xlim([1 24]);
ax = gca;
ax.YAxis(1).Color = 'b';
ax.YAxis(2).Color = 'r';
set(f6, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f6,'traffic_MR_LHA', '-depsc'); % uncomment if you want to print




