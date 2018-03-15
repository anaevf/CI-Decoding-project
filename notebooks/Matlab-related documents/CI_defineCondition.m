function trl_class = CI_defineCondition(data_clean)

for ind = 1:length(data_clean.trialinfo)
    if data_clean.trialinfo(ind, 1) == data_clean.trialinfo(ind, 2)
        trl_class(ind) = -1; %same condition
    else
        trl_class(ind) = 1; %diff condition
    end
end

end