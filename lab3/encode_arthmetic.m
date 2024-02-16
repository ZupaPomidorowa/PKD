file = 'niemanie.txt';

fileID = fopen(file,'r');
text = fscanf(fileID,'%c');
fclose(fileID);

text = cellfun(@double, num2cell(text));

[~, ~, mapped] = unique(text);
text_num_mapped = mapped';

unique_values = unique(text);
unique_mapped = unique(text_num_mapped);

occurrences = zeros(1, length(unique_values));

for i = 1:length(text_num_mapped)
    digit = text_num_mapped(i);
    occurrences(digit) = occurrences(digit) + 1;
end

seq = text_num_mapped;
counts = occurrences;
code = arithenco(seq, counts);

encodedfile = 'encoded_data_art.txt';
fileID2 = fopen(encodedfile, 'w');

for i = 1:length(unique_values)
    c = unique_values(i);
    c_map = unique_mapped(i);
    fprintf(fileID2, '%d:', c);
end

fprintf(fileID2, '|');
fprintf(fileID2, '%d', code);
fprintf(fileID2, '|');

for i = 1:length(counts)
    fprintf(fileID2, '%d;', counts(i));
end

fprintf(fileID2, '|');
fprintf(fileID2, '%d', length(seq));

fclose(fileID2);


compression_rate =  length(text) * 8 / length(code);
fprintf('Wspolczynnik kompresji: %2.4f.\n', compression_rate);

