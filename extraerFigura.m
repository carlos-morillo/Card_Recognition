% ¿Que hace esta funcion?
% Se encarga de comparar mediante sift todas las figuras con plantillas
% previamente seleccionadas de cada figura de la baraja
% 
%   Etapas
%   1: Se recorta la zona de la carta
%   2: Se guarda la carta en memoria para el posterior procesado de sift
%   3: Se almacenan los descriptores y las localizaciones mediante sift
%   4: Se cargan los descriptores y localizadores de todas las plantillas
%   5: Se comparan las plantillas con la muestra uniendo los descriptores
%       de cada imagen
%   6: Se asigna un valor a la carta en funcion del grado de correlacion
%       entre los diferentes análisis


function [letra,palo]=extraerFigura(im_inicial,propiedades)
%% 1: 
    im_cortada=imcrop(im_inicial,propiedades.BoundingBox);

%% 2:
    imwrite(im_cortada,'C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\Datos\Muestra.jpg');

%% 3:
    [~,descriptores_muestra,locs_muestra]=sift('C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\Datos\Muestra.jpg');
    
%% 4:
    load sota.mat
    load rey.mat
    load reina.mat
    load joker.mat

%% 5:
    umbral=0.8;
    % Comparacion de J:
    puntos_J_C=size(match(umbral,descript_J_C,descriptores_muestra,locs_J_C,locs_muestra),1);
    puntos_J_P=size(match(umbral,descript_J_P,descriptores_muestra,locs_J_P,locs_muestra),1);
    puntos_J_T=size(match(umbral,descript_J_T,descriptores_muestra,locs_J_T,locs_muestra),1);
    puntos_J_R=size(match(umbral,descript_J_R,descriptores_muestra,locs_J_R,locs_muestra),1);
    % Comparacion de Q:
    puntos_Q_C=size(match(umbral,descript_Q_C,descriptores_muestra,locs_Q_C,locs_muestra),1);
    puntos_Q_P=size(match(umbral,descript_Q_P,descriptores_muestra,locs_Q_P,locs_muestra),1);
    puntos_Q_T=size(match(umbral,descript_Q_T,descriptores_muestra,locs_Q_T,locs_muestra),1);
    puntos_Q_R=size(match(umbral,descript_Q_R,descriptores_muestra,locs_Q_R,locs_muestra),1);
    % Comparacion de K:
    puntos_K_C=size(match(umbral,descript_K_C,descriptores_muestra,locs_K_C,locs_muestra),1);
    puntos_K_P=size(match(umbral,descript_K_P,descriptores_muestra,locs_K_P,locs_muestra),1);
    puntos_K_T=size(match(umbral,descript_K_T,descriptores_muestra,locs_K_T,locs_muestra),1);
    puntos_K_R=size(match(umbral,descript_K_R,descriptores_muestra,locs_K_R,locs_muestra),1);
     % Comparacion de AS:
    puntos_A_P=size(match(umbral,descript_A_P,descriptores_muestra,locs_A_P,locs_muestra),1);
     % Comparacion de Joker:
    puntos_Joker=size(match(umbral,descript_Joker,descriptores_muestra,locs_Joker,locs_muestra),1);

    
%% 6:
    puntos=[puntos_J_C puntos_J_P puntos_J_T puntos_J_R;...
            puntos_Q_C puntos_Q_P puntos_Q_T puntos_Q_R;...
            puntos_K_C puntos_K_P puntos_K_T puntos_K_R;...
            puntos_A_P puntos_Joker 0 0];
    max_puntos=max(max(puntos));
    
    switch max_puntos
        case puntos_J_C
            letra=100;
            palo='Corazones';
        case puntos_J_P
            letra=100;
            palo='Picas';
        case puntos_J_T
            letra=100;
            palo='Treboles';
        case puntos_J_R
            letra=100;
            palo='Rombos';
            
        case puntos_Q_C
            letra=200;
            palo='Corazones';
        case puntos_Q_P
            letra=200;
            palo='Picas';
        case puntos_Q_T
            letra=200;
            palo='Treboles';
        case puntos_Q_R
            letra=200;
            palo='Rombos';
            
        case puntos_K_C
            letra=300;
            palo='Corazones';
        case puntos_K_P
            letra=300;
            palo='Picas';
        case puntos_K_T
            letra=300;
            palo='Treboles';
        case puntos_K_R
            letra=300;
            palo='Rombos';
            
        case puntos_Joker
            letra=400;
            palo='Joker';
        case puntos_A_P
            letra=1;
            palo='Picas';
        
    end




