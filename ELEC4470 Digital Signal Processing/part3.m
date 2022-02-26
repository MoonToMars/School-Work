nx = [-2:2];
x = [1, 2, 3, 2, 1];
nh = [0:4];
h = ones(1, 4);

[n, y] = DiscreteTimeSequences.conv_lab_1(nx, x, nh, h);

figure(1)
stem(n, y, "filled")
title("Convolution Result")
xlabel("n")
ylabel("y(n)")

exportgraphics(gcf, "image-results/part3.png")