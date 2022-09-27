function [H,x,min] = Gauss_Seidl(funkcja_celu, x0, eps,eps1)            

options = optimset('TolFun',eps1,'TolX',1);
% obliczenie wartości funckji celu w punkcie startowym
y = funkcja_celu(x0);

iteracja = 1;

H(iteracja,:,:,:) = [x0,y];    % zapisanie do historii punktu startowego

% wyznaczenie macierzy kierunków poszukiwań:

k = length(x0);        % wielkość macierzy
e_m = eye(k);             

i = 1;     % indeks wersora kierunkowego
    while true

        iteracja = iteracja + 1;       % licznik iteracji
        
      
        e = e_m(:,i)';     % aktualny wersor kierunkowy
        
            fun =  @(d) funkcja_celu(x0 + e*d);  %  parametryczne przedstawienie funkcji             
            d = fminsearch(fun,0,options);               %  minimalizacja kierunkowa
            
            x0 = x0 +e*d;                       % 3. wykonanie kroku
            y = funkcja_celu(x0);
        
        H(iteracja,:,:,:) = [x0,y];       % zapis iteracji  
        
        i = i+1;       % przejście do kolejnego wersora kierunkowego
        
        if i > k                    % gdy wszystkie kierunki zostały wykorzystane starujemy od nowa z
            i = 1;                 %  wersorami kierunkowymi zaczynając z ostatniego wyznaczonego punktu
            
            if abs(H(iteracja,3)-H(iteracja-1,3)) < eps          % warunek zakończenia (wyjście z pętli)
                break;
            end
        end
    end
    x = x0;     % punkt końcowy
    min = y;     % wartość w punkcie końcowym
    
    disp(newline + "Metoda Gaussa_Seidla:") 
    disp(newline + "    iteracja       x1         x2           y")                  
    disp('------------------------------------------------')
        for i = 1 :size(H,1)                                           % printowanie iteracji

        linia = ['       ',num2str(i-1),'       ',num2str(H(i,:,:,:),'%12.3e')];
        disp(linia);
        end
    