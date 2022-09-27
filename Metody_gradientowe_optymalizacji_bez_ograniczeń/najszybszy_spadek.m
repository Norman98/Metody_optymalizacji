function [H,x,min] = najszybszy_spadek(funkcja_celu,gradient, x0, eps)            

% 2. obliczenie wartości funckji celu i gradientu w punkcie startowym
y = funkcja_celu(x0);
g = gradient(x0);

iteracja = 1;

H(iteracja,:,:,:) = [x0,y];    % zapisanie do historii punktu startowego

    while sqrt(g(1)^2+g(2)^2) > eps

        iteracja = iteracja +1;       % licznik iteracji

        % 3.  wyznaczenie kierunku poszukiwań
        d = -g;

            
            fun =  @(e) funkcja_celu(x0 + e*d);  %  linia kierunkowa             
            e = fminsearch(fun,0);               % minimalizacja kierunkowa
            
            x0 = x0 +e*d;
            y = funkcja_celu(x0);
        
        H(iteracja,:,:,:) = [x0,y];      % zapis iteracji       
        g = gradient(x0);
    end
    x = x0;      % punkt końcowy
    min = y;     % wartość w punkcie końcowym
    
    disp(newline + "Metoda najszybszego spadku:")
    disp(newline + "    iteracja       x1         x2           y")                  
    disp('------------------------------------------------')
        for i = 1 :size(H,1)                                           % printowanie iteracji

        linia = ['       ',num2str(i-1),'       ',num2str(H(i,:,:,:),'%12.3e')];
        disp(linia);
        end

    