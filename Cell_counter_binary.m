function cell_count_fin=Cell_counter_binary(I_alive, valued_area, BinaryImage_all, color, alive)
[B,L] = bwboundaries(BinaryImage_all,'noholes');
ind_k=[];
[m, ~]=size(B);
Area_all=[];
ind_normal =[];
ind_cluster=[];
cluster_count=0;
for m_c=1:m
   % [area size_b]=size(B{m_c});
   [area, ~]=size(find(L==m_c));
    if area>valued_area
        Area_all =[Area_all area];
    end
end
med_area = median(Area_all);
for m_c=1:m
   % [area size_b]=size(B{m_c});
    [area, ~]=size(find(L==m_c));
    if area>2*med_area
        cluster_count = cluster_count+1;
        ind_cluster=[ind_cluster m_c];
    elseif (valued_area<area) && (area<2*med_area)
          ind_normal=[ind_normal m_c];
    end
end
if alive
imshow(I_alive, [])
end
hold on
for k = ind_normal
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), color, 'LineWidth', 2)
end

for k = ind_cluster
   boundary = B{k};
   plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2)
end 
hold off
%fprintf('I have found %d clusters', cluster_count);
[~, size_norm] =size(ind_normal);
[~, size_cluster] =size(ind_cluster);
cell_count_fin = size_norm+size_cluster;
end