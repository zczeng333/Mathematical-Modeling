function s=cost(x,d)
%这个函数的作用是求取方案对应的总代价，并返回该方案对应的位点序列
%x是方案对应的位点序列
s=d(x(1),x(end));
for i=1:length(x)-1
    s=s+d(x(i),x(i+1));
end