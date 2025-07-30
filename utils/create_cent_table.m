function [cent_idx_table] = create_cent_table(target_struct, input_struct, cent_num)
% 200 cent & project input to target space
target_brain_cent = target_struct.aligned_complete_cent;
input_brain_cent = input_struct.aligned_complete_cent;
input_projected_cent = projector(input_brain_cent, target_brain_cent);
if cent_num == 200
    % full 200 cents
    projected_input_closest_to_target_idx_200 = dsearchn(input_projected_cent, target_brain_cent);
    cent_idx_table = table((1:200)', projected_input_closest_to_target_idx_200);

elseif cent_num == 60
    % 60 cent indexes
    target_60_cent_idx = target_struct.chosen_cents + 1;
    input_60_cent_idx = input_struct.chosen_cents + 1;
    % 60 cent locations
    target_60_cent_loc = target_brain_cent(target_60_cent_idx,:);
    input_60_cent_loc_projected = input_projected_cent(input_60_cent_idx,:);
    
    % 60 chosen cents
    projected_input_closest_to_target_idx_60 = dsearchn(input_60_cent_loc_projected, target_60_cent_loc);
    cent_idx_table = table(target_60_cent_idx, input_60_cent_idx(projected_input_closest_to_target_idx_60));
end
cent_idx_table.Properties.VariableNames = {target_struct.name, sprintf('%s_proj', input_struct.name)};
end