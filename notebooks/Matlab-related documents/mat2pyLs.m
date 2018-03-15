function mat2pyLs

listing = dir('C:\\Users\\Ana\\Desktop\\CI\\Results\\\02-ICAcleaned\\');
for name_ls = 3:size(listing, 1)
    subject{name_ls} = listing(name_ls).name;
end
counting = 2;

while counting <= 29
    clearvars data_top trl_conditions trl_directions
    counting = counting +1;
filePath = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Results\\02-ICAcleaned\\%s', subject{counting});
[folder baseFileName extension] = fileparts(filePath);
folderPath = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects\\%s', baseFileName);

if exist(folderPath) ~= 7
load(filePath)
clc
fprintf(1, '\b Processing subject %s', baseFileName)

trl_conditions = CI_defineCondition(data_clean);
trl_directions = data_clean.trialinfo(:, 1);
fprintf(1, '\n Trial labels done')
for time_ind = 1:length(data_clean.time{1}) %In this example, 565 was the max validation accuracy time-point
    %% Sensor info at onset time of last stimulus
    % data_top =  trials x sensors
    for trial = 1:length(data_clean.trial)
        data_top(trial, :, time_ind) = data_clean.trial{trial}(:, time_ind);
    end
end
fprintf(1, '\n Trial data done')
mkdir(folderPath)
cd(folderPath)

fprintf(1, '\n saving')
save('data_top', 'data_top');
save('trl_conditions', 'trl_conditions');
save('trl_directions', 'trl_directions');

cd C:\Users\Ana\Desktop\CI

else 
    fprintf(1, 'folder exists already')
end
end