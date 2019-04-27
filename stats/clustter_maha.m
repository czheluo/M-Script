clear all;clc;
X=xlsread('gx7','1','b1:j151');
X=X';
x(:,1,:)=X(:,1:75);
x(:,2,:)=X(:,76:150);
X=[];
[p,n,g]=size(x);
T=zeros(p,1);
for i=1:n
    for j=1:g
        T(:)=T(:)+x(:,i,j);
    end 
end
T;
Ti=zeros(p,g);
for i=1:g
    for j=1:n
        Ti(:,i)=Ti(:,i)+x(:,j,i);
    end
end
Ti;
SSPT=zeros(p,p);
for i=1:n
    for j=1:g
        SSPT=SSPT+x(:,i,j)*x(:,i,j)';
    end
end
SSPT=SSPT-1/(n*g).*T*T';
SSPt=zeros(p,p);
for i=1:g
    SSPt=SSPt+Ti(:,i)*Ti(:,i)';
end
SSPt=1/(n).*SSPt-1/(n*g).*T*T';
SSPe=SSPT-SSPt;
w=SSPe/(g*(n-1))
y=xlsread('gx7','2','b1:j75');
m=size(y,1);
%dist=zeros(m,m);
for i=1:m-1
    for j=i+1:m
        dist(i,j)=sqrt((y(j,:)-y(i,:))*inv(w)*(y(j,:)-y(i,:))');dist(j,i)=dist(i,j);
    end
end
dist;
%xlswrite('gx1.xls',dist)
%y=xlsread('gx1.xls');
%d=pdist(x,'mahalanobis');
%y=squareform(dist,'tovector');
Z=linkage(dist,'average');
[H,T,perm]=dendrogram(Z,0,'orientation','top','ColorThreshold','default');
set(H,'lineWidth',2);%,'Color','k')
%incon=inconsistent(Z,40);




        