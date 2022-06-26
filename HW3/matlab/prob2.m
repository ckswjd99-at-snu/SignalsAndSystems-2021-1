%% 2
clearvars();
load data.mat

%% 2.(a)
z = [dash dash dot dot];
plot(t, z);

%% 2.(b)
freqs(bf, af);
% it's like low-pass filter, allowing about f<10^2.

%% 2.(c)
ydash = lsim(bf, af, dash, t(1:length(dash)));
ydot = lsim(bf, af, dot, t(1:length(dot)));

figure, hold on;
plot(dash), plot(ydash), title('dash & ydash');
hold off;
figure, hold on;
plot(dot), plot(ydot), title('dot & ydot');
hold off;

% as dash and dot lies roughly within the passband of lowpass filter,
% no specific change occurs for their figures.

%% 2.(d)
y = dash.*cos(2*pi*f1*t(1:length(dash)));
yo = lsim(bf, af, y, t(1:length(dash)));
hold on;
plot(y), plot(yo);
title('y & yo');
hold off;

% frequency 200 is out of passband of the filter,
% so it shrinks dramatically.

%% 2.(e)

%% 2.(f)
x1 = x.*cos(2*pi*f1*t);
y1 = lsim(bf, af, x1, t(1:length(x1)));
plot(y1); % dash-dot-dot: m1 is D

%% 2.(g)
x2 = x.*sin(2*pi*f1*t);
y2 = lsim(bf, af, x2, t(1:length(x2)));
plot(y2); % dot-dash-dash-dot: m3 is P

%%
x3 = x.*cos(2*pi*f2*t);
y3 = lsim(bf, af, x3, t(1:length(x3)));
plot(y3); % no such signal!

%%
x4 = x.*sin(2*pi*f2*t);
y4 = lsim(bf, af, x4, t(1:length(x4)));
plot(y4); % dot-dot-dot: m2 is S

% As a result, encrypted word is 'DSP'.

