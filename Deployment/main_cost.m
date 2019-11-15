%�˳���������ǻ����Ŵ��㷨�����۾�����������絥�������ŵ���·��
clear
clc
chance=[0.096842105,0.04,0.074736842,0.134736842,0.054736842,0.186315789,0.187368421,0.064210526,0.036842105,0.124210526];
%�������ݵ�õ��򶨷�Χ���ó��Ŀ�����
amount=4086*chance;
%����ÿ���ۺϵ�Ļ��������ԣ����Գ���������������ÿ����������Χ���ܵĳ�����
distance=zeros(10,10);
point=xlsread('qeebike_return.xlsx');                                      %��ȡ���������꣬������Ϊ����һ�о����㷨��õĻ���������
for i=1:1:10
    for j=1:1:10
        if(i~=j)
        distance(i,j)=sqrt((point(i,1)-point(j,1))^2+(point(i,2)-point(j,2))^2);
        end
    end
end
%��ȡ��ͬ���ľ������
Cost=zeros(10,10);
for i=1:1:10
    for j=1:1:10
        if(i~=j)
        Cost(i,j)=1/(amount(1,j)*1.8-distance(i,j)*117*20);
        Cost(j,i)=Cost(i,j);
        %γ��ת��Ϊ����ۺϰ��˾������ó����ܴ��������������ۺ���,Cost(i,j)Ϊ��i��j�Ĵ���
        end
    end
end
%��ȡ���۾���
d=1000*Cost;
%���ڴ��ۺ�����Ԫ��ֵ��С���˴�����1000�Ŵ����ֵ������Ӱ������·���Ĵ��ۼ��㣩
n=input('��Ⱥ��Сn=');                                                      %�Ŵ��㷨��ʼ��Ⱥ��С
age=input('��������=');                                                     %�Ŵ��㷨�Ŵ�����
r=input('������=');                                                         %�Ŵ��㷨������
v=input('������=');                                                         %�Ŵ��㷨������

L=length(d(1,:));                                                          %�Ŵ��㷨��������Ŀ
s=[];                                                                      %��ʼ����Ⱥ����

for i=1:n
    s=[s;randperm(L)];                                                     %�������n�����壬�γɳ�ʼ��Ⱥ                               
end

[line,row]=size(s);                                                        %�����Ⱥ�����ͳ�����
best=[];                                                                   %��ʼ������ֵ�������ڼ�¼�������ɵ���Ⱥ�е�����ֵ

for i=1:age
    [s,best(i)]=genetic(s,d,r,v);                                            %����Ⱥ���Ͻ��е�����ͬʱ��¼ÿ�ε�������������ֵ
end

fitness=[];
for i=1:line
    fitness=[fitness;1/cost(s(i,:),d)];                                    %����������Ⱥ�и������Ӧ��
end
[maxfitness,pos]=max(fitness);                                             %Ѱ�����Ÿ����λ�ü��������Ӧ��
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
 title('The Optimal Cycle Under the Advanced Cost Function');           %���Ƶ���·��ͼ

%�������·������Ӧ�ĺķ�
disp('The Optimal Cycle:');
best_way=s(pos,:)
disp('The Least Cost of The Optimal Cycle��');
min_cost=cost(s(pos,:),d)

%��������ֵ�仯����ͼ
figure;                                 
plot(1:age,best)
xlabel('Iteration Times');
ylabel('The Least Cost of Each Iteration');
title('The Variation Trend of Optimal Value');
check=sort(s(pos,:));