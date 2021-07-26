% NASA Ames Fly Lab ISS Adult Fly Program
% Roberta Dolling-Boreham, BMSIS YSP
% --------------------------------------------------------------------------
% Program Description: Gallery Analysis
% --------------------------------------------------------------------------
% This creates arrays that represent the total intensity of an image over
% time. Then Heat Maps are created to visually represent the data. Collages
% of images in a folder are also created. There should be one folder that
% contains folders of images to be used, organized by module. 
% 
% --------------------------------------------------------------------------

% Initialisation 
addpath('/Applications/dip/common/dipimage');
dip_initialise;
warning('off');
clear;

% Variable Initialisation for whole directory.

% Square is each grid of images as a grid. Linear is one row of all
% intensities.
white_square = [];
white_linear = [];
full = newimar(1);

% Keep track of the starting folder.
start = pwd;

% Create list of all files in directory that start with "Module".
d_files=dir('Module*');

% ----------------------------------------------------------------------------

% To inspect ONLY certain folders, run the above code and find the index of the
% desired folders and replace the line 1:length(d-files) to reflect your
% desired range. 
for file = 1:length(d_files)
    
    %Open desired folder.
    cd(d_files(file).name);
    
    %Variable Initialisation within each folder. MUST BE Multiple of day_freq.
    num_days = 16;
    
    % Number of days per row in collage. MUST be a factor of this num_days.
    day_freq = 2; 
    
    % Number of images per day. There MUST atleast be this many images on
    % any given day.
    min_pic = 6; 
    
    % Number of the day on the first day of interest. Ex. If the start date
    % of interest is April 6, then first_day is 6. BEWARE! Do NOT miss this
    % value.
    first_day = 6;
    
    % Initialise storage of image intensity. 
    white_intensity = zeros(num_days/day_freq,min_pic*day_freq);
    
    % Get current file name. 
    file_name = d_files(file).name;
    
    % Keep track of current day, how many days have been completed, and how
    % many columns and rows of the collage have been created. BEWARE,
    % Curr_day must initially equal first_day.
    curr_day = 6;
    day_cnt = 0;
    col_cnt = 1;
    row_cnt = 1;
    
    % Initialise empty images.
    rowimg = newimar(1);
    fullimg = newimar(1);
    
    for i_row = 1:num_days
        
        % Make a list of all the images from the current day. BEWARE Update
        % this portion based on date taken: this relies on all the videos
        % taken in the same month, so adjust the "04" if needed.
        if (curr_day < 10)
            d_list = dir(sprintf('%s_2018_04_0%d_*.jpg',file_name,first_day+day_cnt));
            curr_day = curr_day+1;
        else
            d_list = dir(sprintf('%s_2018_04_%d_*.jpg',file_name,first_day+day_cnt));
        end
        
        % Select a random six images from the current day.
        len = numel(d_list);
        del = abs(len-min_pic);
        indices_del = randperm(len,del);
        for deletion = 1:length(indices_del)
            d_list(indices_del(deletion)) = [];
            indices_del = indices_del - (indices_del>indices_del(deletion));
        end
        
        % Create Images
        
        % Create each row.
        for i_col = 1:min_pic
            test = readim(d_list(i_col).name);
            white_intensity(row_cnt,col_cnt) = sum(test(:));
            
            % Reduce each image to 1/8th the size.
            test = subsample(test,8);
            
            rowimg = cat(1,rowimg,test);
            col_cnt = col_cnt + 1;
        end
        
        % Create each column.
        if mod(i_row,day_freq) == 0
            fullimg = cat(2,fullimg,rowimg);
            rowimg = newimar(1);
            col_cnt = 1;
            row_cnt = row_cnt + 1;
        end
        
        day_cnt = day_cnt+1;
        
    end
    
    % Create full image and export as JPEG.
    full = cat(1,full,fullimg);
    writeim(fullimg, file_name,'JPEG',1,[]);
    
    % Background intensity, found using the background_intensity program.
    backgd = 2.7729e8;
    
    normalized_white = white_intensity./backgd;
    
    % Store in arrays.
    white_square = [white_square normalized_white];
    white_linear = [white_linear; reshape(normalized_white',1,6*num_days)];
    
    % Return to original directory.
    cd(start);
end

% -------------------------------------------------------------------------
% Run this portion second to the above portion. 

% Maximum difference from background. Found from investigating the
% white_linear array (typically in the u-g flies array). You
% may use the command max(max(white_linear)) in the command window.
max_increase = 1.4306;

% Display colour map output. 
dip_image((white_linear-1)/(max_increase-1)*255)
colormap('jet')
dip_image((white_square-1)/(max_increase-1)*255)
colormap('jet')
