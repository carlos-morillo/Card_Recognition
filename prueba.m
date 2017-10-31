function prueba(carta1)
SE=strel('disk',7);

figure(1)
imshow(carta1)

figure(2)
carta_dilatada=imdilate(carta1,SE);
carta_erosionada=imerode(carta1,SE);
carta_open=imopen(carta1,SE);
carta_close=imclose(carta1,SE);
subplot(2,2,2);imshow(carta_erosionada);
subplot(2,2,4);imshow(carta_close);
subplot(2,2,3);imshow(carta_open);
subplot(2,2,1);imshow(carta_dilatada);

figure(3)
carta_bothat=bwmorph(carta1,'bothat');
carta_branchpoints=bwmorph(carta1,'branchpoints');
carta_bridge=bwmorph(carta1,'bridge');
carta_clean=bwmorph(carta1,'clean');
subplot(2,2,2);imshow(carta_bothat);title('bothat');
subplot(2,2,4);imshow(carta_branchpoints);title('branchpoints');
subplot(2,2,3);imshow(carta_bridge);title('bridge');
subplot(2,2,1);imshow(carta_clean);title('clean');

figure(4)
carta_close=bwmorph(carta1,'close');
carta_diag=bwmorph(carta1,'diag');
carta_endpoints=bwmorph(carta1,'endpoints');
carta_fill=bwmorph(carta1,'fill');
subplot(2,2,2);imshow(carta_bothat);title('close');
subplot(2,2,4);imshow(carta_branchpoints);title('diag');
subplot(2,2,3);imshow(carta_bridge);title('endpoints');
subplot(2,2,1);imshow(carta_clean);title('fill');

figure(5)
carta_hbreak=bwmorph(carta1,'hbreak');
carta_majority=bwmorph(carta1,'majority');
carta_open=bwmorph(carta1,'open');
carta_remove=bwmorph(carta1,'remove');
subplot(2,2,2);imshow(carta_bothat);title('hbreak');
subplot(2,2,4);imshow(carta_branchpoints);title('majority');
subplot(2,2,3);imshow(carta_bridge);title('open');
subplot(2,2,1);imshow(carta_clean);title('remove');


figure(6)
carta_shrink=bwmorph(carta1,'shrink');
carta_skel=bwmorph(carta1,'skel');
carta_spur=bwmorph(carta1,'spur');
carta_thicken=bwmorph(carta1,'thicken');
subplot(2,2,2);imshow(carta_bothat);title('shrink');
subplot(2,2,4);imshow(carta_branchpoints);title('skel');
subplot(2,2,3);imshow(carta_bridge);title('spur');
subplot(2,2,1);imshow(carta_clean);title('thicken');

figure(7)
carta_thin=bwmorph(carta1,'thin');
carta_tophat=bwmorph(carta1,'tophat');
subplot(2,1,1);imshow(carta_bothat);title('thin');
subplot(2,1,2);imshow(carta_branchpoints);title('tophat');
