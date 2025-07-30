function [clustered_cent_idx,matching_cent_locs_original,...
    matching_cent_locs_projected,final_cluster_cent_loc,final_cluster]...
    =extract_csv_data(csv_file_name,mammal_name)
%UNTITLED6 Summary of this function goes here
csv_file=readtable(csv_file_name);
filtered_csv_file=csv_file(contains(csv_file.(12),mammal_name),:);

clustered_cent_idx=table2array(filtered_csv_file(:,1))+1;
matching_cent_locs_original=table2array(filtered_csv_file(:,2:4));
matching_cent_locs_projected=table2array(filtered_csv_file(:,6:8));
final_cluster_cent_loc=table2array(filtered_csv_file(:,9:11));
final_cluster=table2array(filtered_csv_file(:,13));
end