function second(a,b,c)
t = linspace(0,1,101)';
oneColumn = ones([101,1]);
x = [t.^2 t oneColumn]*[1 -2 1; -2 2 0; 1 0 0]*[a(1); b(1); c(1)];
y = [t.^2 t oneColumn]*[1 -2 1; -2 2 0; 1 0 0]*[a(2); b(2); c(2)];
plot(x,y, 'k-', 'LineWidth', 2);
axis equal
end

