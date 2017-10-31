% ¿Que hace esta funcion?
% Funcion auxiliar para reajustar el tamaño de los descriptores y poder
% hacer la correlacion entre ellos

function [correlacion,descript_plantilla,descript_reales]=ajustarTamano(descript_plantilla,descript_reales)
    size_plantilla=size(descript_plantilla,1)
    size_reales=size(descript_reales,1)
   % Se reajusta la variable mas grande a la mas pequeña:
    if size_plantilla > size_reales
        for i=size_plantilla:-1:size_reales+1
            descript_plantilla(i,:)=[];
        end
    else if size_plantilla < size_reales
        for i=size_reales:-1:size_plantilla+1
            descript_reales(i,:)=[];
        end
        end
    end
    size_plantilla=size(descript_plantilla,1)
    size_reales=size(descript_reales,1)
    correlacion= corr2(descript_plantilla,descript_reales);