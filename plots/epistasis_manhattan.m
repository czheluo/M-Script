
addpath D:\\MATLAB\\isreg\\2017GWAS\\Epistasis\\export_fig
clear,clc; 
map=readtable('all_yieldperplant1999(10chose)5.0.00001.d&a.txt');
x1 = table2array(map(:,3));x2 = table2array(map(:,4));
x4 = table2array(map(:,5));x5 = table2array(map(:,6));
label1=table2cell(map(:,1));label2=table2cell(map(:,2));
label3=[label1 label2]; clear label1 label 2 
x3 = table2array(map(:,8));an=find(x3==0);
x3(an)=0.1;plm=-log10(x3);%clear map
chr=unique(x1);ch=num2str(chr);
%for i=1:chr

chose=input('Chose a type of epistasis plot(stem or scatter(1)) = ');
if chose==1
    for i=1:length(chr)
        [g,h]=find(x1==i);
        s=plm*5;c=x2;
        scatter3(x1(g),x2(g),plm(g),s(g),c(g),'filled');
        %scatter3(x4(g),x5(g),plm(g),s(g),c(g),'filled');
        hold on
    end
else
    %cl=zeros(length(chr),3);
    cl=load('colorchrhg.txt');ncl=randperm(length(cl(:,1)));cl=cl(ncl,:);
    for i=1:length(chr)
        [c,d]=find(x1==i);
        %cl1=cl(i,:);
        %cl1=unifrnd(0,1,1,3);
        %cl2=unifrnd(0,1,1,3);
        stem3(x1(c),x2(c),plm(c),'filled','Color',cl(i,:));clear x4 x5%,'MarkerEdgeColor',cl2);
        %stem3(x4(c),x5(c),plm(c),'filled','Color',cl1)%,'MarkerEdgeColor',cl2);
        hold on
        %cl(i,:)=cl1;
    end
    save col1.mat cl
end
set(gca,'XTick', chr);set(gca,'XTickLabel',ch);set(gca,'xlim',[1-0.5,length(chr)+0.5]);
set(gca,'YTick', chr);set(gca,'YTickLabel',ch);set(gca,'ylim',[1-0.5,length(chr)+0.5]);%ylim([1 length(chr)]);
set(gca,'FontName','Times New Roman','FontWeight','bold','FontSize',16);
xlabel('Chromosome');ylabel('Chromosome');zlabel('-log_{10}(\itP)');box on
[a,b]=find(x3<0.05/length(plm));
label=join(label3(a,:),'X');
 hold on
 if chose==1
     scatter3(x2(a),x1(a),plm(a),s(a),c(a),'filled')
     hold on
     stem3(x2(a),x1(a),plm(a),'Marker','none')
    for i=1:length(a)
        cl=unifrnd(0,1,1,3);
        text(x2(a(i)),x1(a(i)),plm(a(i))+1.5,label(i),'Color',cl,'FontName','Times New Roman',...
            'FontWeight','bold','FontSize',10);
    end
 else
     for i=1:length(a)
         stem3(x2(a(i)),x1(a(i)),plm(a(i)),'filled','Color',cl(x1(a(i)),:))
         hold on
     end
     for i=1:length(a)
         text(x2(a(i)),x1(a(i)),plm(a(i))+1.5,label(i),'Color',cl(x1(a(i)),:),'FontName','Times New Roman',...
             'FontWeight','bold','FontSize',10);
    end
 end
 
%export_fig epis_stem_5million.bmp
 
 
 
 
 
 
 
 
 
 
 
 