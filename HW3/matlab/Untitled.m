%% 1
clearvars();
unCox = 100e-6;
WperL = 1000;
Vth = 0.4;
Ran = 90;

Ron = Ran/9;
Vgs = Vth + 1/(unCox * WperL * Ron);

%% 3
clearvars();
Vdd = 2.2;
Vgs = 1;
unCox = 100e-6;
WperL = 2/0.18;
Vth = 0.4;

Vds = Vgs-Vth;

Id = 0.5 * unCox * WperL * (Vgs - Vth)^2;
Rd = (Vdd - Vds)/Id;

%% 4
clearvars();
Vs = 0.6;
Vg = 1.3;
Vd = 1.3;
Vgs = Vg-Vs;
Vds = Vd-Vs;
unCox = 100e-6;
WperL = 50;
Vth0 = 0.5;
lamda = 0.1;
v = 0.4;
phiF = 0.4;

Vth = Vth0 + v * (sqrt(2*phiF+Vs)-sqrt(2*phiF));

Id = 0.5 * unCox * WperL * (Vgs- Vth)^2 * (1 + lamda*Vds);
Id * 1e6

%% 5
clearvars();
Id = 2.3e-3;
unCox = 100e-6;
WperL = 20;
lamda = 0.1;

gm = sqrt(2*unCox*WperL*Id);
ro = 1/lamda/Id;

ans = gm*1e3+ro*1e-3;


