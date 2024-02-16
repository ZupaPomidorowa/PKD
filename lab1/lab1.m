clc;
clear;
close all;

%[wav, fpw] = audioread('.\123.wav');
%[mp3, fpm] = audioread('.\123_8b.mp3');
%[mp3_32, fpm_32] = audioread('.\123_32b.mp3');
%[mp3_128, fpm_128] = audioread('.\123_128b.mp3');

[wav, fpw] = audioread('.\muzyka.wav');
[mp3, fpm] = audioread('.\muzyka_8b.mp3');
[mp3_32, fpm_32] = audioread('.\muzyka_32b.mp3');
[mp3_128, fpm_128] = audioread('.\muzyka_128b.mp3');

N_wav = length(wav);
tk = N_wav/fpw;
T = 1/fpw;
tw = 0:T:tk-T;

N_mp3 = length(mp3);
tk = N_mp3/fpm;
T = 1/fpm;
tm = 0:T:tk-T;

N_mp3_32 = length(mp3_32);
tk = N_mp3_32/fpm_32;
T = 1/fpm_32;
tm_32 = 0:T:tk-T;

N_mp3_128 = length(mp3_128);
tk = N_mp3_128/fpm_128;
T = 1/fpm_128;
tm_128 = 0:T:tk-T;

figure(1)
subplot(411)
plot(tw,wav);
grid on; axis tight;
title('Sygnał przetwarzany')

subplot(412)
plot(tm, mp3);
grid on; axis tight;
title('Sygnał po kompresji 8b');

subplot(413)
plot(tm_32, mp3_32);
grid on; axis tight;
title('Sygnał po kompresji 32b');

subplot(414)
plot(tm_128, mp3_128);
grid on; axis tight;
title('Sygnał po kompresji 128b');


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

ywm_32 = abs(fft(mp3_32));
ywm_32(1) = ywm_32(1)/N_mp3_32;
ywm_32(2:end) = ywm_32(2:end)./(N_mp3_32/2);
dFs = fpm_32/N_mp3_32;
fm_32 =0:dFs:fpw-dFs;

ywm_128 = abs(fft(mp3_128));
ywm_128(1) = ywm_128(1)/N_mp3_128;
ywm_128(2:end) = ywm_128(2:end)./(N_mp3_128/2);
dFs = fpm_128/N_mp3_128;
fm_128 =0:dFs:fpw-dFs;

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
title('Widmo sygnału po kompresji 8b')

subplot(413)
semilogy(fm_32(1:fix(N_mp3_32/2)), ywm_32(1:fix(N_mp3_32/2)));
grid on; axis tight;
ylim([10^-8 10^-1])
title('Widmo sygnału po kompresji 32b')

subplot(414)
semilogy(fm_128(1:fix(N_mp3_128/2)), ywm_128(1:fix(N_mp3_128/2)));
grid on; axis tight;
ylim([10^-8 10^-1])
title('Widmo sygnału po kompresji 128b')


%%Spektrogramy
figure(3)
subplot(221)
spectrogram(wav, hanning(1024),1000,[],fpw,'yaxis')
title('Sygnał przetwarzany');

subplot(222)
spectrogram(mp3, hanning(1024),1000,[],fpm,'yaxis')
title('Sygnał po kompresji 8b');

subplot(223)
spectrogram(mp3_32, hanning(1024),1000,[],fpm_32,'yaxis')
title('Sygnał po kompresji 32b');

subplot(224)
spectrogram(mp3_128, hanning(1024),1000,[],fpm_128,'yaxis')
title('Sygnał po kompresji 128b');

