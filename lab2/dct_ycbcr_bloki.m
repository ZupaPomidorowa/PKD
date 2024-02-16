clc;
clear;
close all;

global suma_zer;

I = imread('.\obrazki\lena.tif');

[numrows, numcols, ~] = size(I);
numrows = floor(numrows / 8) * 8;
numcols = floor(numcols / 8) * 8;
number_of_blocks = (numrows * numcols) / 64;
I = imresize(I, [numrows, numcols]);

fun_dct = @(block_struct) dct2(block_struct.data);
fun_idct = @(block_struct) idct2(block_struct.data);

fun_luma = @kwantyzacja_tabl_luma;
fun_chroma = @kwantyzacja_tabl_chroma;

YCbCr_I = rgb2ycbcr(I);
Y = double(YCbCr_I(:,:,1));
Cb = double(YCbCr_I(:,:,2));
Cr = double(YCbCr_I(:,:,3));


B1 = blockproc(Y, [8, 8], fun_dct);
C1 = blockproc(Cb, [8, 8], fun_dct);
D1 = blockproc(Cr, [8, 8], fun_dct);

suma_zer = 0;
B2 = blockproc(B1, [8, 8], fun_luma);
luma_block = 64-suma_zer/number_of_blocks;

suma_zer = 0;
C2 = blockproc(C1, [8, 8], fun_chroma);
Cb_block = 64-suma_zer/number_of_blocks;

suma_zer = 0;
D2 = blockproc(D1, [8, 8], fun_chroma);
Cr_block = 64-suma_zer/number_of_blocks;

B3 = blockproc(B2, [8, 8], fun_idct);
C3 = blockproc(C2, [8, 8], fun_idct);
D3 = blockproc(D2, [8, 8], fun_idct);

B3 = B3/ 255;
C3 = C3/ 255;
D3 = D3/ 255;

B4 = im2uint8(B3);
C4 = im2uint8(C3);
D4 = im2uint8(D3);

I2 = cat(3, B4, C4, D4);

I2_rgb = ycbcr2rgb(I2);

figure(1);
imshow(3 * (I - I2_rgb)), title('Różnice');

figure(2);
imshow(I2_rgb), title('Obraz po kompresji')

figure(3);
imshow(I), title('Obraz oryginalny');

fprintf('Luminancja wsp zostalo: %0.1f\n', luma_block);
fprintf('Cb wsp zostalo: %0.1f\n', Cb_block);
fprintf('Cr wsp zostalo: %0.1f\n', Cr_block);
