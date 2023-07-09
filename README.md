# Environmental Sensing and Modeling - Group Project
## Air Quality Analysis of Munich

### Project Overview

This repository contains my contribution to a group project for the course "Environmental Sensing and Modeling". The course was offered in the Summer semester of 2021, organized by the Associate Professorship of Environmental Sensing and Modeling (Prof. Chen), Technical University of Munich. We analyzed the air quality data of Munich by using various sensing methodologies, data analysis techniques, and atmospheric modeling methods taught during the course.

For comprehensive course information, please refer to the [official course page](https://campus.tum.de/tumonline/ee/ui/ca2/app/desktop/#/slc.tm.cp/student/courses/950573432?$ctx=design=ca;lang=en&$scrollTo=toc_overview).

**Note**: This repository is for educational purposes only and is intended to showcase my personal journey and learning throughout the course. Please utilize this material responsibly, respecting the principles of academic integrity and copyright rules.

### Course Content
1. Basics: properties of the atmosphere (earth, sun, other planets)
2. Sensing methodologies and instrumentations
3. Data analysis techniques
4. Atmospheric modeling
5. Machine learning for environmental applications

### My Contribution
In this project, my specific tasks included the following:

1. **Data Acquisition:** Downloaded the current NO2 data for all five Munich stations from the Bavarian environmental agency's (LfU) website.

2. **Data Conversion:** Converted the mass densities in the downloaded files to mixing ratios (unit: ppb).

3. **Data Visualization:** Plotted the NO2 mixing ratios for all five stations.

4. **Data Analysis:** Analyzed the daily cycle and the differences between the sites that were observed in the plot. Investigated the correlation between traffic data and NO2 concentration.

5. **Spatial Interpolation & Mapping:** Created a concentration map for Munich using a simple interpolation algorithm (e.g., inverse distance weighting, IDW). The map had a resolution of 1 km x 1 km and an overall dimension of 20 km x 20 km.

The specific folders/files associated with these tasks are as follows:

- `[scripts/]` : MATLAB scripts for the corresponding tasks
- `[data/]` : Data required for scripts
- `[Air Quality Data Analysis-aydin.pdf]` : Presentation for my contirbution to the group project

