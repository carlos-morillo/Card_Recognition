% ¿Que hace esta funcion?
% Se encarga de analizar cada carta individualmente para dar el valor del
% naipe
% 
% Explicacion del proceso:
%   1- Orienta la carta
%   2- Recorta la carta 
%   3- Se invierten los colores
%   4- Se extraen las propiedades de las figuras de la carta
%   5- Se eliminan de la lista las figuras de areas reducidas
%   6- Comprueba si se trata de una figura
%   7- Se comparan las formas para obtener las figuras y se obtienen los
%   valores de la carta


function carta=analizarCarta(im_preprocesada,propiedades,n)
global todo
%% 1:
    [im_orientada,propiedades_corregidas]=orientarCarta(im_preprocesada,propiedades);

%% 2:
    % 'x','y' son las relaciones entre las coordenadas centrales de la carta y
    % las coordenadas laterales que se necesitan
    x=80;
    y=round(x/54*91);
    % 'w' es el ancho de la carta y 'h' es la altura de la misma
    w=155;
    h=round(w/105*184);
    im_cortada=imcrop(im_orientada,[propiedades_corregidas.Centroid(1)-x,...
                        propiedades_corregidas.Centroid(2)-y,w,h]);

%% 3:
    im_cortada=~im_cortada;

    switch n
        case 1
            axes(todo.axes3)
            set(todo.axes3,'Visible','on')
        case 2
            axes(todo.axes4)
            set(todo.axes4,'Visible','on')
        case 3
            axes(todo.axes5)
            set(todo.axes5,'Visible','on')
        case 4
            axes(todo.axes6)
            set(todo.axes6,'Visible','on')
    end
    imshow(im_cortada);
    hold on

%% 4:
    % Extrae las propiedades
    propiedades_intrinsecas=propiedadesCartas(im_cortada);
    [N,~]=size(propiedades_intrinsecas);
    % Realiza un cálculo de las areas para posteriormente eliminar ruido no
    % deseado
    for i=1:N 
        vector_areas(i)=propiedades_intrinsecas(i).FilledArea;
    end
    media_areas=max(vector_areas)/1.5;
    
%% 5:
    % Busca las figuras del tamaño deseado en la imagen
    s=[propiedades_intrinsecas.FilledArea]<(media_areas);
    % Las propiedades de las figuras no deseadas se eliminan en sentido 
    % contrario para no superponer datos
    propiedades_intrinsecas(s)=[];

%% 6:
    % Comprueba si se trata de una figura comparando el FillArea (en las 
    % figuras es mucho mayor)
    [area,~]= max([propiedades_intrinsecas.FilledArea]);
    if (area > 1500||area<900)
        carta=analizarFigura(im_orientada,propiedades_corregidas,propiedades);
    else  
%% 7:
        % Se calcula el numero de la carta
        [N,~]=size(propiedades_intrinsecas);
        % Se asigna la etiqueta y el valor de la carta para la variable de
        % salida
        etiqueta1='valor';
        valor1=N;
        % Se obtiene el palo correspondiente
        etiqueta2='palo';
        valor2=extraerPalo(im_cortada,propiedades_intrinsecas);
        % Se contruye la variable de salida
        carta=struct(etiqueta1,valor1,etiqueta2,valor2);
        for i=1:N
            rectangle('position',propiedades_intrinsecas(i).BoundingBox,'edgecolor','r','linewidth',1);
        end 
    end
    
function [im_orientada,propiedades_corregidas]=orientarCarta(im_preprocesada,propiedades)
% Se extrae la carta que se está analizando en este momento
    im_cortada=imcrop(im_preprocesada,propiedades.BoundingBox);
% Se rota la imagen obtenida para posicionar la carta correctamente
    im_orientada=imrotate(im_cortada,-(90+propiedades.Orientation),'loose');
% Se extrae de nuevo las propiedades de la carta dado que sus coordenadas
% han cambiado tras la rotacion
    propiedades_corregidas=propiedadesCartas(im_orientada);
% Si de la imagen viene algun fragmento de otra carta o del entorno no
% deseado se filtra a continuacion eliminando las propiedades de dicho
% fragmento, que siempre será menor que la carta que se analiza
    % Busca las figuras del tamaño deseado en la imagen
    area_maxima=propiedades_corregidas(1).FilledArea;
    for i=1:size(propiedades_corregidas,1)
        if(propiedades_corregidas(i).FilledArea>area_maxima)
            area_maxima=propiedades_corregidas(i).FilledArea;
        end
    end
    v=[propiedades_corregidas.FilledArea]< area_maxima;
    % Las propiedades de las figuras no deseadas se eliminan en sentido 
    % contrario para no superponer datos
    propiedades_corregidas(v)=[];
        
        
        
        
        
