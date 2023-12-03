function point = fourth(a,b,c,d,e)
t = linspace(0,1,101)';
oneColumn = ones([101,1]);
x = [t.^4 t.^3 t.^2 t oneColumn]*[1 -4 6 -4 1; -4 12 -12 4 0; 6 -12 6 0 0; -4 4 0 0 0; 1 0 0 0 0]*[a(1); b(1); c(1); d(1); e(1)];
y = [t.^4 t.^3 t.^2 t oneColumn]*[1 -4 6 -4 1; -4 12 -12 4 0; 6 -12 6 0 0; -4 4 0 0 0; 1 0 0 0 0]*[a(2); b(2); c(2); d(2); e(2)];
plot(x,y, 'k-', 'LineWidth', 2);
axis equal
end
