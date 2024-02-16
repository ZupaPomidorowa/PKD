function [B] = kwantyzacja_tabl_chroma(block_struct)

global suma_zer;
mask = [17 18 24 47 99 99 99 99;
        18 21 26 66 99 99 99 99;
        24 26 56 99 99 99 99 99;
        47 66 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99;
        99 99 99 99 99 99 99 99];
    
    B = (block_struct.data) ./ mask;
    B=round(B);
    B=B .* mask;
    
    zer=sum(sum(B(:,:)==0));
    
    suma_zer=suma_zer+zer;
end