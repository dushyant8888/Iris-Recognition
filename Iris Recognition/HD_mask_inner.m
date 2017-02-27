tic
clc;
clear;
NUM=108;
 
load('template');
 

for i=1:NUM
    m=0;
    for j=1:7
        for k=(j+1):7
            m=m+1;
            temp=template(j,:,i).*template(k,:,i);
            t1=sum(temp(find(temp==1)));
            t2=abs(sum(temp(find(temp==-1))));
            hd_mask_inner(i,m)=(t2/(t1+t2))*(0.9);
            
        end
    end
end
 
save('hd_mask_innner.mat','hd_mask_inner');

 
csvwrite('inner.csv', hd_mask_inner)
toc
t=toc;