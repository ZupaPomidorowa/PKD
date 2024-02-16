file = 'niemanie.txt';

fileID = fopen(file,'r');
text = fscanf(fileID,'%c');
fclose(fileID);

%uniqueSymbols = unique(text);
sumSymbols = dictionary(double([]), double([]));

for i = text
    if isKey(sumSymbols, i) == false
        sumSymbols(i) = 1;
    else
        sumSymbols(i) = sumSymbols(i) + 1;
    end
end

alphabet = keys(sumSymbols);
prob = values(sumSymbols) / length(text);

dict = huffmandict(alphabet, prob);
encoded = huffmanenco(text, dict);

encodedfile = 'encoded_data.txt';
fileID2 = fopen(encodedfile, 'w');

for i = 1:length(alphabet)
    c = alphabet(i);
    fprintf(fileID2, '%d:%d,', c, sumSymbols(c));
end

fprintf(fileID2, '|');
fprintf(fileID2, '%d', encoded);


fclose(fileID2);

compression_rate =  length(text) * 8 / length(encoded);
fprintf('Wspolczynnik kompresji: %2.4f.\n', compression_rate);






