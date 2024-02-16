file = 'encoded_data.txt';

fileID = fopen(file,'r');
text = fscanf(fileID,'%c');
fclose(fileID);

text = convertCharsToStrings(text);

splitParts = split(text, ',|');

encoded = splitParts(2);
dict = splitParts(1);

encoded = split(encoded, "");
encoded = encoded.';
encoded = encoded(2:length(encoded)-1);
encoded = double(encoded);

sumSymbols = dictionary(double([]), double([]));
txt_len = 0;
dict = split(dict, ',');

for i = 1:length(dict)
    tmp = split(dict(i), ":");
    num = str2double(tmp);
    sumSymbols(num(1)) = num(2);
    txt_len = txt_len + num(2);
end

alphabet = keys(sumSymbols);
prob = values(sumSymbols) / txt_len;

dict = huffmandict(alphabet, prob);
decoded = huffmandeco(encoded, dict);
decoded = char(decoded);


encodedfile = 'decoded_data.txt';
fileID2 = fopen(encodedfile, 'w');
fprintf(fileID2, '%c', decoded);
fclose(fileID2);

