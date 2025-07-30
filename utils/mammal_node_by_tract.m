function label_mat = mammal_node_by_tract(mammal_complete_struct)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
first_label = mammal_complete_struct.first_cent;
last_label = mammal_complete_struct.last_cent;

% might be unnecessary:
common_label_idx = find(first_label == last_label);

label_mat = [first_label, last_label, zeros(size(first_label))];
label_mat(common_label_idx,1:2) = 0;
label_mat(common_label_idx,3) = first_label(common_label_idx);
end