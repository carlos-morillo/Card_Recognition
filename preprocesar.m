% ¿Que hace esta funcion?
% Se encarga de realizar una conversion previa de la imagen captada para
% adaptarla a facilitar las necesidades del resto de funciones y procesos.
% 
% Explicacion de cada paso:
%   1- Convertir de RGB a Gray --> im_gray=rgb2gray(im_inicial);
%   2- Aumentar la luminosidad de la imagen --> im_eq= imadjust(im_gray,[0;1],[0;1],0.85);
%   3- Convertir de Gray a binario --> im_bin=im2bw(im_gray);
%   4- Se le aplica un filtro de apertura y cierre para eliminar pixeles
%      aislados no deseados --> 
%                   SE=strel('square',1);
%                   im_open=imopen(im_bin,SE);
%                   im_close=imclose(im_open,SE);
%   5- Se eliminan huecos de menor diametro al indicado -->
%                   im_close_menor=bwareopen(im_close,5);
%
%


function im_preprocesada=preprocesar(im_inicial)
% global todo
% 1:
im_gray=rgb2gray(im_inicial);

% 2:
im_eq= imadjust(im_gray,[0;1],[0;1],0.85); 

% 3: 
im_bin=im2bw(im_eq); 

% if get(todo.checkbox3,'value')==0
%     im_bin=not(im_bin);
% end
% 4:
SE=strel('square',1);
im_open=imopen(im_bin,SE);

im_close=imclose(im_open,SE);

% 5:
im_close_menor=bwareaopen(im_close,5);

im_preprocesada=im_close_menor;
% axes(todo.axes2)
imshow(im_preprocesada)
drawnow;

