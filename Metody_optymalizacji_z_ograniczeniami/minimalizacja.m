function [xmin,ymin]= minimalizacja(eps,wsp1,wsp2,x0,funkcja_celu,A,b,Aeq,beq,a,u)
    iteracja = 1;
    y0 = funkcja_celu(x0);
    
    while true
        H(iteracja,:,:,:,:) = [x0,y0,a,u];
        iteracja = iteracja+1;
      
        funkcja_celu2 = @(x) con2unc(x,funkcja_celu,A,b,Aeq,beq,a,u);
        [x,fval] = fminunc(funkcja_celu2,x0);
         a = a*wsp1;     % zmiana wartości współczynników funkcji kary przy kolejnym wykonaniu minimalizacji
         u = u*wsp2;
        if norm(x0-x) < eps
            xmin = x0;
            ymin = y0;
            break
        else
            y0 = fval;
            x0 = x;
        end
    end
    
    disp('    iteracja       x1         x2           y           a          u')                  
    disp('------------------------------------------------------------------------')
        for i = 1 :size(H,1)                                           % printowanie iteracji

        linia = ['       ',num2str(i-1),'       ',num2str(H(i,:,:,:,:,:),'%12.3e')];
        disp(linia);
        end
end