function [H,x,min] = gradient_prosty(funkcja_celu,gradient, x0, e, a, k, eps)            

% 2.  obliczenie wartości funckji celu i gradientu w punkcie startowym
y = funkcja_celu(x0);
g = gradient(x0);

iteracja = 1;

H(iteracja,:,:,:) = [x0,y];    % zapisanie do historii punktu startowego

    while sqrt(g(1)^2+g(2)^2) > eps

        iteracja = iteracja +1;       % licznik iteracji

        % 3.  wyznaczenie kierunku poszukiwań
        d = -g;

        for i = 1:k
            
            % 4.  Wykonać z punktu x krok o długości e w wyznaczonym kierunku d,
            %przechodząc do punktu kolejnego
            x_nowe = x0 + e*d;

            % 5. Obliczyć wartość funkcji celu. Jeśli nowe y1(x) > poprzedniego y(x)
            % dokonać redukcji kroku (mnożąc jego wartość przez a) i ponowić próby. 
            % Po k niepomyślnych próbach zakończyć postępowanie.
            y1 = funkcja_celu(x_nowe);

            if y1 >= y             % jeśli y(x) w nowym punkcie jest większe niż było zmniejsz krok 'a' razy i sprawdź ponownie 
                e = e * a;
            else
                break;
            end

        end
        if i == k        % zakończ minimalizację gdy przekroczony zostanie limit kroków redukcji
            break;       
        end
        y = y1;
        x0 = x_nowe;
        H(iteracja,:,:,:) = [x0,y];       % zapis iteracji       
        g = gradient(x0);      
    end
    x = x0;      % punkt końcowy
    min = y;     % wartość w punkcie końcowym

    disp(newline + "Metoda gradientu prostego:")
    disp(newline + "    iteracja       x1         x2           y")                  
    disp('------------------------------------------------')
        for i = 1 :size(H,1)                                           % printowanie iteracji

        linia = ['       ',num2str(i-1),'       ',num2str(H(i,:,:,:),'%12.3e')];
        disp(linia);
        end
        