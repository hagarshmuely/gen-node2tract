function [mammal_first_cell, mammal_last_cell] = tract_cell_by_cent(target_struct, input_struct)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if nargin == 1
    % no projection
    mammal_complete_struct = target_struct.tract_complete_struct;
    mammal_tracts = mammal_complete_struct.tract_complete;
elseif nargin == 2
    % projection needed
    mammal_complete_struct = input_struct.tract_complete_struct;
    mammal_tracts = tract_projector(target_struct, input_struct, 'complete');
end

mammal_first_cent_by_tract = mammal_complete_struct.first_cent; %first val cent
mammal_idx_first_cell = tract_idx_by_cent(mammal_first_cent_by_tract);
mammal_first_cell = cellfun(@(idx) mammal_tracts(idx), mammal_idx_first_cell, 'UniformOutput', false);

mammal_last_cent_by_tract = mammal_complete_struct.last_cent; %last val cent
mammal_idx_last_cell = tract_idx_by_cent(mammal_last_cent_by_tract);
mammal_last_cell = cellfun(@(idx) mammal_tracts(idx), mammal_idx_last_cell, 'UniformOutput', false);
end