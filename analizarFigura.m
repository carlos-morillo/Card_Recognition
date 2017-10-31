% ¿Que hace esta funcion?
% Se encarga de analizar cada FIGURA individualmente para dar el valor del
% naipe
% 
% Etapas:
%  >Modo de deteccion del palo CON sift:
%   1: Correlacion mediante sift
%  >Modo de deteccion del palo SIN sift:
%   2: Se recorta la parte de la carta con la informacion del palo
%   3: Se elimina todo el ruido posible para aislar el palo del resto de la
%       carta
%   4: Se extraen las propiedades del palo
%   5: Se elimina todo menos la imagen del palo en sí
%   6: Asignacion del palo correspondiente



function carta=analizarFigura(im_orientada,propiedades_corregidas,propiedades)
global todo

estado=get(todo.checkbox1,'Value'); % '0' --> deteccion por sift / '1' --> deteccion SIN sift
%% 1:
    % Se asigna la etiqueta y el valor de la carta para la variable de
    % salida
    etiqueta1='valor';
    [valor1,valor2]=extraerFigura(getIm_inicial,propiedades);

if (estado==0 && valor1~=1 && valor1~=400)
%% 2:
    % 'x','y' son las relaciones entre las coordenadas centrales de la carta y
    % las coordenadas laterales que se necesitan
    x=76;
    y=round(x/54*91);
    % 'w' es el ancho de la carta y 'h' es la altura de la misma
    w=47;
    h=round(w/47*61);
    im_palo=imcrop(im_orientada,[propiedades_corregidas.Centroid(1)-x,...
                        propiedades_corregidas.Centroid(2)-y,w,h]);
%% 3:
    % Transformaciones para eliminar el ruido que rodea al palo en la
    % imagen
    im_palo=not(im_palo);
    SE=strel('square',2);
    im_palo=imopen(im_palo,SE);
    im_palo=imclose(im_palo,SE);
    im_palo=bwareaopen(im_palo,20);
    im_palo=imerode(im_palo,SE);

%% 4:
    % Se extraen las propiedades de la imagen del palo         
    propiedades_intrinsecas=propiedadesCartas(im_palo);

%% 5:
    % Se eliminan las caracteristicas no deseadas que faltaban tras las
    % transfomraciones
    area_maxima=propiedades_intrinsecas(1).FilledArea;
    for i=1:size(propiedades_intrinsecas,1)
        if(propiedades_intrinsecas(i).FilledArea>area_maxima)
            area_maxima=propiedades_intrinsecas(i).FilledArea;
        end
    end
    v=[propiedades_intrinsecas.FilledArea]< area_maxima;
    propiedades_intrinsecas(v)=[];
  

%% 6:
    % Se obtiene el palo correspondiente
    valor2=extraerPalo(im_palo,propiedades_intrinsecas);
end
    etiqueta2='palo';
    % Se contruye la variable de salida
    carta=struct(etiqueta1,valor1,etiqueta2,valor2);
        
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        