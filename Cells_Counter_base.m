function  [cells_count, cluster_count, ind, B_global, count_B, ind_normal] = Cells_Counter_base(a,b,valied_area, I_part, B_global, count_B, show_graph, Binary);
% a - start of the grey supposed boundary
% b - end of the grey supposed boundary
% valied_area - minimal area of the cell
% I_part - image
% show_graph (true or false)  -- to show boundaries of found cells
Count_all=[];
for l=a:b
    if Binary
   binaryImage=I_part;
    else
I_grey = I_part(:,:,1);
binaryImage = I_grey > l;
    end
[B,L] = bwboundaries(binaryImage,'noholes');
count_1=0;
[m, ~]=size(B);
for m_c=1:m
    %[size_a size_b]=size(B{m_c});
    size_a=Get_area(B{m_c}, I_part);
    if size_a>valied_area
        count_1=count_1+1;
    end
end
Count_all = [Count_all count_1];
end
[cells_count, ind]=max(Count_all);
    if ~Binary
binaryImage = I_grey > (a-1+ind);
    end
[B,L] = bwboundaries(binaryImage,'noholes');
ind_k=[];
[m, ~]=size(B);
Area_all=[];
ind_normal =[];
ind_cluster=[];
cluster_count=0;
for m_c=1:m
    %[size_a size_b]=size(B{m_c});
    size_a=Get_area(B{m_c}, I_part);
    if size_a>valied_area
        Area_all =[Area_all size_a];
        ind_k =[ind_k m_c];
    end
end
med_area = median(Area_all);
count_m_c=1;
for m_c=ind_k
    %[size_a size_b]=size(B{m_c});
    %size_a=Get_area(B{m_c}, I_part);
    size_a = Area_all(count_m_c);
    count_m_c=count_m_c+1;
    if size_a>1.25*med_area
        cluster_count = cluster_count+1;
        ind_cluster=[ind_cluster m_c];
    elseif (valied_area<size_a) && (size_a<1.25*med_area)
          ind_normal=[ind_normal m_c];
    end
end
if show_graph == true
imshow(I_part, [])
hold on
for k = ind_normal
   boundary = B{k};
   B_global{count_B} = B{k};
   count_B=count_B+1;
   plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2)
end

for k = ind_cluster
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end 
hold off
%fprintf('I have found %d clusters', cluster_count);
pause
end
end