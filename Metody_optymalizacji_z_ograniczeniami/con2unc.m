% zamiana problemu optymalizacji z ograniczeniami na problem optymalizacji
% bez ograniczeń za pomocą metody funkcji kary
% ograniczenie nierównościowe:  A*x <= b
% ograniczenie równościowe:     Aeq*x = beq
% 'a' - parametr zewnętrznej funkcji kary ; min_f(x) + P(x)
% 'u' - parametr wewnętrznej funkcji kary ; min_f(x) +uK(X)

function [y] = con2unc(x,funkcja_celu,A,b,Aeq,beq,a,u)
    if isempty(A | b | u)
        kara_noneq = 0;
    else
        kara_noneq =  sum(log(-(sum( x.*A,2)-b)));   % wewnętrzna funkcja kary (funkcja logarytmiczna)
    end
    if isempty(Aeq | beq | a)
        kara_eq = 0;
    else
        kara_eq = sum(a*(sum(x.*Aeq,2) - beq).^2);     % zewnętrzna funkcja kary (norma L_2)
    end
    y = funkcja_celu(x) + kara_eq + u*kara_noneq;
end
