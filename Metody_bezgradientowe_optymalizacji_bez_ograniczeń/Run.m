clc
clear all
close all 

 funkcja_celu = @(x0) 2*x0(1).^2 + x0(2).^2 - 2*x0(1).*x0(2);                        % przykładowa funkcja
% funkcja_celu = @(x) (x(2)-x(1).^2).^2 + (1-x(1)).^2;                                % funkcja RosenBrocka 

% pozostałe parametry:
x0 = [2,3];    % punkt startowy
eps = 10^-4;   % rządana dokładność wyniku
eps1 = 10^-7;   % dokładność minimalizacji kierunkowej
zakres = [-4,4];      % przedział wizualizacji 
warstwy = 50;         % ilość linii konturu 2D

[H,x,min] = Gauss_Seidl(funkcja_celu, x0, eps,eps1);     % wywołanie funkcji Gauss_Seidl dla naszych przyjętych wartości parametrów

figure(1)
kontur2D(funkcja_celu,zakres,warstwy);                % rysuj kontur2D

hold;                                                  % nałóż na kontur przebieg minimalizacji 
plot(H(:,1),H(:,2),'r--','LineWidth',1.2);
plot(H(end,1),H(end,2),'ro','MarkerFaceColor',[1,0,0]);
title('przebieg minimalizacji metodą Gaussa Seidla')

[H,x,min] = Powell(funkcja_celu, x0, eps,eps1);     % wywołanie funkcji gradient dla naszych przyjętych wartości parametrów

figure(2)
kontur2D(funkcja_celu,zakres,warstwy);                % rysuj kontur2D

hold;                                                  % nałóż na kontur przebieg minimalizacji
plot(H(:,1),H(:,2),'r--','LineWidth',1.2);
plot(H(end,1),H(end,2),'ro','MarkerFaceColor',[1,0,0]);
title('przebieg minimalizacji metodą Powella')

disp(newline + "Porównanie z funkcją fminsearch:")

options = optimset('TolFun',eps,'Display','iter','TolX',1);

[x,fval] = fminsearch(funkcja_celu,x0,options)

