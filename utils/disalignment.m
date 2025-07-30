function [og_location_t]=disalignment(mammel_name_c,mammel_name_d,node_location_csv,mammal_transform_mat_struct)
%Coordinate transform function
% Read data and filter specific mammal
mammal_transform_mat_struct=load(mammal_transform_mat_struct);
mammal_transform_mat=getfield(mammal_transform_mat_struct,mammel_name_c);
node_locations_old_t=readtable(node_location_csv);
node_locations_old_t=node_locations_old_t(contains(node_locations_old_t.(12),mammel_name_d),:);
node_locations_old=table2cell(node_locations_old_t);

% Transform original brain location
og_loc=cell2mat(node_locations_old(:,2:4));
og_loc=[og_loc ones(size(og_loc,1),1)];
og_loc_matlab=(inv(mammal_transform_mat)*og_loc')';

% Transform projected brain location
proj_loc=cell2mat(node_locations_old(:,6:8));
proj_loc=[proj_loc ones(size(proj_loc,1),1)];
proj_loc_matlab=(inv(mammal_transform_mat)*proj_loc')';

% Transform central's cluster brain location
clus_loc=cell2mat(node_locations_old(:,9:11));
clus_loc=[clus_loc ones(size(clus_loc,1),1)];
clus_loc_matlab=(inv(mammal_transform_mat)*clus_loc')';

% Renew table with new coordinates
og_location_t=node_locations_old_t;
og_location_t(:,2:4)=array2table(og_loc_matlab(:,1:3));
og_location_t(:,6:8)=array2table(proj_loc_matlab(:,1:3));
og_location_t(:,9:11)=array2table(clus_loc_matlab(:,1:3));

end