function [mammal_tracts,mammal_cent_locs,...
    MRI_mammal_cent_origin_locs,MRI_mammal_cent]=...
    load_data(Tract_file_name,Cent_file_name,Seg_file_name)
%Receives file names to be loaded and returns loaded data arrays
%% 1) Call tract data (From Lab)
mammal_Tract_file=load(Tract_file_name);
compressed_mammal_tracts=mammal_Tract_file.Tracts;
mammal_VDims=mammal_Tract_file.VDims;
mammal_tracts=cellfun(@(tract) double(tract./mammal_VDims), ...
    compressed_mammal_tracts,'UniformOutput',false);

%% 2) Call cent data (From Rotem)
mammal_cent_file=load(Cent_file_name);
% cents are the 200 values provided by k-means
mammal_cent_locs=mammal_cent_file.cents;

%% 3) Call seg data (Lab)
% seg represents node locations in the original MRI 3D-mat
mammal_seg_file=load(Seg_file_name);
mammal_seg=mammal_seg_file.seg;
% extracting the index and value of each non-zero element in seg
% (k-means origin location):
idx=find(mammal_seg);
[~,~,MRI_mammal_cent]=find(mammal_seg);
[x,y,z]=ind2sub(size(mammal_seg),idx);
MRI_mammal_cent_origin_locs=[x y z];

end