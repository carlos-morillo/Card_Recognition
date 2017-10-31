% ¿Que hace esta funcion?
% Se encarga de analizar la correlacion de cada simbolo de las cartas y
% asignarle a un palo correspondiente 
% 
% Explicacion del proceso:
% 
%   1- Se extrae de la imagen real una imagen del simbolo
%   2- Se guardan en memoria las plantillas con las que se va a comparar la
%      imagen
%   3- Se añaden las columnas necesarias a la imagen para que sea del mismo
%      tamaño que la real
%   4- Se comparan ambas imagenes mediante el método de correlacion
%   5- En fucnion del resultado se devuelve un palo correspondiente


function palo=extraerPalo(im_cortada,propiedades_intrinsecas)
% 1:

    im_real=imcrop(im_cortada,propiedades_intrinsecas(1).BoundingBox);
    tamano_real=size(im_real);

% 2:
    % se guardan las plantillas
    pica=imread('C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\muestra_pica.jpg');
    corazon=imread('C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\muestra_corazon.jpg');
    trebol=imread('C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\muestra_trebol.jpg');
    rombo=imread('C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\muestra_rombo.jpg');
    % se adecúa el tamaño de las plantillas a la imagen real
    pica=im2bw(pica);
    pica=imresize(pica,[tamano_real(1) NaN]);
    corazon=im2bw(corazon);
    corazon=imresize(corazon,[tamano_real(1) NaN]);
    trebol=im2bw(trebol);
    trebol=imresize(trebol,[tamano_real(1) NaN]);
    rombo=im2bw(rombo);
    rombo=imresize(rombo,[tamano_real(1) NaN]);

% 3:
    tamano_pica=size(pica);
    tamano_corazon=size(corazon);
    tamano_trebol=size(trebol);
    tamano_rombo=size(rombo);
    
    % Como las cartas de la baraja pueden presentar las figuras giradas 180
    % grados sin un criterio lógico, se genera una plantilla de cada
    % muestra girada 180 grados para su posterior comparacion.
    pica=ajustarColumnas(pica,tamano_pica,tamano_real);
    pica_rot=imrotate(pica,180);
    corazon=ajustarColumnas(corazon,tamano_corazon,tamano_real);
    corazon_rot=imrotate(corazon,180);
    trebol=ajustarColumnas(trebol,tamano_trebol,tamano_real);
    trebol_rot=imrotate(trebol,180);
    rombo=ajustarColumnas(rombo,tamano_rombo,tamano_real);
    rombo_rot=imrotate(rombo,180);

% 4:
    
    corr_pica=corr2(pica,im_real);
    corr_pica_rot=corr2(pica_rot,im_real);
    corr_1=max(corr_pica,corr_pica_rot);
    
    corr_corazon=corr2(corazon,im_real);
    corr_corazon_rot=corr2(corazon_rot,im_real);
    corr_2=max(corr_corazon,corr_corazon_rot);
    
    corr_trebol=corr2(trebol,im_real);
    corr_trebol_rot=corr2(trebol_rot,im_real);
    corr_3=max(corr_trebol,corr_trebol_rot);
    
    corr_rombo=corr2(rombo,im_real);
    corr_rombo_rot=corr2(rombo_rot,im_real);
    corr_4=max(corr_rombo,corr_rombo_rot);
    
    corr=[corr_1 corr_2 corr_3 corr_4];
    
    maximo=max(corr);
    
% 5:
    switch maximo
        case corr_1
            palo='Picas';
        case corr_2
            palo='Corazones';
        case corr_3
            palo='Tréboles';
        case corr_4
            palo='Rombos';
    end
  
function muestra=ajustarColumnas(muestra,tamano_muestra,tamano_real)
% Esta funcion fuerza a que ambas imagenes tengan el mismo tamaño, para
% ello añade o elimina columnas sin informacion a la imagen de muestra
    if tamano_muestra(2)~=tamano_real(2)    % Compara los tamaños
        i= tamano_muestra(2)-tamano_real(2);
        s = size(muestra);
        if i<0 % hay que añadir
            for j=1:abs(i)
                muestra(:,s(2)+j)=0;
            end
        else  % hay que quitar
            for j=abs(i):-1:1
                s = size(muestra);
                muestra(:,s(2))=[];
            end
        end
    end



