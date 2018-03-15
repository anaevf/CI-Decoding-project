function CI_lowpass(cut)

%% Reading the whole directory

listing = dir('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects');
for name_ls = 3:size(listing, 1)
    subject{name_ls} = listing(name_ls).name;
end
subject = subject(1, 3:end);

for name = 1:length(subject)
%% Low-passing the data
fileDir = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects\\%s', subject{name});
fprintf(1, '\n processing subject %s', subject{name})


if exist(strcat(fileDir, '\data_filt_', num2str(cut), '.mat')) ~= 2
    
cd(fileDir);
load(strcat(fileDir, '\\data_top.mat'));
load(strcat(fileDir, '\\trl_conditions.mat'));
load('C:\\Users\\Ana\\Desktop\\CI\\Python\\timepoint.mat');



fprintf(1, '\n filtering trials')
for i = 1:size(data_top, 1)
dat = squeeze(data_top(i, :, :));
[filt(i, :, :)] = ft_preproc_lowpassfilter(dat, 200, [2:1:cut], 4, 'but');
end

fprintf(1, '\n saving file...')
save(strcat(fileDir, '\data_filt_', num2str(cut), '.mat'), 'filt')

clearvars dat filt 
clc
else
    fprintf(1, ' -> data exists')
end
end

% % %% Separating in positive and negative trials
% 
% positive_trials = filt(trl_conditions==1, :, :);
% negative_trials = filt(trl_conditions==-1, :, :);
% 
% %% Visually inspecting: do both conditions differ? Looking at one channel
% 
% figure
% subplot(3, 1, 1)
% 
% plot(time, squeeze((sqrt(mean(positive_trials.^2, 3))))', '-b', 'DisplayName','Same') % Same
% hold on
% plot(time, squeeze((sqrt(mean(negative_trials.^2, 3))))', '-r', 'DisplayName','Diff') % Diff
% title(sprintf('Average across channels - Differences in Conditions %s', subject{name}))
% hold off
% 
% subplot(3, 1, 2)
% 
% plot(time, squeeze(mean(positive_trials, 1))', '-b', 'DisplayName','Same') % Same
% hold on
% plot(time,squeeze(mean(negative_trials, 1))', '-r', 'DisplayName','Diff') % Diff
% title(sprintf('Average across trials- Differences in Conditions'))
% hold off
% 
% subplot(3, 1, 3)
% 
% plot(time, mean(squeeze((sqrt(mean(positive_trials.^2, 3)))), 1), '-b', 'DisplayName','Same')
% hold on
% plot(time, mean(squeeze((sqrt(mean(negative_trials.^2, 3)))), 1), '-r', 'DisplayName','Diff')
% hold off
% title('Average across channels and trials - Differences in Conditions')

% legend('show')
end