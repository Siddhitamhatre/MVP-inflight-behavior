% NASA Ames Fly Lab ISS Adult Fly Program
% Roberta Dolling-Boreham, BMSIS YSP
% --------------------------------------------------------------------------
% Program Description: Background Intensity
% --------------------------------------------------------------------------
% This finds the average background intensity of the images stored in
% the same folder as this program.
% 
% --------------------------------------------------------------------------

% Initialisation: change the path in addpath to path of dipimage
addpath('/Applications/dip/common/dipimage');
dip_initialise;
warning('off');
clear;

% Make list of all images in the folder.
d_list = dir('Module*');

% Preallocate Space.
intensity = zeros(1,length(d_list));

% Calculate intensity of each image on folder.
for i = 1:length(d_list)
    input = readim(d_list(i).name);
    intensity(i) = sum(input(:));    
end

% Find average.
bkgd_intensity = mean(intensity);

% Display.
disp(bkgd_intensity);