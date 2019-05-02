clear,clc
format bank
X=xlsread('cl','z','a2:k1414');
[r c]=size(X);
x=nan(8,8,112,3); %����x��8��8�����2688��Ԫ�����3�ظ�
for m=1:r
    i=X(m,1)-5;
    j=X(m,2);
    k=X(m,3);
    x(:,i,j,k)=X(m,4:11)';
end
%����Ϊ�����׼�������
p=8; %
%����
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

%���
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

%����
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
%��ͼ
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

test=rb;t=0;    %�Ѵ˴��޸�Ϊ����Ҫ�ľ�������
% d_abs������ֵ���룻d_ou��ŷ�Ͼ��룻d_qie���б�ѩ����룻d_ming�����Ʒ�˹������

M=length(test(1,:));MM=M;a=1:MM;
Z=zeros(MM-1,3);
disp('��̾��������������')
while(sum(sum(test)))
min=9999;
for i=1:M                          %��test���ҳ��������ϵ�������±�...
    for j=1:M                      %...����ʾ���ϲ��±��Ӧ����������
        if(min>test(i,j)&&test(i,j)~=0)
            min=test(i,j);
            x=i;y=j;
        end
    end
end
t=t+1;
str=['��',num2str(t),'����lambda=',num2str(min),'>> �ϲ�G(',...
    num2str(a(x)),')��G(',num2str(a(y)),')','��ΪG(',num2str(t+MM),')'];
disp(str)        %��ʾ��������
Z(t,:)=[a(x),a(y),min];   %�ռ�dendrogram()������ͼʱ���������
 
a([x,y])=[];         %ÿִ��һ������a��ɾ�����ϲ������ݺţ���ĩβ˳������һ��
if(~isempty(a))
    a(end+1)=t+MM;
end
 
g=zeros(1,M-2);      %�����µľ������
ii=0;
for i=1:M
    if(i==x||i==y);
    else
        ii=ii+1;
        g(ii)=(test(x,i)<test(y,i))*test(x,i)+(test(x,i)>=test(y,i))*test(y,i);
    end                  %...���б�һ�У������Ƚ�ȡ��С��
end
test([x,y],:)=[];
test(:,[x,y])=[];
test=cat(1,test,g);
test=cat(2,test,[g';0]);
 
M=length(test(1,:));
end
dendrogram(Z,0);  %����״����ͼ
title('��̾������');
ylabel('lambda');
clear M MM i ii j x y g a t min str Z
