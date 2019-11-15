%�˳���������ǻ����Ŵ��㷨�����������������絥�������ŵ���·��
clear
clc
distance=zeros(10,10);
point=xlsread('qeebike_return.xlsx');                                      %��ȡ���������꣬������Ϊ����һ�о����㷨��õĻ���������
for i=1:1:10
    for j=1:1:10
        if(i~=j)
        distance(i,j)=sqrt((point(i,1)-point(j,1))^2+(point(i,2)-point(j,2))^2);
        end
    end
end
d=1000*distance;
%���ھ��뺯����Ԫ��ֵ��С���˴�����1000�Ŵ����ֵ������Ӱ������·���Ĵ��ۼ��㣩
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
 title('The Optimal Cycle Under the Cost Function of Distance');           %���Ƶ���·��ͼ

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