function [A,mins]=genetic(s,d,r,v)
%s为种群样本矩阵
%d为两点间代价矩阵
%r是每次迭代中的交叉率

a1=[];
[m,t]=size(s);

fitness=[];
for i=1:m
    fitness=[fitness;1/cost(s(i,:),d)];                                    %计算各个个体的适应度
end

f=sum(fitness(:));
p=fitness./f;                                                              %各方案被选中的概率
[~,maxA]=max(p);
mins=cost(s(maxA,:),d);                                                    %记录当前种群中最优个体的费用
sump=[];
for i=1:length(p)
    sump=[sump,sum(p(1:i))];                                               %累积概率
end

n=round((1-r)*m);                                                          %被保留下来的最优样本数
[~,l]=sort(p);
a1=[a1;s(l(length(p)-n+1:end),:)];                                         %适应度最高的(1-r)n个样本被保留传递至下一代

tnews=s(l(1:m-n),:);
[g,numcity]=size(tnews);                                                   %从剩下的个体中使用轮盘赌策略挑选父代个体进行交叉变异操作
i=1;
a=[];
while i<=g
    fm=rand(1,2);                                                          %随机产生两个0-1间的数，作为累积概率的取值
    point=sort(round(1+(numcity-3)*rand(1,2)));                            %随机选取交叉基因位点
    while point(1)==point(2)                                               %|| fpoint==1 || mpoint==1 || fpoint==k ||mpoint==k
        point=sort(round(1+(numcity-3)*rand(1,2)));                        %防止交叉位点重复
    end
    father=[];
    mother=[];
    fathernum=1;
    mothernum=1;
    while fm(1)>sump(fathernum)
        fathernum=fathernum+1;                                             %根据随机产生的概率选择父代个体
    end
    father=s(fathernum,:);
    while fm(2)>sump(mothernum)
        mothernum=mothernum+1;                                             %根据随机产生的概率选择父代个体
    end
    mother=s(mothernum,:);
    
    %while循环是防止产生的父亲和母亲重复
    while mother==father
        fm=rand(1,2);
        father=[];
        mother=[];
        fathernum=1;
        mothernum=1;
        while fm(1)>sump(fathernum)
            fathernum=fathernum+1;
        end
        father=s(fathernum,:);
        while fm(2)>sump(mothernum)
            mothernum=mothernum+1;
        end
        mother=s(mothernum,:);
    end
    
    %初始化子代个体
    children1=[];
    children2=[];
    flag1=1;
    flag2=1;
    
    %交叉操作，间交叉位点中的基因进行调换
    children1=[father(1,1:point(1)),mother(1,(point(1)+1):(point(2)-1)),father(1,point(2):end)];
    children2=[mother(1,1:point(1)),father(1,(point(1)+1):(point(2)-1)),mother(1,point(2):end)];
    
    %while循环处理产生的两个子代个体的基因，防止产生的子代个体中的基因出现重复
    while flag1>0
        flag1=0;
        for j=1:length(children1)
            for k=1:length(children1)
                if j~=k && children1(j)==children1(k)
                    if children1(j)~=children2(j)
                        x=children1(k);
                        children1(k)=children2(j);
                        children2(j)=x;
                        flag1=1;
                    else
                        x=children1(j);
                        children1(j)=children2(k);
                        children2(k)=x;
                        flag1=1;
                    end
                end
            end
        end
    end
    
    while flag2>0
        flag2=0;
        for j=1:length(children2)
            for k=1:length(children2)
                if j~=k && children2(j)==children2(k)
                    if children1(j)~=children2(j)
                        x=children2(k);
                        children2(k)=children1(j);
                        children1(j)=x;
                        flag2=1;
                    else
                        x=children2(j);
                        children2(j)=children1(k);
                        children1(k)=x;
                        flag2=1;
                    end
                end
            end
        end
    end
    %选择适应度更高的个体作为子代个体加入子代中
    if cost(children1,d)<=cost(children2,d)
        a=[a;children1];
    else
        a=[a;children2];
    end
    
    i=i+1;
end
%在生成的子代中，随机选取vn个个体进行变异操作
xc=round((g-1)*rand(1,fix(m*v))+1);
for i=1:length(xc)
       a(xc(i),:)=randperm(t);                                             
       %重新打乱子代的基因顺序，从而生成一个新的子代
end
a1=[a1;a];

A=a1;