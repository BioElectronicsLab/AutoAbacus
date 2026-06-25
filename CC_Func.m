function [cell_count_fin, cell_count_th, BinaryImage_all] = CC_Func(I, res_1, res_2, grey_start, grey_finish, valued_area, show_graphs, color, alive)
% funtion for counting cells on different parts of photo
% I - photo
% res_1 - resolution by length 
% res_2 - resolution by width
% grey_start - starting threshold for grey
% grey_finish - finishing threshold for grey
% valued_area - amount of pixels starting from which we declare spot as a
% cell
% show_graphs - true or false
% color - color of bounderies on the finished picture
% alive - true or false
[a, b, ~]=size(I);
if res_1 && res_2
    c_1=a/res_1;
    c_2=b/res_2;
else 
    c_1=1;
    c_2=1;
end
BinaryImage_all=[];
cell_count_th=0;
for i=1:c_1
    for j=1:c_2
        I_part =I((res_1*(i-1)+1):(res_1*i), (res_2*(j-1)+1):(res_2*j));
        [binaryImage_1, cell_count_1] = Cell_counter_cluster(res_1, res_2, grey_start, grey_finish, valued_area, I_part, show_graphs, false);
        BinaryImage_all((res_1*(i-1)+1):(res_1*i), (res_2*(j-1)+1):(res_2*j))= binaryImage_1;
        cell_count_th = cell_count_th+cell_count_1;
    end
end
cell_count_fin=Cell_counter_binary(I, valued_area, BinaryImage_all, color, alive);
end