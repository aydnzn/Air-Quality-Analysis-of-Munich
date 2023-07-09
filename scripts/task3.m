%% ESM
%% RUN by section
%% TASK 3
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
allach_NO2_mass_concentration= fillmissing(allach_NO2_mass_concentration,'movmean',10);% fills missing entries
johanneskirchen_NO2_mass_concentration = table2array(johanneskirchen_data(:,2));
johanneskirchen_NO2_mass_concentration= fillmissing(johanneskirchen_NO2_mass_concentration,'movmean',10);% fills missing entries
lothstrasse_NO2_mass_concentration = table2array(lothstrasse_data(:,2));
lothstrasse_NO2_mass_concentration= fillmissing(lothstrasse_NO2_mass_concentration,'movmean',10);% fills missing entries
landshuter_allee_NO2_mass_concentration = table2array(landshuter_allee_data(:,2));
landshuter_allee_NO2_mass_concentration= fillmissing(landshuter_allee_NO2_mass_concentration,'movmean',10);% fills missing entries

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

% for plotting purposes need to extract time points
date = table2array(stachus_data(:,1));

t = datetime(date,'InputFormat','uuuu-MM-dd''T''HH-mm-ss');

f=figure;
plot(t(1:48),mixing_ratio_stachus(1:48),'Linewidth',2); hold on;
plot(t(1:48),mixing_ratio_allach(1:48),'Linewidth',2); hold on;
plot(t(1:48),mixing_ratio_johanneskirchen(1:48),'Linewidth',2); hold on;
plot(t(1:48),mixing_ratio_lothstrasse(1:48),'Linewidth',2); hold on;
plot(t(1:48),mixing_ratio_landshuter_allee(1:48),'Linewidth',2);
legend('Stachus','Allach','Johanneskirchen','Lothstraße','Landshuter Allee');
ylabel('mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(gca,'Fontsize',18);
xlim([t(1) t(48)]);
grid on;
set(f, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(f,'task3', '-depsc');
