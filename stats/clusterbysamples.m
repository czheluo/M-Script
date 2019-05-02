clear,clc
format bank
X=xlsread('cl','z','a2:k1414');
[r c]=size(X);
x=nan(8,8,112,3); %定义x：8行8列最多2688个元素最多3重复
for m=1:r
    i=X(m,1)-5;
    j=X(m,2);
    k=X(m,3);
    x(:,i,j,k)=X(m,4:11)';
end
%以上为输入标准表格数据
p=8; %
%总体
S=zeros(8);A=zeros(8,1);m=0;
for i=1:8
    for j=1:112
        for k=1:3
           if ~isnan(x(:,i,j,k))
                m=m+1;
                A=A+x(:,i,j,k);
                S=S+x(:,i,j,k)*x(:,i,j,k)';
           end
        end
    end
end
SST=S-A*A'/m;

%组间
B=zeros(8,8); C=zeros(8,8,112);
l=zeros(8,112);St=zeros(8); 
n=zeros(1,8);
for i=1:8
    for j=1:112
        for k=1:3
            if ~isnan(x(:,i,j,k))
              C(:,i,j)=C(:,i,j)+x(:,i,j,k);
              l(i,j)=l(i,j)+1;
            end
        end
          B(:,i)=B(:,i)+C(:,i,j);
          n(i)=n(i)+l(i,j);
    end
      St=St+B(:,i)*B(:,i)'/n(i);
end
SSt=St-A*A'/m;

%组内
B=zeros(8,8); C=zeros(8,8,112);
l=zeros(8,112);St=zeros(8); 
n=zeros(1,8);Sw=zeros(8);
for i=1:8
    for j=1:112
        for k=1:3
            if ~isnan(x(:,i,j,k))
              C(:,i,j)=C(:,i,j)+x(:,i,j,k);
              l(i,j)=l(i,j)+1;
            end
        end
         if l(i,j)>0
            Sw=Sw+C(:,i,j)*C(:,i,j)'/l(i,j);
         end
         B(:,i)=B(:,i)+C(:,i,j);
         n(i)=n(i)+l(i,j);
    end
     St=St+B(:,i)*B(:,i)'/n(i);
end
SSw=Sw-St;
SSe=SST-SSt-SSw;

Re=zeros(8);
for i=1:8
    for j=1:8
        Re(i,j)=SSe(i,j)/sqrt(SSe(i,i)*SSe(j,j));
    end
end
Re;
%画图
C=SSe/833;B=xlsread('pj','B2:I581');
d=zeros(580,580);
for i=1:579
    for j=(i+1):580
         d(i,j)=d(i,j)+(B(j,:)-B(i,:))*inv(C)*(B(j,:)-B(i,:))'; 
           d(j,i)=d(i,j);
    end
end
d;
d(find(d==0))=nan;
x=d;Q=zeros(579,579)
for i=1:579
    for j=1:579
        if ~isnan(x(i,j))
            b=[0.8419741338 0.05820708957  -0.0019686  3.61590519e-06  0.5195183461  0.3325977202  -0.10359];
            format short
            r=nfx(b,x(i,j));
            Q(i,j)=r;
        end
    end
end
rb=1-Q;
rb(find(rb==1))=0;

test=rb;t=0;    %把此处修改为你需要的距离类型
% d_abs：绝对值距离；d_ou：欧氏距离；d_qie：切比雪夫距离；d_ming：明科夫斯基距离

M=length(test(1,:));MM=M;a=1:MM;
Z=zeros(MM-1,3);
disp('最短距离聚类分析结果：')
while(sum(sum(test)))
min=9999;
for i=1:M                          %在test中找出最大的相关系数及其下标...
    for j=1:M                      %...并提示：合并下标对应的两组数据
        if(min>test(i,j)&&test(i,j)~=0)
            min=test(i,j);
            x=i;y=j;
        end
    end
end
t=t+1;
str=['第',num2str(t),'步：lambda=',num2str(min),'>> 合并G(',...
    num2str(a(x)),')和G(',num2str(a(y)),')','记为G(',num2str(t+MM),')'];
disp(str)        %提示操作步骤
Z(t,:)=[a(x),a(y),min];   %收集dendrogram()画聚类图时所需的数据
 
a([x,y])=[];         %每执行一步，在a中删除被合并的数据号，在末尾顺次新增一个
if(~isempty(a))
    a(end+1)=t+MM;
end
 
g=zeros(1,M-2);      %生成新的距离矩阵
ii=0;
for i=1:M
    if(i==x||i==y);
    else
        ii=ii+1;
        g(ii)=(test(x,i)<test(y,i))*test(x,i)+(test(x,i)>=test(y,i))*test(y,i);
    end                  %...两列变一列：两两比较取其小者
end
test([x,y],:)=[];
test(:,[x,y])=[];
test=cat(1,test,g);
test=cat(2,test,[g';0]);
 
M=length(test(1,:));
end
dendrogram(Z,0);  %画树状聚类图
title('最短距离聚类');
ylabel('lambda');
clear M MM i ii j x y g a t min str Z
