clc;
clear;
close all;

% wczytanie pliku dzwiekowego
[wav, fs]  = audioread('muzyka.wav');

wavsize = length(wav);

data = wav;
dctframe=dct(data);
dctframe1=dctframe;
j=0;
for k=1:wavsize
    if (abs(dctframe(k)) <= 0.055) %0.0065 0.039 0.055
        dctframe1(k)=0.0;
	    j=j+1;
    end
end

zer_wsp=(j/wavsize)*100;

fprintf(' Wyzerowaniu uleglo %2.1f procent wspolczynnikow DCT\n\n', zer_wsp);

comp = idct(dctframe1);

%zapis pliku przetworzonego na dysk
audiowrite('dct_muzyka.wav',comp,fs);

N = length(comp);
wav=wav(1:N);

dt=1/fs;
t=0:dt:N*dt-dt;

dfs=fs/N;
f=0:dfs:fs-dfs;

widmo_y=abs(fft(wav));
widmo_y(1)=widmo_y(1)/N;
widmo_y(2:end)=widmo_y(2:end)./(N/2);

widmo_y1=abs(fft(comp));
widmo_y1(1)=widmo_y1(1)/N;
widmo_y1(2:end)=widmo_y1(2:end)./(N/2);

%rysujemy wykresy sygnalu dzwiekowego przed i po przetworzeniu

figure(1)

subplot(3,1,1);
plot(t,wav);
ylim([-1 1]);
title('Sygnal przetwarzany')
grid on;
subplot(3,1,2);
plot(t,comp);
title('Sygnal po DCT')
ylim([-1 1]);
subplot(3,1,3);
plot(t,wav-comp);
title('Roznica pomiedzy sygnalem przetwrzanym a sygnalem po DCT')
%ylim([-1 1]);
grid on;

figure(2)

subplot(211)
semilogy(f(1:fix(N/2)),widmo_y(1:fix(N/2)));
grid on;
%ylim([10^(-4) 10^-1])
xlim([0 fs/2])
title('Widmo sygnału przetwarzanego');

subplot(212)
semilogy(f(1:fix(N/2)),widmo_y1(1:fix(N/2)));
grid on;
%ylim([10^(-4) 10^-1])
xlim([0 fs/2])
title('Widmo sygnału po kompresji');

figure(3)

subplot(211)
plot(dctframe)
grid on; axis tight;
title('Wspolczynniki DCT')

subplot(212)
plot(dctframe1)
grid on; axis tight;
title('Wspolczynniki DCT po progowaniu')
