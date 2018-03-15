function corBaseline

listing = dir('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects');
for name_ls = 3:size(listing, 1)
    subject{name_ls-2} = listing(name_ls).name;
end
subject = subject(1, 1:end);
load('C:\\Users\\Ana\\Desktop\\CI\\Python\\timepoint.mat');

%% Defining baseline
startBaseline = find(time==-0.3);
endBaseline = find(time==-0.2);

clc
for name = 1:length(subject)
    fileDir = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects\\%s', subject{name});
    fprintf(1, '\n processing subject %s', subject{name})
    
if exist(strcat(fileDir, '\data_cor.mat')) ~= 2
    cd(fileDir);
    load(strcat(fileDir, '\\data_filt_40.mat'));
    
    %% Define new trial length and do baseline correction
    
temp = filt(:, :, startBaseline:end);
bas = mean(temp(:, :, startBaseline:endBaseline), 3);
data_cor = temp - bas;

    fprintf(1, '\n saving subject %s', subject{name})
    save(strcat(fileDir, '\\data_cor.mat'), 'data_cor');
    clearvars data_cor bas temp 
else
  fprintf(1, ' -> data exists')
end
end

        
    