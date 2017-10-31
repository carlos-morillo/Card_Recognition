% ¿Que hace esta funcion?
% Se encarga de dibujar y mostrar la imagen original pero con la
% informacion necesaria tras el procesamiento completo de dicha imagen
% original. La informacion será la posicion, el valor ...
% 
% Explicacion de cada paso:
%   1- Se muestra la imagen original --> imshow(im_inicial);
%   2- Se crean los rectángulos que englobarán a las cartas localizadas        
%   3- Se muestra por pantalla el valor y palo de cada carta


function mostrarResultado(im_inicial,propiedades,carta)
%% 1:
    global todo vid

    axes(todo.axes1)
    vidRes = vid.VideoResolution; 
    nBands = vid.NumberOfBands;
    hImage = image(zeros(vidRes(2),vidRes(1), nBands),'Parent',todo.axes1);
    preview(vid, hImage);

%% 2:
    [N,~]=size(propiedades);
    for i=1:N
        rectangle('position',propiedades(i).BoundingBox,'edgecolor','r','linewidth',3);    
    end
%% 3:
    for n=1:N
        texto=[num2str(carta(n).valor),' de ',carta(n).palo];
        switch carta(n).valor
            case 1
                texto=['AS de ',carta(n).palo];
            case 100
                texto=['J de ',carta(n).palo];
            case 200
                texto=['Q de ',carta(n).palo];
            case 300
                texto=['K de ',carta(n).palo];
            case 400
                texto=['Joker'];
        end
        x=propiedades(n).Centroid(1)-100;
        y=propiedades(n).BoundingBox(2)-20;
        text(x,y,texto,'color','r','FontSize',15);
        
        switch n
            case 1
                set(todo.text2,'String',texto);
            case 2
                set(todo.text3,'String',texto);
            case 3
                set(todo.text4,'String',texto);
            case 4
                set(todo.text5,'String',texto);
        end
    end
