function [aligned_coordinates]=alignment(Alignment_file_name,mammel_name,initial_coordinates_data)
% Aligned coordinates (in order for all the brains to "face" the same
% direction
% Call alignment data
Alignment_data=load(Alignment_file_name);
mammal_alignment_mat=getfield(Alignment_data,mammel_name);

% alignment inner function
aligned_coordinates_fun=@(initial_coordinates_data,mammal_alignment_mat)...
    [initial_coordinates_data, ones(size(initial_coordinates_data,1),1)]...
    *mammal_alignment_mat';
if iscell(initial_coordinates_data)
    % aligned data with cellfun
    aligned_coordinates=cellfun(@(coordinates) aligned_coordinates_fun(coordinates,mammal_alignment_mat),initial_coordinates_data,'UniformOutput',false);
    aligned_coordinates=cellfun(@(coordinates) coordinates(:,1:3),aligned_coordinates,'UniformOutput',false);
else
    % aligned data
    aligned_coordinates=aligned_coordinates_fun(initial_coordinates_data,mammal_alignment_mat);
    aligned_coordinates=aligned_coordinates(:,1:3);
end
end