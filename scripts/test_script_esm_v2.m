%% ESM
%% SCRIPT for generating a concentration map for a choosen day in June
close all;
clc;
clear;
%%%%%%% choose the day you want to generate a concentration map
day = 2; % day \in {1..... 30}
%%%%%%% choose the day you want to generate a concentration map

% read data
stachus_data = readtable('munchenstachus.NO2.csv');
allach_data = readtable('munchenallach.NO2.csv');
johanneskirchen_data = readtable('munchenjohanneskirchen.NO2.csv');
lothstrasse_data = readtable('munchenlothstrae.NO2.csv');
landshuter_allee_data = readtable('munchenlandshuter-allee.NO2.csv');

% read mass concentrations
% column 2 corresponds to concentrations
stachus_NO2_mass_concentration = table2array(stachus_data(:,2));
stachus_NO2_mass_concentration= fillmissing(stachus_NO2_mass_concentration,'movmean',10);  % fills missing entries
allach_NO2_mass_concentration = table2array(allach_data(:,2));
allach_NO2_mass_concentration= fillmissing(allach_NO2_mass_concentration,'movmean',10);  % fills missing entries
johanneskirchen_NO2_mass_concentration = table2array(johanneskirchen_data(:,2));
johanneskirchen_NO2_mass_concentration= fillmissing(johanneskirchen_NO2_mass_concentration,'movmean',10);  % fills missing entries
lothstrasse_NO2_mass_concentration = table2array(lothstrasse_data(:,2));
lothstrasse_NO2_mass_concentration= fillmissing(lothstrasse_NO2_mass_concentration,'movmean',10);  % fills missing entries
landshuter_allee_NO2_mass_concentration = table2array(landshuter_allee_data(:,2));
landshuter_allee_NO2_mass_concentration= fillmissing(landshuter_allee_NO2_mass_concentration,'movmean',10);  % fills missing entries

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

% get day indexes
day_idx = ((day-1)*24 + 1) : day*24;

% Mixing ratio plot for the choosen day
fig1=figure;
plot(t(day_idx),mixing_ratio_stachus(day_idx),'Linewidth',2); hold on;
plot(t(day_idx),mixing_ratio_allach(day_idx),'Linewidth',2); hold on;
plot(t(day_idx),mixing_ratio_johanneskirchen(day_idx),'Linewidth',2); hold on;
plot(t(day_idx),mixing_ratio_lothstrasse(day_idx),'Linewidth',2); hold on;
plot(t(day_idx),mixing_ratio_landshuter_allee(day_idx),'Linewidth',2);
legend('Stachus','Allach','Johanneskirchen','Lothstraße','Landshuter Allee');
ylabel('mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(gca,'Fontsize',18);
xlim([t(day_idx(1)) t(day_idx(end))]);
grid on;
set(fig1, 'PaperPositionMode', 'auto', 'Units', 'Centimeters', 'Position', [2 2 35 20]);
% print(fig1,'fig1', '-depsc');

% allach
dist_1 = zeros(20,20);
c_1 = mean(mixing_ratio_allach(day_idx));
% landshut
dist_2 = zeros(20,20);
c_2 = mean(mixing_ratio_landshuter_allee(day_idx));
% lothstraße
dist_3 = zeros(20,20);
c_3 = mean(mixing_ratio_lothstrasse(day_idx));
% stachus
dist_4 = zeros(20,20);
c_4 = mean(mixing_ratio_stachus(day_idx));
% johanneskirchen
dist_5 = zeros(20,20);
c_5 = mean(mixing_ratio_johanneskirchen(day_idx));


%%%%%% please take a look at 'munich_grid.png' to understand how I
%%%%%% determine the coordinates of each station on the 20x20 grid
% The grid on 'munich_grid.png' correponds to a square of size 20 km x 20
% km
% I measured it on Google Earth and it should be correct.
% as can be seen on 'munich_grid.png' for ex. Allach station hast the
% coordinates x=3,y=7
% using this info. I calculated the distance matrix

% dist_1 allach x=3,y=7;
for idx_y=1 :20
    for idx_x=1 :20
        dist_1(idx_y,idx_x)=sqrt(abs(idx_y-7)^2 + abs(idx_x-3)^2);
    end
end
% dist_2 landshut x=9,y=10;
for idx_y=1 :20
    for idx_x=1 :20
        dist_2(idx_y,idx_x)=sqrt(abs(idx_y-10)^2 + abs(idx_x-9)^2);
    end
end
% dist_3 lothstraße x=10,y=10;
for idx_y=1 :20
    for idx_x=1 :20
        dist_3(idx_y,idx_x)=sqrt(abs(idx_y-10)^2 + abs(idx_x-10)^2);
    end
end
% dist_4 stachus x=11,y=12;
for idx_y=1 :20
    for idx_x=1 :20
        dist_4(idx_y,idx_x)=sqrt(abs(idx_y-12)^2 + abs(idx_x-11)^2);
    end
end
% dist_5 johanneskirchen x=17,y=8;
for idx_y=1 :20
    for idx_x=1 :20
        dist_5(idx_y,idx_x)=sqrt(abs(idx_y-8)^2 + abs(idx_x-17)^2);
    end
end

% convert to weights
weight_1 = 1./dist_1;
weight_2 = 1./dist_2;
weight_3 = 1./dist_3;
weight_4 = 1./dist_4;
weight_5 = 1./dist_5;

% calculate concetrations
concentrations = (weight_1 * c_1 +weight_2 * c_2 + weight_3 * c_3 + weight_4 * c_4 + weight_5 * c_4)./(weight_1 + weight_2 + weight_3 + weight_4 + weight_5);
% assign the concentrations of each station at the corresponding points.
concentrations(7,3) = c_1;
concentrations(10,9) = c_2;
concentrations(10,10) = c_3;
concentrations(12,11) = c_4;
concentrations(8,17) = c_5;

concentrations = imgaussfilt(concentrations,0.8,'Padding','replicate'); % filters image 'concentrations' with a 2-D Gaussian smoothing kernel with standard deviation of 0.8.
% 'replicate' -> Input image values outside the bounds of the image are assumed equal to the nearest image border value.


fig2=figure;
% plot and get size of the image
I=imread('area.png');
[size_y, size_x, ~ ]=size(I);
imshow(I); hold on;
for i =1:20
    for j=1:20
        % plot concentrations and set the transparency
        imagesc(1 + ceil(size_x/20)*(i-1) : i*ceil(size_x/20),1 + ceil(size_y/20)*(j-1) : j*ceil(size_y/20),repmat(concentrations(j,i),ceil(size_x/20),ceil(size_y/20)),'AlphaData', .71); hold on;
    end
end
h = colorbar;
colormap jet;
caxis([0,40]);
set(get(h,'label'),'string','mixing ratio NO_2 [unit : ppb]','Fontsize',18);
set(gca,'Fontsize',18);
% print(fig2,num2str(day), '-depsc');



