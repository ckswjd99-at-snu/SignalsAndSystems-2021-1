%% 4.(a) %%
clearvars();

n = 0:9;
x1 = sin(2*pi*1/5*n);
x2 = sin(2*pi*2/5*n);
x4 = sin(2*pi*4/5*n);
x6 = sin(2*pi*6/5*n);

subplot(2, 2, 1);
stem(n, x1);

subplot(2, 2, 2);
stem(n, x2);

subplot(2, 2, 3);
stem(n, x4);

subplot(2, 2, 4);
stem(n, x6);


%% 4.(b) %%
clearvars();

h = [0, 0, 0, 0, 2, 0, -2, 0, 0, 0, 0];
nh = -5:5;

x = [0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0];
nx = -5:5;

subplot(2, 1, 1);
stem(nh, h);

subplot(2, 1, 2);
stem(nx, x);


%% 4.(c) %%
clearvars();

h = [0, 0, 0, 0, 2, 0, -2, 0, 0, 0, 0];
nh = -5:5;

x = [0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0];
nx = -5:5;

y = conv(h, x);
ny = -10:10;

stem(ny, y);










