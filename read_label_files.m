% folder with labeled files
folder = "Y:\usvi\stj\fishAuditing\HM_ST_comparison\ST_master_labels_TK"

% write the whole table to the master datafile
% note that the name of this file cannot have "labels" in its name
doc = "Y:\usvi\stj\fishAuditing\HM_ST_comparison\ST_master_labels_TK\consolidated_data_ST_TK.txt";

type_of_recorder = 'ST'

files = dir(fullfile(folder, '*.txt'));

full_table = table(0, 0, 0, 0, 0, 0, 0, 0);
full_table.Properties.VariableNames = ["Year", "Date", "Hour", "Start_Time", "End_Time", "Low_Freq", "High_Freq", "Type"];

% loop through the files to get data
for k = 1:length(files)

    name = files(k).name;

    % disregard the directory contents file if it exists in the folder
    if contains(name, 'labels') == 0
        disp('file without labels found and disregarded')
        continue
    end

    % pull date and time information from file name to label data 
    if type_of_recorder == "HM"
        title_year = str2double(name(3:4));
        title_date = str2double(name(5:8));
        title_time = str2double(name(10:15)); 
        if title_time < 40000 % adjust for HM time difference
            title_time = title_time + 200000; % handle case where it's gone past midnight
        else
            title_time = title_time - 40000; % handle normal case (of being 4 hours ahead)
        end
    elseif type_of_recorder == "ST"
        title_year = str2double(name(6:7));
        title_date = str2double(name(9:11));
        title_time = str2double(name(12:17));
    else 
        disp("Not a valid recorder type. Please input ST or HM.")
        break
    end

    % for Soundtrap, use this code

    % read data from that file
    fullPath = fullfile(folder, name);
    A = readtable(fullPath, 'Delimiter', '\t', 'ReadVariableNames', false, 'Format', '%f%f%f%f%s');
    A = A(2:end, :); % remove top row of table (default header row)

    % create columns for table based on this file's data
    num_points = height(A);
    Year = title_year * ones(num_points, 1);
    Date = title_date * ones(num_points, 1);
    Hour = title_time * ones(num_points, 1);
    Start_Time = A{:, 1};
    End_Time = A{:, 2};
    Low_Freq = A{:, 3};
    High_Freq = A{:, 4};
    Type = A{:, 5};

    % add data from this file to the existing table
    new_table = table(Year, Date, Hour, Start_Time, End_Time, Low_Freq, High_Freq, Type);
    full_table = [full_table; new_table];

end

full_table = full_table(2:end, :); % remove top row, which is just zeros
fileID = fopen(doc, 'w');
writetable(full_table, doc)
fclose(fileID);

disp("total number of annotations: " + height(full_table))