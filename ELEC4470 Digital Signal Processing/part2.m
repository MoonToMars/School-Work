% ========================================================================
% Part 2-1
% ========================================================================
n = -2:6;
x = [1:4, 7:-1:5, 2, 1]; 

[x11, n11] = DiscreteTimeSequences.timeshift(x, n, 3);
[x12, n12] = DiscreteTimeSequences.timeshift(x, n, -5);

[y1, n1] = DiscreteTimeSequences.add_seq(2*x11, n11, -4*x12, n12);

figure(1)
subplot(2, 2, 1);
stem(n, x, "filled");
xlabel("n")
ylabel("x(n)")

subplot(2, 2, 2);
stem(n11, x11, "filled");
xlabel("n11")
ylabel("x11(n)")

subplot(2, 2, 3);
stem(n12, x12, "filled");
xlabel("n12")
ylabel("x12(n)")

subplot(2, 2, 4);
stem(n1, y1, "filled");
xlabel("n1")
ylabel("y1(n)")

exportgraphics(gcf, "image-results/part2_1.png")
% ========================================================================
% Part 2-2
% ========================================================================
n = -2:6;
x = [1:4,7:-1:5,2,1];

[y22,n22] = DiscreteTimeSequences.timeshift(y1,n1,1);
[y2,n2] = DiscreteTimeSequences.mult_seq(x,n,y22,n22);

figure(2)
subplot(1,2,1);
stem(n1,y1);
xlabel("n1")
ylabel("y1(n)")

subplot(1,2,2);
stem(n2,y2);
xlabel("n2")
ylabel("y2(n)")

exportgraphics(gcf, "image-results/part2_2.png")
% ========================================================================
