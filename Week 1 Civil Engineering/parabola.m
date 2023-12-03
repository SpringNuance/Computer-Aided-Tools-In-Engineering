function y = parabola(a,b,c)

step = 1;
x = -10:step:10;
y = a*x.^2 + b*x + c;
plot(x,y)
