function trl_class = CI_defineDirection(data_clean, direction)


%% Direction 2.


for ind = 1:length(data_clean.trialinfo)
    if data_clean.trialinfo(ind, 1) == direction
        trl_class(ind) = 1; %same condition
    else
        trl_class(ind) = -1; %diff condition
    end
end

end