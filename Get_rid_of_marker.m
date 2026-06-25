function I_without_marker = Get_rid_of_marker(I_with_marker, a, b, c, d)
% I_with_marker - image with marker that needs to be covered
% a, b, c, d - coordinates of marker, they come from settings
I_without_marker =  I_with_marker(:,:,1);
for i=a:b
    for j=c:d
        I_without_marker(i,j)=5;
    end
end