function [mammal_cell] = tract_idx_by_cent(cent_by_tract)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
idx=find(~(cent_by_tract-(1:200)));
[x,y]=ind2sub(size(~(cent_by_tract-(1:200))),idx);
mammal_cell = num2cell(1:200);
mammal_cell = cellfun(@(ind) x(find(~(y-ind))), mammal_cell, 'UniformOutput', false);
end