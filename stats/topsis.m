format bank
x=xlsread('pj','a1:h580');
[n,m]=size(x);
%�����ݽ��е���ָ�������ָ��ת��
x(:,4)=88.1./[88.1+abs(x(:,4)-88.1)]
x(:,5)=98.6./[98.6+abs(x(:,5)-98.6)]
x(:,6)=147.5./[147.5+abs(x(:,6)-147.5)]
x(:,7)=6-x(:,7)
x(:,8)=6-x(:,8)
zh=zeros(1,m);
d1=zeros(1,n); %��Сֵ����
d2=zeros(1,n); %���ֵ����
c=zeros(1,n);
%��һ��
for i=1:m
    for j=1:n
        zh(i)=zh(i)+x(j,i)^2;
    end
end
for i=1:m
    for j=1:n
       x(j,i)=x(j,i)/sqrt( zh(i));
    end
end
%�������
xx=min(x);
dd=max(x);
for i=1:n
    for j=1:m
        d1(i)=d1(i)+(x(i,j)-xx(j))^2;
    end
    d1(i)=sqrt(d1(i));
end
for i=1:n
    for j=1:m
        d2(i)=d2(i)+(x(i,j)-dd(j))^2;
    end
    d2(i)=sqrt(d2(i));
end
%����ӽ��̶�
for i=1:n
    c(i)=d1(i)/(d2(i)+d1(i));
end
c'
[a,b]=sort(c,'descend');
a=a'
b=b'