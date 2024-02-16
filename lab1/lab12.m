clc;
clear;
close all;

%[wav, fpw] = audioread('.\123.wav');
%[mp3, fpm] = audioread('.\123_128b.mp3');
%[mp3_v5, fpm_v5] = audioread('.\123_v5.mp3');
%[mp3_v6, fpm_v6] = audioread('.\123_v6.mp3');

[wav, fpw] = audioread('.\muzyka.wav');
[mp3, fpm] = audioread('.\muzyka_128b.mp3');
[mp3_v5, fpm_v5] = audioread('.\muzyka_v5.mp3');
[mp3_v6, fpm_v6] = audioread('.\muzyka_v6.mp3');

N_wav=length(wav);
tk=N_wav/fpw;
T=1/fpw;
tw=0:T:tk-T;

N_mp3 = length(mp3);
tk = N_mp3/fpm;
T = 1/fpm;
tm = 0:T:tk-T;

N_mp3_v5=length(mp3_v5);
tk=N_mp3_v5/fpm_v5;
T=1/fpm_v5;
tm_v5=0:T:tk-T;

N_mp3_v6=length(mp3_v6);
tk=N_mp3_v6/fpm_v6;
T=1/fpm_v6;
tm_v6=0:T:tk-T;

figure(1)
subplot(411)
plot(tw,wav);
grid on; axis tight;
title('Sygnał przetwarzany')

subplot(412)
plot(tm, mp3);
grid on; axis tight;
title('Sygnał po kompresji 128b');

subplot(413)
plot(tm_v5,mp3_v5);
grid on; axis tight;
title('Sygnał po kompresji VBR V5');

subplot(414)
plot(tm_v6,mp3_v6);
grid on; axis tight;
title('Sygnał po kompresji VBR V6');

yww = abs(fft(wav));
yww(1) = yww(1)/N_wav;
yww(2:end) = yww(2:end)./(N_wav/2);
dFs = fpw/N_wav;
fw =0:dFs:fpw-dFs;

ywm = abs(fft(mp3));
ywm(1) = ywm(1)/N_mp3;
ywm(2:end) = ywm(2:end)./(N_mp3/2);
dFs = fpm/N_mp3;
fm =0:dFs:fpw-dFs;

ywm_v5=abs(fft(mp3_v5));
ywm_v5(1)=ywm_v5(1)/N_mp3_v5;
ywm_v5(2:end)=ywm_v5(2:end)./(N_mp3_v5/2);
dFs=fpm_v5/N_mp3_v5;
fm_v5=0:dFs:fpm_v5-dFs;

ywm_v6=abs(fft(mp3_v6));
ywm_v6(1)=ywm_v6(1)/N_mp3_v6;
ywm_v6(2:end)=ywm_v6(2:end)./(N_mp3_v6/2);
dFs=fpm_v6/N_mp3_v6;
fm_v6=0:dFs:fpm_v6-dFs;

figure(2)
subplot(411)
semilogy(fw(1:fix(N_wav/2)), yww(1:fix(N_wav/2)));
grid on; axis tight;
ylim([10^-8 10^-1])
title('Widmo sygnału przetwarzanego')

subplot(412)
semilogy(fm(1:fix(N_mp3/2)), ywm(1:fix(N_mp3/2)));
grid on; axis tight;
ylim([10^-8 10^-1])
title('Widmo sygnału po kompresji 128b')

subplot(413)
semilogy(fm_v5(1:fix(N_mp3_v5/2)),ywm_v5(1:fix(N_mp3_v5/2)));
ylim([10^-8 10^-1])
grid on; axis tight;
title('Widmo sygnalu po kompresji VBR V5')

subplot(414)
semilogy(fm_v6(1:fix(N_mp3_v6/2)),ywm_v6(1:fix(N_mp3_v6/2)));
ylim([10^-8 10^-1])
grid on; axis tight;
title('Widmo sygnalu po kompresji VBR V6')

%%Spektrogramy
figure(3)
subplot(221)
spectrogram(wav, hanning(1024),1000,[],fpw,'yaxis')
title('Sygnał przetwarzany');

subplot(222)
spectrogram(mp3, hanning(1024),1000,[],fpm,'yaxis')
title('Sygnał po kompresji 128b');

subplot(223)
spectrogram(mp3_v5,hann(1024),1000,[],fpm_v5,'yaxis');
title('Sygnał po kompresji VBR V5');

subplot(224)
spectrogram(mp3_v6,hann(1024),1000,[],fpm_v6,'yaxis');
title('Sygnał po kompresji VBR V6');
