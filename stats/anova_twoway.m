clear all;clc;
ydata = xlsread('BOOK4','2');
Wheat=ydata(:,2);  
%Concentration= ydata(:,2);  
ways=ydata(:,1);
%D=ydata(:,4);
y=ydata(:,4);
%y=xlsread('book4','CA','g1:g160');  
%varnames = {'wheat','Concentration','Time'};
varnames = {'wheat','ways'};
%model=[eye(4);1 1 0 0;1 0 0 1;0 1 0 1;1 1 0 1];%;1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 1;];
%figure(2)
[p,table,stats,term]=anovan(y,{Wheat,ways},'model','full','varnames',varnames);
%[p,table,stats,term]=anovan(y,{A,B,C,D},'model','full','varnames',varnames)
%figure(8)
%[c,m,h,names] = multcompare(stats,'alpha',0.05,'ctype','lsd','dimension',[2 3]);%bonferroni,hsd,lsd,tukey-kramer,dunn-sidak,scheffe,
%set(gca,'YTick',1:8);
%set(gca,'YTickLabel',{'0.5%，花后10天','0.3%，花后10天',...
    %'0.1%，花后10天','0.0%，花后10天','0.5%，开花期',...
    %'0.3%，开花期','0.1%，开花期','0.0%，开花期'});
%title('籽粒','FontSize',14,'fontweight','b')
%xlabel('Fe含量（mg/kg）','FontSize',14,'fontweight','b')
%set(gca,'FontSize',14,'fontweight','b')
			
0.60			
0.70	0.48		
0.55	0.71	0.69	
