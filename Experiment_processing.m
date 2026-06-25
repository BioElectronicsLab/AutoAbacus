function Cells_final = Experiment_processing(folder_name, p)
% An example of function that was used to process data from one sample from simgle day of experiment
% folder name - sample name
% p - probability
Settings_name = 'Settings_'+folder_name+'.m';
counter_name = 'Count_test';
data_ab=pwd;
data_folder = data_ab+"\data_folder\"+folder_name+"\";
I_alive_all=[];
for j=[1 2]
    if j==1
        i_let='N';
    elseif j==2
        i_let='Q';
    end
for i=[ 1, 4, 7]
I_alive= data_folder+i_let+'\'+"image000"+num2str(i)+".png";
    I_alive_all = [I_alive_all, I_alive];
end
end
I_dead_all = [];
for j=[1 2]
    if j==1
        i_let='N';
    elseif j==2
        i_let='Q';
    end
for i=[ 2, 5, 8]
% 
I_dead=data_folder+i_let+'\'+"image000"+num2str(i)+".png";
I_dead_all = [I_dead_all, I_dead];
end
end
mkdir(fullfile(data_folder, 'Image_with_cells'))
folder_analysis= string(data_folder)+'Image_with_cells';
[ ~, a_all]=size(I_alive_all);
res_1=400;
res_2=400;
c_1=3;
c_2=4;
for i=1:a_all
    Alive =I_alive_all(i);
    Dead=I_dead_all(i);
    I_alive= imread(Alive);
    save_name = folder_analysis+'\image'+string(i)+'.png';
a=1113;
b=1184;
c=1456;
d=1586;
I_dead= imread(Dead);
I_alive =Get_rid_of_marker(I_alive, a, b, c, d);
I_dead= Get_rid_of_marker(I_dead, a, b, c, d);
I_alive = imgaussfilt(I_alive);
I_dead = imgaussfilt(I_dead);
image_fin = [];
image_strip=[];
    for i_part=1:c_1
        image_fin = [image_fin; image_strip];  
        image_strip=[];
        for j_part=1:c_2
            close all
            [i,i_part,j_part]
    Alive_part =I_alive((res_1*(i_part-1)+1):(res_1*i_part), (res_2*(j_part-1)+1):(res_2*j_part));
    Dead_part =I_dead((res_1*(i_part-1)+1):(res_1*i_part), (res_2*(j_part-1)+1):(res_2*j_part));
   [Cell_count(:,c_1*c_2*(i-1)+c_2*(i_part-1)+j_part)]=main_CC(Alive_part, Dead_part, Settings_name);
   save_name_imag = folder_analysis+'\'+string(i_part)+string(j_part)+'.png';
    title('','Visible','off');
  exportgraphics(gca, save_name_imag, 'BackgroundColor', 'white')
  I_final_part = imread(save_name_imag);
  image_strip = [image_strip, I_final_part(1:504, 1:504, :  )];
  delete(save_name_imag);
       end
    end
    image_fin = [image_fin; image_strip];
    imwrite(image_fin, save_name);   
 end
[E, CI]=Get_Stat_Func(Cell_count, p);
Cells_final=[E, CI];
save(counter_name+string(folder_name));
