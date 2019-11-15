clear
clc
heat=xlsread('qeebike.xlsx');
opts = statset('Display','final');
k=505;
[idx,C] = kmeans(heat,k,'Distance','cityblock',...
    'Replicates',5,'Options',opts);
figure;
hold on
for i=1:k
    plot(heat(idx==i,1),heat(idx==i,2),'.',...
        'Color',[1/k*i,1-1/k*i,1/k*i],'MarkerSize',9)
end
plot(C(:,1),C(:,2),'kx','MarkerSize',7,'LineWidth',1)
title 'Result of Cluster Assignments and Centroids Using K-Means Algorithm'
xlabel 'Longitude'
ylabel 'Latitude '
hold off