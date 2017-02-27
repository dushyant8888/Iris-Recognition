
tic %to initialize clock
%normalisation parameters
radial_res = 150; %pixel value for circular image
angular_res = 900; %pixel value for rectangular image
 
 
 
for i=13;
    for j=1:2;
        eyeimage_filename=[num2str(1) '\' num2str(i) '\' num2str(j) '.bmp'];
        eyeimage = imread(eyeimage_filename); 
        savefile = [num2str(2) '\' num2str(i) '\' num2str(j) '-houghpara.m'];
        [circleiris circlepupil segimage] = segmentiris(eyeimage);
        save('savefile','circleiris','circlepupil','segimage');

        % WRITE NOISE IMAGE
        segimage2 = uint8(segimage);
        imagewithcircles = uint8(eyeimage);

        %get pixel coords for circle around iris
        [x,y] = circlecoords([circleiris(2),circleiris(1)],circleiris(3),size(eyeimage));
        ind2 = sub2ind(size(eyeimage),double(y),double(x)); 

        %get pixel coords for circle around pupil
        [xp,yp] = circlecoords([circlepupil(2),circlepupil(1)],circlepupil(3),size(eyeimage));
        ind1 = sub2ind(size(eyeimage),double(yp),double(xp));

         

        % Write circles overlayed
        imagewithcircles(ind2) = 255;
        imagewithcircles(ind1) = 255;
         
        imwrite(imagewithcircles,[num2str(1) '\' num2str(i) '\' num2str(j) '-segmented.bmp'],'bmp');    
        figure(1)
        imshow(imagewithcircles,[])
        % perform normalisation
        [polar_array] = normaliseiris( segimage, circleiris(2),...
        circleiris(1), circleiris(3), circlepupil(1), circlepupil(1), circlepupil(3),eyeimage, radial_res, angular_res);

        % WRITE NORMALISED PATTERN, AND NOISE PATTERN
        imwrite(polar_array,[num2str(1) '\' num2str(i) '\' num2str(j) '-polar.bmp'],'bmp');
        figure(2)
        imshow(polar_array,[])
        h = imcrop(polar_array,[2.91935483870968 4.53225806451613 897.58064516129 90.3225806451613] );
         imwrite(h,[num2str(1) '\' num2str(i) '\' num2str(j) '-cropimage.bmp'],'bmp');
         figure(3)
         imshow(h,[])
       polar=histeq(h);
        f=fspecial('gaussian');
        polar=imfilter(polar,f);
          
         imwrite(polar,[num2str(1) '\' num2str(i) '\' num2str(j) '-finalimage.bmp'],'bmp');
         figure(4)
         imshow(polar,[])
     end
 end
toc
d=toc

