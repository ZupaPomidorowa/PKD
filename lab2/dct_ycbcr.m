clear
close all

A = imread('.\obrazki\lena.tif');
B=colorspace('RGB->YCbCr',A);

luma = double(B(:,:,1))./255;
Cb = double(B(:,:,2))./255;
Cr = double(B(:,:,3))./255;

luma_dct = dct2(luma);
Cb_dct = dct2(Cb);
Cr_dct = dct2(Cr);

compression_factor = 0.1;
[N,M]=size(luma_dct);
luma_counter = 0;
Cb_counter = 0;
Cr_counter = 0;

for i = 1:N
    for j = 1:M
        if (abs(luma_dct(i, j)) <= compression_factor)
            luma_dct(i, j) = 0.0;
            luma_counter = luma_counter + 1;
        end
        if (abs(Cb_dct(i, j)) <= compression_factor)
            Cb_dct(i, j) = 0.0;
            Cb_counter = Cb_counter + 1;
        end
        if (abs(Cr_dct(i, j)) <= compression_factor)
            Cr_dct(i, j) = 0.0;
            Cr_counter = Cr_counter + 1;
        end
    end
end

% luma_dct(abs(luma_dct) <= compression_factor) = 0;
% Cb_dct(abs(Cb_dct) <= compression_factor) = 0;
% Cr_dct(abs(Cr_dct) <= compression_factor) = 0;

luma_rec = idct2(luma_dct);
Cb_rec = idct2(Cb_dct);
Cr_rec = idct2(Cr_dct);

img_cat = cat(3, luma_rec, Cb_rec, Cr_rec).*255;
compressed_image = colorspace('YCbCr->RGB',img_cat);

diff_luma = abs(luma-luma_rec);
diff_Cb = abs(Cb-Cb_rec);
diff_Cr = abs(Cr-Cr_rec);

figure(1);
imshow(A);
title('Original Image');

figure(2);
imshow(compressed_image);
title('Compressed Image');

figure(3);
subplot(1,3,1);
imshow(diff_luma);
title('Difference Luma');

subplot(1,3,2);
imshow(diff_Cb);
title('Difference Cb');

subplot(1,3,3);
imshow(diff_Cr);
title('Difference Cr');

luma_percent=(luma_counter/(N*M))*100;
Cb_percent=(Cb_counter/(N*M))*100;
Cr_percent=(Cr_counter/(N*M))*100;

fprintf('Wyzerowane wspolczynniki luma: %2.1f\n', luma_percent);
fprintf('Wyzerowane wspolczynniki Cb: %2.1f\n', Cb_percent);
fprintf('Wyzerowane wspolczynniki Cr: %2.1f\n', Cr_percent);


