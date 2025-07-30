function [mammal_tract_first_value_cent,mammal_tract_last_value_cent]=...
    tract_cent_prediction(mammal_tracts,mammal_node_locs)
% Matching cent prediction for first and last tract values
%Extract first and last values of each tract
mammal_tract_first_value=cell2mat(cellfun(@(tract) double(tract(1,:)), ...
    mammal_tracts,'UniformOutput',false)');
mammal_tract_last_value=cell2mat(cellfun(@(tract) double(tract(end,:)), ...
    mammal_tracts,'UniformOutput',false)');

%k-nearest neighbor
mdl=fitcknn(mammal_node_locs,1:200,'NumNeighbors',1);
mammal_tract_first_value_cent=predict(mdl,mammal_tract_first_value);
mammal_tract_last_value_cent=predict(mdl,mammal_tract_last_value);
end