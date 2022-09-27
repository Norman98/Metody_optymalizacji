clc
clear all
close all 

%  funkcja_celu = @(x0) 2*x0(1).^2 + x0(2).^2 - 2*x0(1).*x0(2);                        % funkcja testowa
%  gradient = @(x0) [4*x0(1) - 2*x0(2)  , 2*x0(2) - 2*x0(1)];                          % gradnient funkcji celu
 
 funkcja_celu = @(x) (x(2)-x(1).^2).^2 + (1-x(1)).^2;                                  % funkcja RosenBrocka   
 gradient = @(x) [-4*x(1).*x(2) + 4*x(1).^3-2+ 2*x(1), 2*x(2)-2*x(1).^2];              % gradient funkcji celu
 
%  funkcja_celu = @(x0) 2*x0(1)^2 + x0(2)^2 - 2*x0(1)*x0(2)+ 4*sin(x0(1));             % inna funkcja testowa
%  gradient = @(x0) [4*x0(1) - 2*x0(2) + 4*cos(x0(1)) , 2*x0(2) - 2*x0(1) ];           % gradnient funkcji celu

% pozostałe parametry:
x0 = [-2,2];    % punkt startowy
e = 2;         % długość kroku e
a = 0.5;       % współczynnik redukcji a
k = 10;        % limit kroków redukcji k
eps = 10^-4;   % rządana dokładność wyniku
zakres = [-3,3];      % przedział wizualizacji 
warstwy = 50;         % ilość linii konturu 3D

[H,x,min] = gradient_prosty(funkcja_celu,gradient, x0, e, a, k, eps);     % wywołanie funkcji gradient dla naszych przyjętych wartości parametrów

figure(1)
kontur3D(funkcja_celu,zakres,warstwy);                % rysuj kontur3D

hold;                                                  % nałóż na kontur przebieg minimalizacji gradientem prostym
plot3(H(:,1),H(:,2),H(:,3),'r--','LineWidth',1.2);
plot3(H(end,1),H(end,2),H(end,3),'ro','MarkerFaceColor',[1,0,0]);
grid on
title('przebieg minimalizacji algorytmem gradientu prostego')

[H,x,min] = najszybszy_spadek(funkcja_celu,gradient, x0, eps);     % wywołanie funkcji gradient dla naszych przyjętych wartości parametrów

figure(2)
kontur3D(funkcja_celu,zakres,warstwy);                % rysuj kontur3D

hold;                                                  % nałóż na kontur przebieg minimalizacji algorytmem najszybszego spadku
plot3(H(:,1),H(:,2),H(:,3),'r--','LineWidth',1.2);
plot3(H(end,1),H(end,2),H(end,3),'ro','MarkerFaceColor',[1,0,0]);
grid on
title('przebieg minimalizacji algorytmem najszybszego spadku')

disp(newline + "Porównanie z funkcją fminsearch:")
options = optimset('Display','iter');

[x,fval] = fminunc(funkcja_celu,x0,options)