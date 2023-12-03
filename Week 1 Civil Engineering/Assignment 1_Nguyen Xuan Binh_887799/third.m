function point = third(a,b,c,d)
t = linspace(0,1,101)';
oneColumn = ones([101,1]);
x = [t.^3 t.^2 t oneColumn]*[-1 3 -3 1; 3 -6 3 0; -3 3 0 0; 1 0 0 0]*[a(1); b(1); c(1); d(1)];
y = [t.^3 t.^2 t oneColumn]*[-1 3 -3 1; 3 -6 3 0; -3 3 0 0; 1 0 0 0]*[a(2); b(2); c(2); d(2)];
plot(x,y, 'k-', 'LineWidth', 2);
axis equal
end

