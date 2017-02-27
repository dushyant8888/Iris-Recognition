nscales=1; 
minWaveLength=8; 
mult=1; % not applicable if using nscales = 1 
sigmaOnf=0.5; 
 noshifts=2;
tic;
NUM=39;
% template=zeros(91,898,NUM);
for i=1:NUM
    for j=1:5     
        I=imread(['1\' num2str(i) '\' num2str(j) '-finalimage.jpg']);%read the images from the folder
        
        I=im2double(I);%Convert image to double precision 
       [ch3] = encode(I, nscales, minWaveLength, mult, sigmaOnf);

%         ch3(find(ch3>0))=1;%assume positive coff. equal to 1
%         ch3(find(ch3<0))=0;%discarded negetive coff.
        [row,col]=size(ch3);
      
        templat=reshape(ch3,1,[]);   
        template(j,1:row*col,i) = shiftbits(templat, noshifts,nscales);

    end
end
% template = shiftbits(template, noshifts,nscales);
toc;
ld=toc/(18*3)
  save('template.mat','template');
