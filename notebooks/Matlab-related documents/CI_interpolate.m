function interpolate_py
listing = dir('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects');
for name_ls = 3:size(listing, 1)
    subject{name_ls-2} = listing(name_ls).name;
end
subject = subject(1, :);

load GSN-HydroCel-257-layout.mat
elec = ft_read_sens('GSN-HydroCel-257.sfp');
elec = ft_convert_units(elec, 'cm');


for counting = 20:length(subject)

filePath = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Results\\02-ICAcleaned\\%s', subject{counting}(1:end-2));

folderPath = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects\\%s', subject{counting});
% if exist(strcat(folderPath, '\struct_inter.mat')) ~= 2


load(filePath)
    
load(strcat(folderPath, '\\struct_cor.mat'))

idx = match_str(elec.label, struct_cor.label);
missing = elec.label;
missing(idx) = [];
missing(1:3) = [];
missing(end) = [];


   cfg.method         = 'spline';
   cfg.missingchannel = missing;
   cfg.trials         = 'all';
   cfg.elec           = elec;
[struct_inter] = ft_channelrepair(cfg, struct_cor);


%% Sorting the channels and trials accordingly. The output of the ft_channel repair is not organized
% in any alphabetical order. I organize it accordingly
fprintf(1, '\n sorting channels and trials accordingly');
filenum = cellfun(@(x)sscanf(x,'E%d'), struct_inter.label);
[Sorted, index] = sort(filenum);

% sorting 
struct_inter.label = struct_inter.label(index);
struct_inter.trial = struct_inter.trial(:, index, :);

 fprintf(1, '\n saving subject %s', subject{counting})
save(strcat(folderPath, '\\struct_inter.mat'), 'struct_inter');

%% At some point, I just needed to reorganize the order of the channels.
% else
%       fprintf(1, ' -> data exists')
%       fprintf(1, '\n loading file');
%       filePath = sprintf('C:\\Users\\Ana\\Desktop\\CI\\Python\\Subjects\\%s', subject{counting});
%       load(strcat(folderPath, '\\struct_inter.mat'))
%       
% fprintf(1, '\n sorting channels and trials accordingly');
% filenum = cellfun(@(x)sscanf(x,'E%d'), struct_inter.label);
% [Sorted, index] = sort(filenum);
% 
% % sorting 
% struct_inter.label = struct_inter.label(index);
% struct_inter.trial = struct_inter.trial(:, index, :);
% 
%  fprintf(1, '\n saving subject %s', subject{counting})
% save(strcat(folderPath, '\\struct_inter.mat'), 'struct_inter');
%       
% end
end

