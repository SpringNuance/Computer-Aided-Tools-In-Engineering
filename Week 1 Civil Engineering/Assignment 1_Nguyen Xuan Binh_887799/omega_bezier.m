close all
clc
[dataset, labels] = xlsread('data.xlsx','Sheet1', 'A2:C13');
x = dataset(:,1);
y = dataset(:,2);

dx = 0.3; dy = 0.3; % displacement so the text does not overlay the data points
text(x+dx, y+dy, labels, 'Fontsize', 10);
axis equal
hold on;
% plot J to F second order
J = [0,4];
JF = [0,0];
F = [4,0];
second(J,JF,F);
% plot K to G second order
G = [8,0];
GK = [12,0]; % control point
K = [12,4];
second(G, GK, K);
% plot H to D second order 
H = [1,5];
HD = [2,3.5]; % control point
D = [3,1];
second(H,HD,D);
% plot I to E second order
I = [11,5];
IE = [10,3.5]; % control point
E = [9,1];
second(I,IE,E);
% plot B to F second order
B = [3,4];
BF = [4.5,2]; % control point
second(B, BF, F);
% plot C to G second order
C = [9,4];
GC = [7.5,2]; % control point
second(G, GC, C);
% plot J to D third order
JD1 = [1.5,1.5]; % control point
JD2 = [2,3]; % control point
third(J,JD1,JD2,D);
% plot K to E third order
KE2 = [10.5,1.5]; % control point
KE1 = [10,3]; % control point
third(E,KE1,KE2,K);
% plot B to C via L fourth order
L = [6,18]; % control point
BL = [1,6.5]; % control point
LC = [11,6.5]; % control point
fourth(B, BL, L, LC, C);
% plot H to I via L fourth order
A = [6,59/3]; % control point
AH = [-1, 8]; % control point
AI = [13, 8]; % control point
fourth(H, AH, A, AI, I);
array = [J; JF; F; BF; B; BL; L; LC; C; GC; G; GK; K; KE2; KE1; E; IE; I; AI; A; AH; H; HD; D; JD2; JD1; J];
a = array(:,1);
b = array(:,2);
disp(array)
plot(a,b,'r.','MarkerSize',15)
plot(a,b,'r--')
plot(x,y,'b.','MarkerSize',20)
