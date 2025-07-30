function [projected_tracts] = tract_projector(target_brain_struct, input_brain_struct, type)
%tract_projector uses the python function project.py in order to
%efficiently project the projection_tracts from input to output brain_cent
%space
target_brain_cent = target_brain_struct.aligned_complete_cent;
input_brain_cent = input_brain_struct.aligned_complete_cent;
if strcmp(type, 'first')
    input_brain_val_struct = input_brain_struct.first_tract_data;
    projection_tracts = input_brain_val_struct.clustered_tracts;
elseif strcmp(type, 'last')
    input_brain_val_struct = input_brain_struct.last_tract_data;
    projection_tracts = input_brain_val_struct.clustered_tracts;
elseif strcmp(type, 'complete')
    input_brain_val_struct = input_brain_struct.tract_complete_struct;
    projection_tracts = input_brain_val_struct.tract_complete;
end

projected_tracts = projector(input_brain_cent, target_brain_cent, projection_tracts);
end