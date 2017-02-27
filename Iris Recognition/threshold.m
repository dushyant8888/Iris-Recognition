clc;
clear;
load('hd_mask_inner');
load('hd_mask_inter');
hn1=reshape(hd_mask_inner,1,[]);
ht1=reshape(hd_mask_inter,1,[]);
x1=0:0.005:.7;
m1=hist(hn1,x1)/size(hn1,2);
n1=hist(ht1,x1)/size(ht1,2);
figure,bar(x1,m1,'r');
xlabel('Hamming Distance')
ylabel('Density')
title('Genuine Data')
figure,bar(x1,n1,'m');
xlabel('Hamming Distance')
ylabel('Density')
title('Imposter Data')

figure,plot(x1,m1,'r',x1,n1,'m');

 