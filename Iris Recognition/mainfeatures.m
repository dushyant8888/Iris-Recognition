close all
clear;
clc;
tic;
NUM=108;
warning off
%template=zeros(91,898,NUM);
for i=1:108
    for j=1:7       
        I=imread(['1\' num2str(i) '\' num2str(j) '-polar.bmp']);%read the images from the folder
%          I=fcnBPDFHE(I,'triangular',[9]);
%           I=fcnBPDFHE(I,'triangular',[9]);
        I=im2double(I);%Convert image to double precision 
        
%           T = dctmtx(16);%taking 4 by 4 two dimensional dct matrix
% %          
%  dct = @(y)T * y * T';%create a function_handle
%  ch3= blkproc(I,[16 16],dct);%blockwise decomposition of image
%       
[c,s]=wavedec2(I,2,'rbio2.2');% 2-D wavelet decomposition
        ch3=detcoef2('h',c,s,2);
        ch3(find(ch3>0))=1;%assume positive coff. equal to 1
        ch3(find(ch3<0))=-1;%discarded negetive coff.
        [row,col]=size(ch3);
        template(j,1:row*col,i)=reshape(ch3,1,[]);    
    end
end
toc;
ld=toc/(18*3);
  save('template.mat','template');
