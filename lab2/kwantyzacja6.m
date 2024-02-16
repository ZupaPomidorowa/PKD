function [B] = kwantyzacja6(block_struct)
global sum_zeros;

mask = [1 1 1 0 0 0 0 0;
        1 1 0 0 0 0 0 0;
        1 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0;
        0 0 0 0 0 0 0 0];
    
    B = (block_struct.data) .* mask;

    zeros = sum(sum(mask(:,:)==0));

    sum_zeros = sum_zeros+zeros;
    
end