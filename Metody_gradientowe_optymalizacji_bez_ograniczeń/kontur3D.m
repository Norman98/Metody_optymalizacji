% Wizualizacja 3D

function wykres = kontur3D(funkcja_celu,zakres,warstwy)        % funkcja rysująca kontur

[X,Y] = meshgrid(linspace(zakres(1),zakres(2)));
Z = [100,100];

for j = 1:100
    
    for i = 1:100
        Z(i,j) = funkcja_celu([X(i,j),Y(i,j)]);
    end
end
wykres = contour3(X,Y,Z,warstwy);