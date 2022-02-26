% Part 4-1
% ========================================================================
nx = [-2:4];
x = [1, 1, 2, 4, 3, 3, 1];
nh = [0:4];
h = [0, .5, 1, .5, 0];

[n, y] = DiscreteTimeSequences.conv_lab_1(nx, x, nh, h);

figure(1)
stem(n, y, "filled")
title("Convolution Result")
xlabel("n")
ylabel("y(n)")

exportgraphics(gcf, "image-results/part4_1.png")
% ========================================================================
% Part 4-2
% ========================================================================
nx = [-2:4];
x = [1, 1, 2, 4, 3, 3, 1];
nh = [0:4];
h = [0, .5, 1, .5, 0];

[u, nu] = DiscreteTimeSequences.dt_unitstep(0, -3, 6);

[ts_u, ts_nu] = DiscreteTimeSequences.timeshift(u, nu, -2);
[ts_x, ts_nx] = DiscreteTimeSequences.timeshift(x, nx, -2);

[r, nr] =...
    DiscreteTimeSequences.mult_seq(ts_u, ts_nu, ts_x, ts_nx);

[result, result_n] = DiscreteTimeSequences.add_seq(r, nr, h, nh);

figure(2)
stem(nr, r, "filled")
title("Equation Result")
xlabel("n")
ylabel("y(n)")

exportgraphics(gcf, "image-results/part4_2.png")
% ========================================================================

% Part 4-3
% ========================================================================
fs=1000;
t=0:1/fs:100; n=length(t);

f1=100;
f2=400;
x=cos(2*pi*f1*t)+cos(2*pi*f2*t);

figure(3)
subplot(2,1,1)
plot(t, x);
xlabel('time, s')
ylabel('Amplitude')

[X,w]=freqz(x); % freq. content of x
subplot(2,1,2)
plot(w*(fs/(2*pi)),20*log10(abs(X)));grid
xlabel('frequency, Hz')
ylabel('Amplitude')

exportgraphics(gcf, "image-results/part4_3.png")
% ========================================================================
