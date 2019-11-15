%此程序的作用是基于遗传算法及代价矩阵搜索出骑电单车的最优调配路径
clear
clc
chance=[0.096842105,0.04,0.074736842,0.134736842,0.054736842,0.186315789,0.187368421,0.064210526,0.036842105,0.124210526];
%根据数据点得到框定范围内用车的可能性
amount=4086*chance;
%根据每个聚合点的还车可能性，乘以车辆数据总量，得每个还车点周围可能的车辆数
distance=zeros(10,10);
point=xlsread('qeebike_return.xlsx');                                      %读取还车点坐标，此坐标为问题一中聚类算法获得的还车点坐标
for i=1:1:10
    for j=1:1:10
        if(i~=j)
        distance(i,j)=sqrt((point(i,1)-point(j,1))^2+(point(i,2)-point(j,2))^2);
        end
    end
end
%获取不同点间的距离矩阵
Cost=zeros(10,10);
for i=1:1:10
    for j=1:1:10
        if(i~=j)
        Cost(i,j)=1/(amount(1,j)*1.8-distance(i,j)*117*20);
        Cost(j,i)=Cost(i,j);
        %纬度转化为公里，综合搬运距离与用车可能带来的收益计算代价函数,Cost(i,j)为由i到j的代价
        end
    end
end
%获取代价矩阵
d=1000*Cost;
%由于代价函数中元素值较小，此处乘以1000放大代价值（并不影响最终路径的代价计算）
n=input('种群大小n=');                                                      %遗传算法初始种群大小
age=input('迭代次数=');                                                     %遗传算法遗传代数
r=input('交叉率=');                                                         %遗传算法交叉率
v=input('变异率=');                                                         %遗传算法变异率

L=length(d(1,:));                                                          %遗传算法还车点数目
s=[];                                                                      %初始化种群矩阵

for i=1:n
    s=[s;randperm(L)];                                                     %随机产生n个个体，形成初始种群                               
end

[line,row]=size(s);                                                        %获得种群个数和城市数
best=[];                                                                   %初始化最优值矩阵，用于记录迭代生成的种群中的最优值

for i=1:age
    [s,best(i)]=genetic(s,d,r,v);                                            %对种群不断进行迭代，同时记录每次迭代出来的最优值
end

fitness=[];
for i=1:line
    fitness=[fitness;1/cost(s(i,:),d)];                                    %计算最终种群中个体的适应度
end
[maxfitness,pos]=max(fitness);                                             %寻找最优个体的位置及其最大适应度
 x=xlsread('qeebike_return_x.xlsx');
 y=xlsread('qeebike_return_y.xlsx'); 
 figure;
 l=length(s(pos,:));
 plot([x(s(pos,1)),x(s(pos,end))],[y(s(pos,1)),y(s(pos,end))]);
 hold on;

 for j=1:l-1
     plot([x(s(pos,j)),x(s(pos,j+1))],[y(s(pos,j)),y(s(pos,j+1))]);
     hold on;
 end
 xlabel('Longtitude');
 ylabel('Latitude');
 title('The Optimal Cycle Under the Advanced Cost Function');           %绘制调配路线图

%输出最优路径及相应的耗费
disp('The Optimal Cycle:');
best_way=s(pos,:)
disp('The Least Cost of The Optimal Cycle：');
min_cost=cost(s(pos,:),d)

%绘制最优值变化趋势图
figure;                                 
plot(1:age,best)
xlabel('Iteration Times');
ylabel('The Least Cost of Each Iteration');
title('The Variation Trend of Optimal Value');
check=sort(s(pos,:));