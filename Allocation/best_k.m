clear;
clc;
heat=xlsread('qeebike.xls');
opts = statset('Display','final');
for k=1:1:100
    [idx,C,sumd,D] = kmeans(heat,k,'Distance','cityblock','Replicates',5,'Options',opts);
    temp=1000;
    sum=0;
    for i=1:1:4086
        for j=1:1:k
            if(D(i,j)<temp)
                temp=D(i,j)
            end
        end
        sum=sum+temp;
    end
    sum=sum*k;
    S(k,1)=sum;
end