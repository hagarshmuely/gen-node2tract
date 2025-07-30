function [Parameter_struct] = Volume_parameter_maker(target_struct, input_struct)
% target_struct = Rat1_struct;
% input_struct = Agouti1_struct;
%This function takes closest cents in target and input, creates the minimal
%shape containing each couple of matching tracts, calculates the shape
%volume, and creates the average value for each closest cents.

%%   1) find closest cents:
cent_idx_table_200 = create_cent_table(target_struct, input_struct, 200);

%%   2) create data 200X200 cells, mean fiber if needed (updated):
[target_edges_mean_tract_cell, target_mean_tracts_len, target_edges_count, target_edges_og_tract_cell] = tract_cell_200X200(target_struct); %Rat1
[input_edges_mean_tract_cell, input_mean_tracts_len, input_edges_count, input_edges_og_tract_cell] = tract_cell_200X200(target_struct, input_struct); %Agouti1 (indludes projection!)

%%   3) average volume calculation:
tic;
idx_map = table2array(cent_idx_table_200(:,2));

%target_row = 1; target_col = 2;
interest_vol = cell(200,200);
other_vol = cell(200,200);
volume_factor = cell(200,200);

% target_edges_mean_tract_cell; % 200X200 target cell, row index = start node, column index = end node
input_start_cell = num2cell(repmat(idx_map((1:200)),1,200));
input_end_cell = num2cell(repmat(idx_map(1:200)',200,1));

input_edges_mean_tract_cell_tidy = cellfun(@(input_row, input_col) input_edges_mean_tract_cell{input_row,input_col}, input_start_cell, input_end_cell, 'uni', 0);
mask_1 = ~cellfun(@isempty , target_edges_mean_tract_cell);
mask_2 = ~cellfun(@isempty , input_edges_mean_tract_cell_tidy);
mask = mask_1&mask_2;

cell_idx = find(mask);
[row_v,col_v] = find(mask);
for idx = 1:length(cell_idx)
    % indexing
    target_row = row_v(idx); target_col = col_v(idx);
    input_row = idx_map(target_row); input_col = idx_map(target_col);
    % vectors for comparison
    target_mean_tract = target_edges_mean_tract_cell{target_row,target_col};
    comparison_v = input_edges_mean_tract_cell(input_row,:);
    %masks
    line_mask = ~cellfun(@isempty ,comparison_v);
    line_mask_interest = line_mask;
    line_mask_interest(input_col) = 0;
    % volume calculations
    volumes = zeros(1,200);
    volumes(line_mask) = cellfun(@(input_compared_tract) volume(alphaShape([input_compared_tract; target_mean_tract])), comparison_v(line_mask));
    % add length normalization
    target_len = target_mean_tracts_len(target_row,target_col);
    input_len = input_mean_tracts_len(input_row, :);
    interest_len = input_mean_tracts_len(input_row,input_col) + target_len;
    other_len = mean(input_len(line_mask_interest)) + target_len;
    % add count normalization
    input_count = input_edges_count(input_row,1:end);
    
    % save results
    interest_vol{target_row,target_col} = volumes(input_col)/interest_len;
    other_vol{target_row,target_col} = mean(volumes(line_mask_interest).*input_count(line_mask_interest))/(mean(input_count(line_mask_interest))*other_len);
    volume_factor{target_row,target_col} = interest_vol{target_row,target_col}/other_vol{target_row,target_col}; % if smaller than 1, match is closer than random nodes!
end

toc;

% %% alphashape
% % alphashape plotting example
% masked_comparison_v = comparison_v(line_mask);
% input_compared_tract = comparison_v{input_col};
% plot(alphaShape([input_compared_tract; target_mean_tract]),'FaceAlpha',0.2,'EdgeAlpha',0.1);
% hold on;
% plot3(target_mean_tract(:,1),target_mean_tract(:,2),target_mean_tract(:,3),'Color',[0.4940 0.1840 0.5560],'LineWidth',1.3);
% hold on;
% plot3(input_compared_tract(:,1),input_compared_tract(:,2),input_compared_tract(:,3),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.3);
% title('volume example');
% hold off;

%% Table
% row is the steady node
% col is the examined node
Final_table = table(cell_idx,row_v,col_v,idx_map(col_v),cell2mat(interest_vol(cell_idx)),cell2mat(other_vol(cell_idx)),cell2mat(volume_factor(cell_idx)));
Final_table.Properties.VariableNames = ["cell_idx","Steady node (target)","Examined node (target)","Examined node (input)","interest volume","all_else volume","volume_factor"];
Final_table = sortrows(Final_table,"Steady node (target)");

%% return struct
Parameter_struct = struct('idx_map', idx_map, 'Final_table', Final_table);

% , ...
%     'target_edges_mean_tract_cell', target_edges_mean_tract_cell, ...
%     'target_mean_tracts_len', target_mean_tracts_len, 'target_edges_count', ...
%     target_edges_count, 'target_edges_og_tract_cell', target_edges_og_tract_cell, ...
%     'input_edges_mean_tract_cell', input_edges_mean_tract_cell, ...
%     'input_mean_tracts_len', input_mean_tracts_len, 'input_edges_count', ...
%     input_edges_count, 'input_edges_og_tract_cell', input_edges_og_tract_cell

%% plotting example of mean tract meaning
% %row = 1; col = 3;
% row = 6; col = 17;
% figure;
% cell_to_mean = target_edges_og_tract_cell{row,col};
% mean = target_edges_mean_tract_cell{row,col};
% plot3(mean(:,1),mean(:,2),mean(:,3),'Color',[0.8500 0.3250 0.0980],'LineWidth',1.3);
% hold on;
% for i = 1:length(cell_to_mean)
%     tract = cell_to_mean{i};
%         H = plot3(tract(:,1),tract(:,2),tract(:,3),'Color',[0.4940 0.1840 0.5560],'LineWidth',0.5);
%         %set(H,'MarkerFaceColor',[0.4940 0.1840 0.5560]);
%         H.Color(4) = 0.15;
%         hold on;
%         title(sprintf('%d to %d in target brain (Rat1)',row, col));
% end
% hold off;

% %% Plotting example: row = 7, col = 15
% target_cents = target_struct.aligned_complete_cent;
% input_cents = input_struct.aligned_complete_cent;
% input_cents_proj = projector(input_cents, target_cents);
% 
% row = 1; col = 2;
% 
% input_row = idx_map(row);
% input_col = idx_map(col);
% 
% target_steady_cent = target_cents(row,:);
% target_examined_cent = target_cents(col,:);
% input_steady_cent_proj = input_cents_proj(input_row,:);
% input_examined_cent_proj = input_cents_proj(input_col,:);
% 
% target_mean_tract = target_edges_mean_tract_cell{row,col};
% comparison_v = input_edges_mean_tract_cell(input_row,:);
% 
% figure;
% label_num = 200;
% Colors=colormap(hsv(label_num));
% c = Colors(input_col,:);
% 
% h(1) = plot3(target_steady_cent(1),target_steady_cent(2),target_steady_cent(3),'o','Color',[0.4940 0.1840 0.5560],'LineWidth',1.3);
% hold on;
% h(2) = plot3(target_examined_cent(1),target_examined_cent(2),target_examined_cent(3),'x','Color',[0.4940 0.1840 0.5560],'LineWidth',1.3);
% hold on;
% h(3) = plot3(input_steady_cent_proj(1),input_steady_cent_proj(2),input_steady_cent_proj(3),'o','Color',c,'LineWidth',1.3);
% h(4) = plot3(input_examined_cent_proj(1),input_examined_cent_proj(2),input_examined_cent_proj(3),'x','Color',c,'LineWidth',1.3);
% 
% for n = 1:200
%     input_tract = comparison_v{n};
%     if ~isempty(input_tract)
%         %mean_target = target_edges_mean_tract_cell{1,n};
%         %mean_proj_input = input_edges_mean_tract_cell{1,input_matched_cent(n)};
%         if n == input_col
%             c = Colors(input_col,:);
%             w = 1.3;
%             plot3(target_mean_tract(:,1),target_mean_tract(:,2),target_mean_tract(:,3),'Color',[0.4940 0.1840 0.5560],'LineWidth',w);
%             hold on;
%         else
%             c = [0 0 0 0.1];
%             w = 0.5;
%         end
%         input_mean_tract = comparison_v{n};
%         plot3(input_mean_tract(:,1),input_mean_tract(:,2),input_mean_tract(:,3),'Color',c,'LineWidth',w);
%         hold on;
%         title(sprintf('%d is Steady, %d is Examined',row, col));
%     end
% end
% hold off;
% %legend(h1, 'cosine');
% legend(h([1 3 2 4]),sprintf('target steady cent %d', row),sprintf('input matching steady cent %d', input_row),sprintf('target examined cent %d', col),sprintf('input matching examined cent %d', input_col));

end