%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1
% 
% [Directions]
% 1. Please read the problem specified in the .pdf file.
% 2. Replace 'PLEASE_FILL' with appropriate functions, strings, numbers.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars();

%% 1-a,b
filename = 'loveSeongGeun.mp3';
[y, Fs] = audioread(filename);
sound(y, Fs, 16);

%% 1-c
y_resamp_1 = resample(y, round(Fs / 2), Fs);
sound(y_resamp_1, round(Fs / 2), 16);

%% 1-d
y_resamp_2 = resample(y, round(Fs / 8), Fs);
sound(y_resamp_2, round(Fs / 8), 16);
