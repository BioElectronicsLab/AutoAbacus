function Area = Get_area(B, I_part)
% This function helps with obtaining amount of pixel that are higher than a
% treshold
% I_part - image
% B - coordinates of the pixels
Second_Batch=5*ones(size(I_part));
[size_k, ~] =size(B);
     for g=1:size_k
            i=B(g,1);
            j=B(g,2);
            Second_Batch(i,j)=I_part(i,j);
     end
binaryImage3 = imfill(Second_Batch>5, 'holes');
Area = sum(binaryImage3(:) == 1);