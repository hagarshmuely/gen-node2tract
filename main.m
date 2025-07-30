%% Load previously calculated data:
load('Volume_tables_Rodentia2Rat1.mat');
Volume_tables = Volume_tables_Rodentia2Rat1;

% naming
target_idx = 19;
Rodentia_names = {'Agouti1', 'Agouti2', 'BlindMole1', 'BlindMole2', ...
    'Capybara', 'CaucasianSquirrel', 'Chinchila', 'Coypu', 'Dego', ...
    'Gerbil', 'GoldenSpinyMouse', 'Mara', 'Merion', 'Mouse', ...
    'PalmSquirrel', 'Porcupine1', 'Porcupine2', 'PrairieDog', 'Rat1', ...
    'Rat2', 'Rat3', 'Rat4', 'Rat5', 'Rat6', 'SkinnyPig', 'SpinyMouse', ...
    'Vole', 'WildRat'};
target_name = Rodentia_names{target_idx};
input_names = Rodentia_names(1:end ~=target_idx);
%input_names = Rodentia_names;

% idx complete node table
idx_map = cell2mat(cellfun(@(struct) struct.idx_map, Volume_tables(1:end ~=target_idx), 'uni', 0));
idx_table = array2table([(1:200)', idx_map], 'VariableNames', [target_name, input_names]);
% volume parameter complete table
Volume_tables = cellfun(@(struct) table2array(struct.Final_table(:,7)), Volume_tables, 'uni', 0);
% there's a NaN issue!!!!! find
count_NaN = cellfun(@(table) sum(isnan(table)), Volume_tables);

%% Box plot
max_len = max(cellfun(@length, Volume_tables));
Volume_NaN = cell2mat(cellfun(@(table) [table; NaN(max_len-length(table),1)], Volume_tables, 'uni', 0));
% outliers don't show!
figure;
b = boxchart(Volume_NaN);
% don't show outliers
b.MarkerStyle = 'none';
% boxcolor
b.BoxFaceColor = [0 0.4470 0.7410];
b.WhiskerLineStyle = '--';
b.LineWidth = 1.2;

% include outliers
%boxplot(Volume_NaN);
h = yline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980]);
ylim([0 3]);
legend([h],'1 Threshold');
%legend
xticklabels(Rodentia_names);
ylabel('Volume parameter','FontSize',12);
xlabel('Rodent','FontSize',12);
title('Rodentia Volume Parameter Boxplot (Comparison to Rat1)','FontSize',13);

%% Mean & STD
mean_parameter = cellfun(@nanmean, Volume_tables);
std_parameter = cellfun(@nanstd, Volume_tables);

%% Histograms
a = cellfun(@(parameter) length(find(parameter<1))/length(parameter), Volume_tables);
% bin and plot
figure;
%colors = {'#77AC30','#0072BD','#D95319','#EDB120','#7E2F8E','#4DBEEE','#A2142F','#77AC30','#0072BD','#D95319','#EDB120','#7E2F8E','#4DBEEE','#A2142F','#77AC30','#0072BD','#D95319','#EDB120','#7E2F8E','#4DBEEE','#A2142F','#77AC30','#0072BD','#D95319','#EDB120','#7E2F8E','#4DBEEE','#A2142F'};
new_Volume_tables = [Volume_tables{19}, Volume_tables(1:end ~=19)];
new_Rodentia_names = [Rodentia_names{19}, Rodentia_names(1:end ~=19)];
for input_i = 1:length(new_Volume_tables)
    if input_i == 1
        c = [0.4660 0.6740 0.1880];
    else
        c = [rand,rand,rand];
    end
    h = histogram(new_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',c,'FaceAlpha',0.5-(input_i/500));
    %h = histogram(new_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',colors{input_i});
    hold on;
end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend(Rodentia_names{19});
legend([new_Rodentia_names,{'1 Threshold'}]);
%ylim([0 0.35]);
ylim([0 0.5]);
xlim([0 5]);

ylabel('Volume Parameter Probability','FontSize',14);
xlabel('Volume Parameter Value','FontSize',14);
title('Rodentia Volume Parameter Histograms (Comparison to Rat1)','FontSize',16);

%% Histogram: Porcupine1 & Rat4
% bin and plot
figure;
binEdges = 0:0.3:10;
Porcupine1_Rat2_Volume_tables = Volume_tables([16,22]);
Porcupine1_Rat2_names = Rodentia_names([16,22]);
for input_i = 1:length(Porcupine1_Rat2_Volume_tables)
    h = histogram(Porcupine1_Rat2_Volume_tables{input_i}, binEdges, 'Normalization', 'probability');
    hold on;
end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend([x],'1 Threshold');
%legend({input_names,'1 Threshold'});
legend({'Porcupine1 (Least compatable to Rat1)','Rat4 (most compatible to Rat1)','1 Threshold'});
ylim([0 0.6]);
xlim([0 4.5]);

ylabel('Volume Parameter Probability','FontSize',12);
xlabel('Volume Parameter Value','FontSize',12);
title('Porcupine1 & Rat4 Volume Parameter Histograms (Comparison to Rat1)','FontSize',13);

%% Histogram: Rat1-Rat4 vs Rat1-Porcupine1
% bin and plot
figure;
tiledlayout(2,1);

binEdges = 0:0.2:10;
Rat1_Rat4_Volume_tables = Volume_tables([19,22]);
Rat1_Porcupibe1_Volume_tables = Volume_tables([19,16]);
Rat1_Rat4_names = Rodentia_names([19,22]);
Rat1_Porcupibe1_names = Rodentia_names([19,16]);

nexttile;
color = {'#0072BD','#77AC30'};
for input_i = 1:length(Rat1_Rat4_Volume_tables)
    h = histogram(Rat1_Rat4_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',color{input_i});
    hold on;
end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend([x],'1 Threshold');
%legend({input_names,'1 Threshold'});
legend({'Rat1','Rat4 (most compatible to Rat1)','1 Threshold'});
ylim([0 0.55]);
xlim([0 3.5]);

ylabel('Volume Parameter Probability','FontSize',12);
xlabel('Volume Parameter Value','FontSize',12);
%title('Rat1 & Rat4 Volume Parameter Histograms','FontSize',13);
title('(A)','FontSize',13);

nexttile;
color = {'#0072BD','#A2142F'};
for input_i = 1:length(Rat1_Porcupibe1_Volume_tables)
    h = histogram(Rat1_Porcupibe1_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',color{input_i});
    hold on;
end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend([x],'1 Threshold');
%legend({input_names,'1 Threshold'});
legend({'Rat1','Porcupine1 (Least compatible to Rat1)','1 Threshold'});
ylim([0 0.55]);
xlim([0 3.5]);

ylabel('Volume Parameter Probability','FontSize',12);
xlabel('Volume Parameter Value','FontSize',12);
%title('Rat1 & Porcupine1 Volume Parameter Histograms','FontSize',13);
title('(B)','FontSize',13);
%% Histogram: Rat1-Rat4 vs Rat1-Porcupine1
% bin and plot
figure;
tiledlayout(2,1);

binEdges = 0:0.2:10;
Rat1_Rat4_Volume_tables = Volume_tables([19,22]);
Rat1_Porcupibe1_Volume_tables = Volume_tables([19,16]);
Rat1_Rat4_names = Rodentia_names([19,22]);
Rat1_Porcupibe1_names = Rodentia_names([19,16]);

color = {'#0072BD','#A2142F'};
for input_i = 1:length(Rat1_Porcupibe1_Volume_tables)
    h = histogram(Rat1_Porcupibe1_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',color{input_i});
    hold on;
end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend([x],'1 Threshold');
%legend({input_names,'1 Threshold'});
legend({'Rat1','Porcupine1 (Least compatible to Rat1)','1 Threshold'});
ylim([0 0.55]);
xlim([0 3.5]);

ylabel('Volume Parameter Probability','FontSize',12);
xlabel('Volume Parameter Value','FontSize',12);
title('Rat1 & Porcupine1 Volume Parameter Histograms','FontSize',13);
input_i = 2;

color = {'#0072BD','#77AC30'};
h = histogram(Rat1_Rat4_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',color{input_i});
% for input_i = 1:length(Rat1_Rat4_Volume_tables)
%     h = histogram(Rat1_Rat4_Volume_tables{input_i}, binEdges, 'Normalization', 'probability','FaceColor',color{input_i});
%     hold on;
% end
x = xline(1, '--', 'LineWidth', 2, 'Color', [0.8500 0.3250 0.0980], 'Alpha',1);
%legend([x],'1 Threshold');
%legend({input_names,'1 Threshold'});
legend({'Rat1','Rat4 (most compatible to Rat1)','1 Threshold'});
ylim([0 0.55]);
xlim([0 3.5]);

ylabel('Volume Parameter Probability','FontSize',12);
xlabel('Volume Parameter Value','FontSize',12);
title('Rat1 & Rat4 Volume Parameter Histograms','FontSize',13);





%% NaN issue closer look
%load('Rodentia_structs_cell.mat');
csv_file_name='Rat1';
Rodentia_names = {'Agouti1', 'Agouti2', 'BlindMole1', 'BlindMole2', ...
    'Capybara', 'CaucasianSquirrel', 'Chinchila', 'Coypu', 'Dego', ...
    'Gerbil', 'GoldenSpinyMouse', 'Mara', 'Merion', 'Mouse', ...
    'PalmSquirrel', 'Porcupine1', 'Porcupine2', 'PrairieDog', 'Rat1', ...
    'Rat2', 'Rat3', 'Rat4', 'Rat5', 'Rat6', 'SkinnyPig', 'SpinyMouse', ...
    'Vole', 'WildRat'};
target_name = Rodentia_names{19};
target_struct = mammal_data(target_name,csv_file_name);
input_name = Rodentia_names{1};
input_struct = mammal_data(input_name,csv_file_name);

%% make parameter
Rat1_Rat1 = Volume_parameter_maker(target_struct, input_struct);

%% Phylogenetic tree
Tree = phytreeread('raxml_concatenated_treepl_calibrated.tree');
%[Matrix, ID, Distances] = getmatrix(Tree);
[dist, C] = pdist(Tree);
Rodent_names = get(Tree,'LeafNames');
idxs = [2, 4, 7, 10, 11, 13, 18, 30, 32, 36];
tree_rodent_names = {'Coypu', 'Dego', 'Chinchila','Capybara','Agouti',...
    'Porcupine','Vole','Mouse','Rat','BlindMole'};
M = length(Rodent_names);
a = zeros(51:51);
for I = 1:51
    for J = 1:(I-1)
        a(I,J) = dist((J-1)*(M-J/2)+I-J);
    end
end
a = a(idxs,idxs)+a(idxs,idxs)';
comparison_2_rat = a(9,:);

%% Adding names
Volume_tables_Rodentia2Rat1 = Volume_tables_new;
for i=1:27
    struct = Volume_tables_new{i};
    rodent_name = Rodentia_names{i};
    struct.name = rodent_name;
    Volume_tables_Rodentia2Rat1{i} = struct;
end