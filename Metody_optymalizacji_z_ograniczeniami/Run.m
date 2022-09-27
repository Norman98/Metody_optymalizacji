clc
clear all
close all

funkcja_celu = @(x) (x(1)+1).^2 + (x(2)+1).^2 + 1;
% ograniczenia nierównościowe A*x <= b
A = [1,1;-1,0];
b = [2;0];
% ograniczenia równościowe Aeq*x = beq
Aeq = [1,1];
beq = 1;
% pozostałe parametry
a = 5;                % wartości początkowe współczyników a,u
u = 0.1;              %
x0 = [1,0];     % punkt startowy optymalizacji
eps = 1e-4;           % rządana szacunkowa dokładność wyniku (xmin)
wsp1 = 1.5;           % współczynnik przez jaki mnożymy 'a' przy kolejnej minimalizacji
wsp2 = 0.5;           % współczynnik przez jaki dzielimy 'u' przy kolejnej minimalizacji
zakres = [-3,3];      % przedział wizualizacji 
warstwy = 50;         % ilość linii konturu 3D

[x,fval] = minimalizacja(eps,wsp1,wsp2,x0,funkcja_celu,A,b,Aeq,beq,a,u)

[x,fval] = fmincon(funkcja_celu,x0,A,b,Aeq,beq,[],[])
