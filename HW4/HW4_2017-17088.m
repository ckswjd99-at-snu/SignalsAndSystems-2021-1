%% 1
clearvars();
f = -100:0.1:100;

W1 = sinc(f);
W2 = (sinc(f/2)).^2;
W3 = 1/4 * (pi*sinc(pi*(f-1)) + pi*sinc(pi*(f+1)) + 2*pi*sinc(pi*f));

figure;
subplot(311), plot(f, 20*log10(abs(W1))), title('FT of Rectangle Window'), xlabel('Freqency (Hz)'), ylabel('log Magnitude (dB)');
subplot(312), plot(f, 20*log10(abs(W2))), title('FT of Trianglar Window'), xlabel('Freqency (Hz)'), ylabel('log Magnitude (dB)');
subplot(313), plot(f, 20*log10(abs(W3))), title('FT of Hamming Window'), xlabel('Freqency (Hz)'), ylabel('log Magnitude (dB)');

figure, hold on;
plot(f, 20*log10(abs(W1)));
plot(f, 20*log10(abs(W2)));
plot(f, 20*log10(abs(W3)));
title('FT of Hamming Window'), xlabel('Freqency (Hz)'), ylabel('log Magnitude (dB)');
legend('Rect', 'Triangle', 'Hamming');
hold off;


%% 2.(d)
clearvars();
[y, Fs] = audioread('Yeah.mp3');
player = audioplayer(y, Fs);
play(player);

music_SPEC = spectrogram(y(:,1), 128, 120, 'yaxis');

figure, spectrogram(y(:,1), 128, 120, [], Fs, 'yaxis');

%% 2.(f)
L = length(y(:,1))/Fs;
music_FT = stft(y(:,1), Fs, 'Window', hamming(128),'OverlapLength', 120);
t = (1:1:length(music_FT))/length(music_FT)*L;
f = (1:1:length(music_FT))/length(music_FT)*Fs/2000;
figure, imagesc(abs(music_FT), 'XData', t, 'YData', f), colorbar;
figure, imagesc((20*log(abs(music_FT(65:128,:)))/log(10)), 'XData', t, 'YData', f), colorbar, set(gca, 'YDir', 'normal');
xlabel('Time (s)');
ylabel('Frequency (Hz)');

%% 3
clearvars();

filename = 'Carbo.JPG';
A = imread(filename);
B = im2gray(A); % Convert A to a grayscale image
figure(1), imshow(B), title('original image');
keep = [0.1, 0.05, 0.01, 0.002, 0.0005, 0.0001, 0.00005, 0.00001]; % Float value specifying amount of frequencies to keep
error=zeros(size(keep));

% FFT Compression
Bt = fft2(B); % Bt is the FFT of B
Btsort = sort(abs(Bt(:)));  % Sort by magnitude

for i=1:length(keep)
    thresh = Btsort(floor((1-keep(i))*length(Btsort)));  % threshold on frequencies
    ind = abs(Bt)>thresh;      % Find small indices
    Btlow = Bt.*ind;           % Threshold small indices
    Blow=uint8(ifft2(Btlow));  % Inverse Fourier transform
    figure(2), subplot(2,4,i);
    imshow(Blow)      % Display the resulting image
    title(sprintf('used only %.4f percent of spectrum', keep(i)*100));
    error(i)=mean(abs(Blow(:)-B(:)));
end

figure(3), plot(keep, error);
xlabel('ratio of Fourier coefficients used');
ylabel('MSE');