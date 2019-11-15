function [A,mins]=genetic(s,d,r,v)
%sΪ��Ⱥ��������
%dΪ�������۾���
%r��ÿ�ε����еĽ�����

a1=[];
[m,t]=size(s);

fitness=[];
for i=1:m
    fitness=[fitness;1/cost(s(i,:),d)];                                    %��������������Ӧ��
end

f=sum(fitness(:));
p=fitness./f;                                                              %��������ѡ�еĸ���
[~,maxA]=max(p);
mins=cost(s(maxA,:),d);                                                    %��¼��ǰ��Ⱥ�����Ÿ���ķ���
sump=[];
for i=1:length(p)
    sump=[sump,sum(p(1:i))];                                               %�ۻ�����
end

n=round((1-r)*m);                                                          %����������������������
[~,l]=sort(p);
a1=[a1;s(l(length(p)-n+1:end),:)];                                         %��Ӧ����ߵ�(1-r)n��������������������һ��

tnews=s(l(1:m-n),:);
[g,numcity]=size(tnews);                                                   %��ʣ�µĸ�����ʹ�����̶Ĳ�����ѡ����������н���������
i=1;
a=[];
while i<=g
    fm=rand(1,2);                                                          %�����������0-1���������Ϊ�ۻ����ʵ�ȡֵ
    point=sort(round(1+(numcity-3)*rand(1,2)));                            %���ѡȡ�������λ��
    while point(1)==point(2)                                               %|| fpoint==1 || mpoint==1 || fpoint==k ||mpoint==k
        point=sort(round(1+(numcity-3)*rand(1,2)));                        %��ֹ����λ���ظ�
    end
    father=[];
    mother=[];
    fathernum=1;
    mothernum=1;
    while fm(1)>sump(fathernum)
        fathernum=fathernum+1;                                             %������������ĸ���ѡ�񸸴�����
    end
    father=s(fathernum,:);
    while fm(2)>sump(mothernum)
        mothernum=mothernum+1;                                             %������������ĸ���ѡ�񸸴�����
    end
    mother=s(mothernum,:);
    
    %whileѭ���Ƿ�ֹ�����ĸ��׺�ĸ���ظ�
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
    
    %��ʼ���Ӵ�����
    children1=[];
    children2=[];
    flag1=1;
    flag2=1;
    
    %����������佻��λ���еĻ�����е���
    children1=[father(1,1:point(1)),mother(1,(point(1)+1):(point(2)-1)),father(1,point(2):end)];
    children2=[mother(1,1:point(1)),father(1,(point(1)+1):(point(2)-1)),mother(1,point(2):end)];
    
    %whileѭ����������������Ӵ�����Ļ��򣬷�ֹ�������Ӵ������еĻ�������ظ�
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
    %ѡ����Ӧ�ȸ��ߵĸ�����Ϊ�Ӵ���������Ӵ���
    if cost(children1,d)<=cost(children2,d)
        a=[a;children1];
    else
        a=[a;children2];
    end
    
    i=i+1;
end
%�����ɵ��Ӵ��У����ѡȡvn��������б������
xc=round((g-1)*rand(1,fix(m*v))+1);
for i=1:length(xc)
       a(xc(i),:)=randperm(t);                                             
       %���´����Ӵ��Ļ���˳�򣬴Ӷ�����һ���µ��Ӵ�
end
a1=[a1;a];

A=a1;