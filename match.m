
% Modified Version by Carlos Morillo Lozano - 11/01/2016

function puntosMatch= match(umbral,des1,des2,loc1,loc2)

distRatio = umbral;   

% Para cada descriptor de la primera imagen se casa con el correspondiente
% de la segunda
des2t = des2';                          
for i = 1 : size(des1,1)
   dotprods = des1(i,:) * des2t;        
   [vals,indx] = sort(acos(dotprods));  

   if (vals(1) < distRatio * vals(2))
      match(i) = indx(1);
   else
      match(i) = 0;
   end
end


%GENERA LA MATRIZ DE RESULTADOS
%Por filas los puntos casados
%Por columnas (x,y) primera imagen, (x,y) segunda imagen

%Numero de puntos casados
num = sum(match > 0);
puntosMatch=zeros(num,4);
indice=1;

%Bucle para cada caracteristica encontrada
for i = 1: size(des1,1)
    %Caracteristica casada
    if (match(i) > 0)
        puntosMatch(indice,1)=loc1(i,1);
        puntosMatch(indice,2)=loc1(i,2);
        puntosMatch(indice,3)=loc2(match(i),1);
        puntosMatch(indice,4)=loc2(match(i),2);
        indice=indice+1;
    end
end



        