function save_handle = Getting_save_handle(Alive, Dead)
% Alive - image with alive cells
% Dead - image with dead cells
alive_parts = split(Alive, '\');
dead_parts = split(Dead, '\');
number_of_image_alive =  extract(alive_parts(end), 9);
number_of_image_dead = extract(dead_parts(end), 9);
save_handle = alive_parts(end-3)+'_'+alive_parts(end-2)+'_'+alive_parts(end-1)+'_'+number_of_image_alive+'_'+number_of_image_dead;
end