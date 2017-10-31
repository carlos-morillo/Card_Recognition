% ¿Que hace esta funcion?
% Coge la imagen preprocesada para contar las cartas que hay en total en la
% mesa
% 
% Conversion de la imagen paso a paso:
%   1- Rellenar las cartas completamente --> im_fill=imfill(im_bin,'holes')
%   2- Contar el numero de cartas que hay --> [im_label,N]=bwlabel(im_fill,4);
%   3- Obtener las propiedades de cada carta individualmente --> 
%      --> propiedades=regionprops(im_label,'Boundingbox','Centroid','Orientation');
%   4- Filtrado de las formas demasiado pequeñas para ser carta

function propiedades = propiedadesCartas(im_preprocesada)
% 1:
im_fill=imfill(im_preprocesada,'holes');

% 2:
[im_label,~]=bwlabel(im_fill,4);
% 3:
propiedades_aux=regionprops(im_label,'Boundingbox','Centroid','Orientation',...
                        'EulerNumber','Extent','Perimeter','Centroid','Extrema',...
                        'PixelIdxList' , 'ConvexArea','FilledArea','PixelList',...
                        'ConvexHull','FilledImage','Solidity' ,'ConvexImage',...
                        'Image','SubarrayIdx','Eccentricity','MajorAxisLength',...
                        'EquivDiameter', 'MinorAxisLength');

propiedades=propiedades_aux;

   
    
    
    