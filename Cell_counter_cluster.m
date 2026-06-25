function [binaryImage_all, cells_count_final] = Cell_counter_cluster(res_1, res_2, a,b,valied_area, I_part, show_graph, Binary)
% res_1 - resolution by length 
% res_2 - resolution by width
% a - start of the grey supposed boundary
% b - end of the grey supposed boundary
% valied_area - minimal area of the cell
% I_part - image
% show_graph (true or false)  -- to show boundaries of found cells
% Binary (true or false) - is I_part binary or colorful
B_global=[];
count_B=1;
 [cells_count, cluster_count, ind, B_global, count_B, ind_normal] = Cells_Counter_base(a,b,valied_area, I_part, B_global, count_B, show_graph, Binary);
 I_cluster=I_part;
 cells_count_1= cells_count-cluster_count;
 I_grey = I_cluster(:,:,1);
 binaryImage_all = zeros(size(I_part));
 while cluster_count ~= 0
     if Binary
         binaryImage =I_cluster;
     else
     I_grey = I_cluster(:,:,1);
     binaryImage = I_grey > (a-1+ind);
     end
     if Binary
         Second_Batch=zeros(size(binaryImage));
     else
     Second_Batch=5*ones(size(binaryImage));
     end
     [B,L] = bwboundaries(binaryImage,'noholes');
ind_k=[];
[m, ~]=size(B);
Area_all=[];
ind_cluster=[];
for m_c=1:m
    [area, ~]=size(find(L==m_c));
    Area_all =[Area_all area];
 end
     [sortedAreas sortIndices] = sort(Area_all, 'descend');
     keeperIndexes = sortIndices(1:cluster_count);
     for k= keeperIndexes
          Area_k = B{k};
          [size_k, ~] =size(B{k});
     for g=1:size_k
            i=Area_k(g,1);
            j=Area_k(g,2);
            Second_Batch(i,j)=I_part(i,j);
     end
     end
     if Binary
     binaryImage3 = imfill(Second_Batch<5, 'holes');
     else
         binaryImage3 = imfill(Second_Batch>5, 'holes');
     end
     for i=1:res_1
for j=1:res_2
if binaryImage3(i,j)==1
Second_Batch(i,j)=I_part(i,j); 
end
end
     end
     
     Second_Batch_2=5*ones(size(I_part));
     keeperIndexes = ind_normal;
     for k= keeperIndexes
          Area_k = B{k};
          [size_k, ~] =size(B{k});
     for g=1:size_k
            i=Area_k(g,1);
            j=Area_k(g,2);
            Second_Batch_2(i,j)=I_part(i,j);
     end
     end
     binaryImage3 = imfill(Second_Batch_2>5, 'holes');
     for i=1:res_1
for j=1:res_2
if binaryImage3(i,j)==1 
binaryImage_all(i,j)= binaryImage3(i,j);
end
end
     end   
[cells_count_2, cluster_count_2, ind_2, B_global, count_B, ind_normal] = Cells_Counter_base(a,b,valied_area, Second_Batch, B_global, count_B, show_graph, Binary);
    cells_count_1= cells_count_1-cluster_count_2+cells_count_2;
    cluster_count=cluster_count_2;
    ind=ind_2;
    I_cluster=Second_Batch;
 end
 if ~Binary
     if ~Binary
      I_grey = I_cluster(:,:,1);
     binaryImage = I_grey > (a-1+ind);
     else 
       binaryImage=I_part;
     end
     Second_Batch_2=5*ones(size(binaryImage));
     [B,L] = bwboundaries(binaryImage,'noholes');
 keeperIndexes = ind_normal;
     for k= keeperIndexes
          Area_k = B{k};
          [size_k, ~] =size(B{k});
     for g=1:size_k
            i=Area_k(g,1);
            j=Area_k(g,2);
            Second_Batch_2(i,j)=I_part(i,j);
     end
     end
     binaryImage3 = imfill(Second_Batch_2>5, 'holes');
     for i=1:res_1
for j=1:res_2
if binaryImage3(i,j)==1 
binaryImage_all(i,j)= binaryImage3(i,j);
end
end
     end
 end
 cells_count_final=cells_count_1;
end

