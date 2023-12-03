%% Parameters
f0 = 1000; % Distributed load value, unit (N/m)
L = 1; % Length of the beam, unit (m)

%% Specifying the interval number for n = 10
n = 10;

% Creating a vector which has equally spaced points between 0 and L
% Number of intervals = n
x = linspace(0,L,n);

% Calculating moment values in points defined by vector (array) x
Mx = (0.5*f0*L^2)*(-((x/L).^2) + (x/L));

% Plotting the graph
figure(1);
plot(x, Mx, 'r-o');
xlabel('x (m)');
ylabel('M(x) (Nm)');
title('Moment M(x) distribution in beam');
legend('Number of intervals = 10');


%% Specifying the interval number for n = 100
n = 100;

% Creating a vector which has equally spaced points between 0 and L
% Number of intervals = n
x = linspace(0,L,n);

% Calculating moment values in points defined by vector (array) x
Mx = (0.5*f0*L^2)*(-((x/L).^2) + (x/L));

% Plotting the graph
figure(2);
plot(x, Mx, 'b-*')
xlabel('x (m)')
ylabel('M(x) (Nm)');
title('Moment M(x) distribution in beam');
legend('Number of intervals = 100');