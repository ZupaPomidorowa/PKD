clear
close all

%A = imread('.\obrazy\tekst.jpg');
A = imread('.\obrazki\baboon.jpg');

Rr = double(A(:,:,1));
Gg = double(A(:,:,2));
Bb = double(A(:,:,3));

%obraz oryginalny
figure(1)
imshow(A);
title('Obraz oryginalny')

B=colorspace('RGB->YCbCr',A);

luma = double(B(:,:,1));
Cb = double(B(:,:,2));
Cr = double(B(:,:,3));

figure(2)
imshow(luma./255);
title('Luminancja')
figure(3)
imshow(Cr./255);
title('Cr')
figure(4)
imshow(Cb./255);
title('Cb')


[N,M]=size(luma);
luma_st=zeros(N,M);
 for i=1:N
   for j=1:M
      luma_st(i,j)=210;
   end
 end

%kolory przy sta³ej luminancji
figure(5)
B1=cat(3,luma_st,Cb,Cr);
B2=colorspace('YCbCr->RGB',B1);
imshow(B2);
title('Kolory przy sta³ej luminancji')

figure(6)
imshow(Rr./255);
title('R')
figure(7)
imshow(Gg./255);
title('G')
figure(8)
imshow(Bb./255);
title('B')
