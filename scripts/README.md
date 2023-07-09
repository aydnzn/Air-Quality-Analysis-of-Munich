## Script Descriptions

1. **task3.m:** This script represents the core of the data processing and visualization for this project. It loads the NO2 data, processes it, converts the units, extracts the time points, and finally generates a plot of the NO2 mixing ratios over time for each station. All the processed and visualized data are representative of a 48-hour time span.

2. **test_script_esm_v2.m:** This script generates a concentration map of Nitrogen Dioxide (NO2) for a specific day in June using data from five different locations in Munich. The script reads data, handles missing entries, converts mass concentrations to mixing ratios, and performs several other tasks to generate a detailed concentration map.

3. **test_script_esm_v3.m:** This script is designed to visualize NO2 concentrations in the atmosphere at different locations in Munich for the month of June. It also performs an analysis and visualization of the correlations between NO2 mixing ratios and traffic sensor data for several specified locations.

4. **test_script_esm_v4.m:** This MATLAB script generates 30 concentration maps for the month of June, one for each day. These maps show the average Nitrogen Dioxide (NO2) mixing ratio for each day. The script calculates a mixing ratio for each station and then calculates a "concentration map" for each day of the month.

## How to Use

For each script, make sure the required CSV files and any necessary images are in the same directory as the script file. Set any desired parameters (such as the specific day for the `test_script_esm_v2.m` script) at the beginning of the script and then run it.

## Requirements

The following files should be in your script directory:
- munchenstachus.NO2.csv
- munchenallach.NO2.csv
- munchenjohanneskirchen.NO2.csv
- munchenlothstrae.NO2.csv
- munchenlandshuter-allee.NO2.csv
- area.png (for `test_script_esm_v2.m` and `test_script_esm_v4.m`)

Note: For `test_script_esm_v3.m`, you will also need the traffic sensor data file (`traffic.csv`).