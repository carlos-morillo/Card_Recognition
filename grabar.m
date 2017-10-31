
% vid = videoinput('winvideo', 3, 'YUY2_640x480');
% set(vid,'ReturnedColorSpace','rgb');
% set(vid,'TriggerRepeat',Inf);
% set(vid,'FramesPerTrigger',1);
% vid.FrameGrabInterval = 1;
% triggerconfig(vid,'manual');

% function carta=grabar(vid)
% clc
% close all
% stop(vid);
% start(vid);
% tic
% trigger(vid); while islogging(vid)==1, end; 
% Tiempo_de_logging=toc
% while(vid.FramesAcquired<=1)
%     tiempo1=toc;
%     im_inicial=getdata(vid,1);
%     tiempo2=toc;
%     subplot(2,1,1);
%     imshow(im_inicial);
% 	T=(tiempo2-tiempo1)
%     
%     trigger(vid);
%     
%      carta=procesar(im_inicial);
% end
% 
% stop(vid);


function carta=grabar(vid)
clc
stop(vid);
start(vid);
tic

im_inicial=getsnapshot(vid);

carta=procesar(im_inicial);
stop(vid);






