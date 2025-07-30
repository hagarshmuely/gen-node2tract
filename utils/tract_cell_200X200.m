function [mean_tract_cell, tract_mean_len, tract_count, mammal_edges_tract_cell_tri] = tract_cell_200X200(target_struct, input_struct)
%creates a 200X200 cell, maps all the target/input in target coordinates 
%to the relevant position in cell, creates a representing mean tract for
%each position
%the row index = start node
%the column index = end node

% tract definition by given nargin
if nargin == 1
    % no projection
    mammal_complete_struct = target_struct.tract_complete_struct;
    mammal_tracts = mammal_complete_struct.tract_complete;
elseif nargin == 2
    % projection needed
    mammal_complete_struct = input_struct.tract_complete_struct;
    mammal_tracts = tract_projector(target_struct, input_struct, 'complete');
end

% cent data
mammal_first_cent_by_tract = mammal_complete_struct.first_cent; %first val cent
mammal_last_cent_by_tract = mammal_complete_struct.last_cent; %last val cent

start_cell = num2cell(repmat((1:200)',1,200));
end_cell = num2cell(repmat(1:200,200,1));
% indexes cell - new
intersection = @(u,v,a,b) intersect(find(u==a),find(v==b));
mammal_edges_idx_cell = cellfun(@(start,finish) intersection(mammal_first_cent_by_tract,mammal_last_cent_by_tract,start,finish), start_cell, end_cell, 'uni', 0);

% tract cell by indexes - new
%(maybe change the diaginal cause it is doubled!)
%the row index = start node, the column index = end node
mammal_edges_tract_cell = cellfun(@(idx) mammal_tracts(idx), mammal_edges_idx_cell, 'uni', 0); % each cell contains tracts with proper start & end cent
mammal_edges_tract_cell_transposed = mammal_edges_tract_cell';
mask = find(~diag(ones(200,1)));
mammal_edges_tract_cell_tri = mammal_edges_tract_cell;
mammal_edges_tract_cell_tri(mask) = cellfun(@(s_f, f_s) [s_f,cellfun(@flipud,f_s,'uni',0)], mammal_edges_tract_cell(mask), mammal_edges_tract_cell_transposed(mask), 'uni', 0);

spaced_tracts = @(u) cell2mat(cellfun(@(tract) tract(round(linspace(1,length(tract),min(cellfun('length',u)))),:), u, 'uni', 0));
M_cell = cellfun(@(u) spaced_tracts(u), mammal_edges_tract_cell_tri, 'uni', 0);
tract_count = cellfun('length', mammal_edges_tract_cell_tri);
tract_mean_len = cellfun(@(tracts) mean(cellfun(@(tract) length(tract) ,tracts)) ,mammal_edges_tract_cell_tri);
mean_tract_cell = cellfun(@(M) [mean(M(:,1:3:end),2),mean(M(:,2:3:end),2), mean(M(:,3:3:end),2)], M_cell, 'uni', 0);

% % plotting
% row = 1; col = 3;
% mean_t_1 = mean_tract_cell{row,col};
% plot3(mean_t_1(:,1),mean_t_1(:,2),mean_t_1(:,3));
end