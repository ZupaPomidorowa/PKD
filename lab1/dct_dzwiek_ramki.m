clc;
clear;
close all;

% wczytanie pliku dzwiekowego
[wav, fs]  = audioread('muzyka.wav');

wavsize = length(wav);
fprintf('\n %i - liczba probek sygnalu dzwiekowego\n',wavsize);

% rozmiar ramki
framesize = 662; %0.03sek

% dzialimy wektor probek dzwieku na ramki
data = buffer(wav,framesize);

%%%%
comp = [];
s = 1; buffsize = framesize;
j=0;

% dla każdej ramki
for i=1:(size(data,2)-1)
   
  % pojedyncza ramka
  frame = data(:,i);
	
  dctframe=dct(frame);
  
      for k=1:framesize
         
         if (abs(dctframe(k)) <= 0.034)
		 %if (k>200)
            dctframe(k)=0.0;
	        j=j+1;
         end
         
      end   
  
    frame1=idct(dctframe);	
  
  % tablica z przetworzonym wektorem dzwieku
  comp(s:buffsize,:) = frame1;	
   
  s = s + framesize;
  buffsize = buffsize + framesize;
    
end

zer_wsp=(j/wavsize)*100;

fprintf(' Wyzerowaniu uleglo %2.1f procent wspolczynnikow DCT\n\n', zer_wsp);

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

%zapis pliku przetworzonego na dysk
audiowrite('dct_muzyka_ramki.wav',comp,fs);
%soundsc(wav-comp,fs)
%sound(comp,fs)

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
