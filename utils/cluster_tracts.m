function [tract_cluster_idx,clustered_tracts,tract_cluster,...
    cent_per_tract]=cluster_tracts(tract_cent,clustered_cent_idx,final_cluster,tracts)
% Finds clustered tracts, returns their index, filtered tracts, 
% and cluster value.
[~,mask]=ismember(tract_cent,clustered_cent_idx);
tract_cluster_idx=find(mask);
tract_cluster=final_cluster(mask(tract_cluster_idx));
clustered_tracts=tracts(tract_cluster_idx);
cent_per_tract=clustered_cent_idx(mask(tract_cluster_idx));
end