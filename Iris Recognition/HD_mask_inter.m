tic
clc;
clear;
NUM=108;
load('template');


for i=1:NUM
    for k=1
    m=0;
        for j=1:NUM
            if(i==j)
                continue;
            else
                for l=1          
                    m=m+1;
                 temp=template(k,:,i).*template(l,:,j);
                    t1=sum(temp(find(temp==1)));
                    t2=abs(sum(temp(find(temp==-1))));
                    hd_mask_inter(k,m,i)=t2/(t1+t2);
                end
            end
        end
    end
end
 
save('hd_mask_inter.mat','hd_mask_inter');
csvwrite('inter.csv', hd_mask_inter)

toc
t=toc