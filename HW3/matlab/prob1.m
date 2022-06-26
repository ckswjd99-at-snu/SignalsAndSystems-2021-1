%% 1
clearvars();

%% 1.(a)
L = 1000;
dt = 1/L;
t = 0:dt:1;
f_clean = sin(2*pi*50*t) + sin(2*pi*120*t);
period = lcm(50, 120);
F_clean = fft(f_clean);
plot(0:L/2, abs(F_clean(1:L/2+1)));

%%
f_noise = f_clean + 2.5 * randn(size(t));
plot(t, f_clean);
hold on;
plot(t, f_noise);
hold off;
title('Clean Signal vs. Corrupted Signal')
xlabel('t (second)')
ylabel('Signal')

%% 1.(b)
F_noise = fft(f_noise);
F_noise_even = abs(F_noise(1:L/2+1));
F_noise_even(2:end-1) = 2 * F_noise_even(2:end-1);
plot(0:L/2, F_noise_even);

%%
F_noise_even = F_noise_even/L;
plot(0:L/2, F_noise_even);
title('Amplitude Spectrum of Corrupted Signal')
xlabel('f (Hz)')
ylabel('Amplitude')

%% 1.(c)
filter = (abs(F_noise) > L/2 * 0.8);
F_filtered = F_noise .* filter;
plot(0:L/2, abs(F_filtered(1:L/2+1)));

%%
f_restored = ifft(F_filtered);
plot(t, f_restored);

title('Restored Signal')
xlabel('t (second)')
ylabel('Signal')
