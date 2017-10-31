% ¿Que hace esta funcion?
% Es la fucnion principal que se encarga de llamar a todas las fucniones
% auxiliares necesarias para lograr los requisitos de deteccion. Se
% introduce el fotograma que se ha captado de la camara y devuelve los
% valores de las cartas.
% 
% Pasos:
%   1- preprocesamiento de la imagen a color
%   2- extraccion de las propiedades (conocer el numero de cartas)
%   3- analisis de cada carta individualmente
%   4- muestra por pantalla el resultado de los calculos

function carta=procesar(im_inicial)
global im_principal todo
im_principal=im_inicial;
%% 1:
im_preprocesada=preprocesar(im_inicial);
Tiempo_de_preprocesado=toc;

%% 2:
propiedades=propiedadesCartas(im_preprocesada);
%% Para quitar el ruido no deseado (por falta de iluminacion)
    % Busca las figuras del tamaño deseado en la imagen
    v=[propiedades.FilledArea]<(55000);
    b=[propiedades.FilledArea]>(70000);
    % Las propiedades de las figuras no deseadas se eliminan en sentido 
    % contrario para no superponer datos
    propiedades(v)=[];
    propiedades(b)=[];

Tiempo_de_propiedades=toc;

%% 3:
for n=1:size(propiedades)
    carta(n)=analizarCarta(im_preprocesada,propiedades(n),n);
end
Tiempo_de_analisis=toc;
%% 4:
mostrarResultado(im_inicial,propiedades,carta);
Tiempo_de_ejecucion=toc;

set(todo.text12,'String',Tiempo_de_preprocesado);
set(todo.text13,'String',Tiempo_de_propiedades);
set(todo.text14,'String',Tiempo_de_analisis);
set(todo.text15,'String',Tiempo_de_ejecucion);




% PARA GUARDAR IMAGENES (BORRAR AL FINALIZAR)
% im_fig=imcrop(im_inicial,propiedades(1).BoundingBox);
% imwrite(im_fig,'C:\Users\Carlos\Google Drive\MASTER\MASTER\Vision por computador\Datos\AsDePicas.jpg');
% figure
% imshow(im_fig)




