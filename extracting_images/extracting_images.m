% NASA Ames Fly Lab ISS Adult Fly Program
% Roberta Dolling-Boreham, BMSIS YSP
% --------------------------------------------------------------------------
% Program Description: Extracting Images
% --------------------------------------------------------------------------
% This converts videos to maximum projection images on the blue channel and
% exports them as JPEG Images with the same name as their respective
% videos. The videos should be stored in one folder.
% 
% --------------------------------------------------------------------------

% Initialisation 
addpath('/Applications/dip/common/dipimage');
dip_initialise;
warning('off');
clear;

% Create list of all files in directory that start with "Module".
D = dir ('Module*'); 

for k = 1:length(D)
    
    % Import the video to the workspace.
    importfile(D(k).name); 
    vars = who('Module*'); 
    v = evalin('base',vars{1});  
    
    % Convert to type DIP Image.
    input = dip_image(v); 
    
    % Maximum projection over time. Leaves traces of each fly. Keep only
    % the blue channel as the videos are, for the most part, blue. Save the
    % image.
    projection = max(255-input,[],4); 
    output = squeeze(projection(:,:,2,0)); 
    writeim(output, vars{1}, 'JPEG','yes',[]); 
    
    % Display which image has just completed.
    disp([num2str(k) vars{1}]); 
    clear (vars{1});
end
