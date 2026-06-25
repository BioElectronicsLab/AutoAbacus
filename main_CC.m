function Cells_final= main_CC(Alive, Dead, Settings)
% Main function for counting cells
% Alive - photo of sample in UV light
% Dead - photo of sample in N2.1 light
% Setting - file with option for photo processing
I_alive=Alive;
I_dead=Dead;
run(Settings);
if manual 
    imshow(I_alive)
    title('Please click on all of the cells and then press the key of choice (default spacebar)')
    manual_cell_count_alive =0;
manual_cluster =1;
while manual_cluster ~= button_of_choice
        [x_input, y_input, manual_cluster] = ginput(1);
        if manual_cluster == button_of_choice
            break
        else
         viscircles([x_input, y_input], 10, 'Color','green');
         manual_cell_count_alive=manual_cell_count_alive+1;
        end
end
imshow(I_dead)
title('Please click on all of the dead cells and then press the key of choice (default spacebar)')
    manual_cell_count_dead=0;
manual_cluster =1;
while manual_cluster ~= button_of_choice
        [x_input, y_input, manual_cluster] = ginput(1);
        if manual_cluster == button_of_choice
            break
        else
         viscircles([x_input, y_input], 10, 'Color','magenta');
         manual_cell_count_dead=manual_cell_count_dead+1;
        end
end
dead_procent = manual_cell_count_dead./manual_cell_count_alive;
%saveas(gcf, Getting_save_handle(Alive, Dead)+'.png' )
Cells_final = [manual_cell_count_alive, manual_cell_count_dead, dead_procent];

else
%I_alive =Get_rid_of_marker(I_alive, a, b, c, d);
%I_dead= Get_rid_of_marker(I_dead, a, b, c, d);
[count_alive, count_th, BinaryImage_all_alive] = CC_Func(I_alive, res_1_alive, res_2_alive, start_alive, finished_alive, valued_area_alive, false, 'g', true);
hold on
[count_dead, ~, BinaryImage_all_dead ] = CC_Func(I_dead, res_1_dead, res_2_dead, start_dead, finished_dead, valued_area_dead, false, 'b', false);
title('Is there any unnoticed cells left? Please click on them all and then press the key of choice (default spacebar)')
% [x_input, y_input] = ginput;
% [add_cell_count, ~]= size(x_input);
% for i =1:add_cell_count
%     viscircles([x_input(i), y_input(i)], 10, 'Color','yellow');
% end
add_cell_count =0;
button_cell =1;
while button_cell ~= button_of_choice
        [x_input, y_input, button_cell] = ginput(1);
        if button_cell == button_of_choice
            break
        else
          viscircles([x_input, y_input], 10, 'Color','yellow');
         add_cell_count=add_cell_count+1;
        end
end
title('Is there any additional cells? Please click on them all and then press the key of choice (default space bar)')
cluster_cell_count =0;
button_cluster =1;
while button_cluster ~= button_of_choice
        [x_input, y_input, button_cluster] = ginput(1);
        if button_cluster == button_of_choice
            break
        else
         viscircles([x_input, y_input], 10, 'Color','magenta');
         cluster_cell_count=cluster_cell_count-1;
        end
end
count_alive=count_alive+cluster_cell_count+add_cell_count;
alive_procent = (count_alive-count_dead)./count_alive;
Cells_final = [count_alive, alive_procent, count_dead];
end