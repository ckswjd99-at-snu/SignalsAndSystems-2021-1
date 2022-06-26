%% Signals And System HW 2 %%
%% 1.(a)
clearvars();

a = [2, 1];
b = [0, 1];
t = [-9:10];
x = [zeros(1, length(t)/2-1) ones(1, length(t)/2+1)];
y = lsim(b, a, x, t);

plot(t, y)

%% 1.(b)
subplot(2, 1, 1);
step(tf(b, a));

subplot(2, 1, 2);
impulse(tf(b, a));

%% 2.(b)
clearvars();

T1 = 0.25;
T = 1;

t = -0.5:0.01:0.5;
f = zeros(1, length(t));
for i = 1:length(t)
    if abs(t(i)) < T1
        f(i) = 1;
    end
end

subplot(1, 1, 1);
plot(t, f);

%% 2.(d)
clearvars();

T1 = 0.25;
T = 1;
f0 = 1/T;

t = -0.5:0.01:0.5;
f = zeros(1, length(t));

N = 5;
a = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
end

for k = -N:N
    f = f + a(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f)

%% 2.(e) - x_25(t)
clearvars();

T1 = 0.25;
T = 1;
f0 = 1/T;

dt = 0.001
t = -0.5:dt:0.5;
f = zeros(1, length(t));

N = 25;
a = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
end

for k = -N:N
    f = f + a(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f);

%% 2.(e) - x_125(t)
dt = 0.002
t = -0.5:dt:0.5;
f = zeros(1, length(t));

N = 125;
a = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
end

for k = -N:N
    f = f + a(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f);

%% 2.(g) - s_5(t)
clearvars();

T1 = 0.25;
T = 1;
f0 = 1/T;

dt = 0.001
t = -0.5:dt:0.5;
f = zeros(1, length(t));

N = 5;
a = zeros(1, 2*N+1);
s = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
    s(i) = sinc((i-N-1)/(N+1));
end

for k = -N:N
    f = f + a(k+N+1)*s(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f);

%% 2.(g) - s_25(t)
dt = 0.0005
t = -0.5:dt:0.5;
f = zeros(1, length(t));

N = 25;
a = zeros(1, 2*N+1);
s = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
    s(i) = sinc((i-N-1)/(N+1));
end

for k = -N:N
    f = f + a(k+N+1)*s(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f)

%% 2.(g) - s_125(t)
dt = 0.0005
t = -0.5:dt:0.5;
f = zeros(1, length(t));

N = 125;
a = zeros(1, 2*N+1);
s = zeros(1, 2*N+1);
for i = 1:length(a)
    a(i) = sinc((i-N-1)/2)/2;
    s(i) = sinc((i-N-1)/(N+1));
end

for k = -N:N
    f = f + a(k+N+1)*s(k+N+1)*exp(j*2*pi*f0*k*t);
end

plot(t, f)


