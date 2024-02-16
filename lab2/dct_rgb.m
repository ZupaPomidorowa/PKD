clear
close all

A = imread('.\obrazki\baboon.jpg');

R = double(A(:,:,1))./255;
G = double(A(:,:,2))./255;
B = double(A(:,:,3))./255;

R_dct = dct2(R);
G_dct = dct2(G);
B_dct = dct2(B);

compression_factor = 0.7;
[N,M]=size(R_dct);
R_counter = 0;
G_counter = 0;
B_counter = 0;

for i = 1:N
    for j = 1:M
        if (abs(R_dct(i, j)) <= compression_factor)
            R_dct(i, j) = 0.0;
            R_counter = R_counter + 1;
        end
        if (abs(G_dct(i, j)) <= compression_factor)
            G_dct(i, j) = 0.0;
            G_counter = G_counter + 1;
        end
        if (abs(B_dct(i, j)) <= compression_factor)
            B_dct(i, j) = 0.0;
            B_counter = B_counter + 1;
        end
    end
end

% R_dct(abs(R_dct) <= compression_factor) = 0;
% G_dct(abs(G_dct) <= compression_factor) = 0;
% B_dct(abs(B_dct) <= compression_factor) = 0;

R_reconstructed = idct2(R_dct);
G_reconstructed = idct2(G_dct);
B_reconstructed = idct2(B_dct);

compressed_image = cat(3, R_reconstructed, G_reconstructed, B_reconstructed);

diff_R = abs(R-R_reconstructed);
diff_G = abs(G-G_reconstructed);
diff_B = abs(B-B_reconstructed);

figure(1);
imshow(A);
title('Original Image');

figure(2);
imshow(compressed_image);
title('Compressed Image');

figure(3);
subplot(1,3,1);
imshow(diff_R);
title('Difference Red Channel');

subplot(1,3,2);
imshow(diff_G);
title('Difference Green Channel');

subplot(1,3,3);
imshow(diff_B);
title('Difference Blue Channel');

R_percent=(R_counter/(N*M))*100;
G_percent=(G_counter/(N*M))*100;
B_percent=(B_counter/(N*M))*100;

fprintf('Wyzerowane wspolczynniki czerwone: %2.1f\n', R_percent);
fprintf('Wyzerowane wspolczynniki zielone: %2.1f\n', G_percent);
fprintf('Wyzerowane wspolczynniki niebieskie: %2.1f\n', B_percent);

