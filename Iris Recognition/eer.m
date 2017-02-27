% calculation of fnmr and fmr
% same represents same subject distance result£¬diff represents different subject distance result

clear all;
close all;
clc
load 'hd_mask_inner.mat';
load 'hd_mask_inter.mat';


x = 0.0:0.002:0.99;
% fmr = zeros(size(x));
% fnmr = zeros(size(x));
OPvalue=0.434;
 gh=reshape(hd_mask_inter,1,[]);



for k=1:length(x)
    fmr(k) = sum(gh(1,:) <= x(k)) / size(gh,2);
    fnmr(k) = sum(hd_mask_inner(1,:) > x(k)) / size(hd_mask_inner,2);    
end
% figure()
% plot( x,fmr,'.-r')
%%% EER %%%
EER = 1;
for i = 1:length(x)-1
        if fmr(i) == fnmr(i)
            EER = fmr(i);
        elseif sign(fmr(i)-fnmr(i))*sign(fmr(i+1)-fnmr(i+1)) == -1
            EER = (fmr(i)+fmr(i+1)+fnmr(i)+fnmr(i+1))/4;
            break;
        else
            EER = 1;            
        end
end


FAR=fmr(1,226)
FRR=fnmr(1,226)

imposter=reshape(hd_mask_inter,1,[]);
genuine=reshape(hd_mask_inner,1,[]);
%MakeROCCurve1(genuine,imposter)
threshold =0.0:0.002:0.99;
grr = []; 
far = []; 
% genuine = genuine * 1000000; 
% imposter = imposter * 1000000; 
for i = 1:length(threshold) 
%        grrIndex = find(genuine<=threshold(i)); 
%        grrTemp = 1 - (length(grrIndex)+360)/(length(genuine)+360); 
%        grr = [grr grrTemp]; 
      grrIndex = find(genuine<=threshold(i)); 
      grrTemp = (length(grrIndex)+360)/(length(genuine)+360); 
      grr = [grr grrTemp]; 
      
      farIndex = find(imposter<=threshold(i)); 
      farTemp = length(farIndex)/length(imposter); 
      far = [far farTemp]; 
end 
grr = grr   ; 
far = far   ; 
hold on
axis([0 1 0.49 1])
%figure,set(gca,'ytick',[0 10]); 
plot(far,grr,'--*r'); 
ylabel('true positive rate');
xlabel('false positive rate');
title('ROC curve')
 
 Area= trapz(far,grr)
Area2=Area^2; Q1=Area/(2-Area); Q2=2*Area2/(1+Area);
 Standard_deviation=(Area*(1-Area) +(Q1-Area2) +(Q2-Area2)) 
  
Serror=realsqrt(Standard_deviation);
%confidence interval
ci=Area+[-1].*(realsqrt(0.3)*erfcinv(0.5)*Serror)
EER