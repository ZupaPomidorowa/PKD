file = 'encoded_data_art.txt';

fileID = fopen(file,'r');
text = fscanf(fileID,'%c');
fclose(fileID);

text = convertCharsToStrings(text);

splitParts = split(text, ':|');
splitParts2 = split(splitParts(2), '|');

dict = splitParts(1);
code = splitParts2(1);
counts = splitParts2(2);
len_seq = double(splitParts2(3));

code = split(code, "");
code = code.';
code = code(2:length(code)-1);
code = double(code);

counts = split(counts,";");
counts = counts.';
counts = counts(1:length(counts)-1);
counts = double(counts);

dseq = arithdeco(code,counts,length(seq));

dict = split(dict, ':');
dict = dict.';
dict = double(dict);
dict_test = dict;

resultString = '';

for i = 1:length(dseq)
    n = dseq(i);
    c = dict_test(n);
    resultString = [resultString, char(c)];
end


filename = 'decoded_data_art.txt';

fileID = fopen(filename, 'w');

fprintf(fileID, '%s', resultString);

fclose(fileID);



