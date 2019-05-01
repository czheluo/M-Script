hold on 
for i=1:104
    if  c(i,1)>mean(c(:,1)) && c(i,2)>mean(c(:,2)) && c(i,3)>mean(c(:,3))
        cl=unifrnd(0,1,1,3);
        stem3(c(i,1),c(i,2),c(i,3),'filled','Color',cl);
       % scatter3(c(i,1),c(i,2),c(i,3),'filled',...
          %  'MarkerFaceColor',cl,...
          %  'MarkerEdgeColor',cl)
        text(c(i,1),c(i,2),c(i,3)+1.5,p(i),'Color',cl,'fontsize',12');
        hold on
    else
        stem3(c(i,1),c(i,2),c(i,3),'filled','Color','k');
        hold on
    end
end

for i=1:104
    if  c(i,1)>33.88 && c(i,2)>39.36 && c(i,3)>7.69
        stem3(c(i,1),c(i,2),c(i,3),'filled','Color','r');
        tect(c(i,1),c(i,2),c(i,3)+1.5,num2str(i),'fontsize',12');
        hold on
    else
        stem3(c(i,1),c(i,2),c(i,3),'filled','Color','b');
        tect(c(i,1),c(i,2),c(i,3)+1.5,num2str(i),'fontsize',12');
        hold on
    end
end

fig=figure; 

%hac=aces; 

for i=1:40
    if  c(i,3)>mean(c(:,3)) && c(i,4)>mean(c(:,4))
        cl=unifrnd(0,1,1,3);
        scatter(c(i,3),c(i,4),'filled',...
            'MarkerFaceColor',cl,...
            'MarkerEdgeColor',cl)
        tect(c(i,3),c(i,4)+1.5,p(i),'Color',cl,'fontsize',12');
        hold on
    else
         scatter(c(i,3),c(i,4),'filled',...
            'MarkerFaceColor','k',...
            'MarkerEdgeColor','k')
        hold on
    end
end
f1=line([29.67 29.67],get(gca,'YLim'),'Color','k');
yl=[55.04,55.04];
f2=plot(get(gca,'clim'),yl,'k:','LineWidth',1.5);
legend([f1 f2],'????','????')

for i=1:40
    if  c(i,3)>mean(c(:,3)) && c(i,4)>mean(c(:,4))
        cl=unifrnd(0,1,1,3);
        scatter(c(i,3),c(i,4),'filled',...
            'MarkerFaceColor',cl,...
            'MarkerEdgeColor',cl)
        tect(c(i,3),c(i,4)+1.5,num2str(i),'Color',cl,'fontsize',12');
        hold on
    else
         scatter(c(i,3),c(i,4),'filled',...
            'MarkerFaceColor','k',...
            'MarkerEdgeColor','k')
        hold on
    end
end
f1=line([29.67 29.67],get(gca,'YLim'),'Color','k');
yl=[55.04,55.04];
f2=plot(get(gca,'clim'),yl,'k:','LineWidth',1.5);
legend([f1 f2],'????','????')

line([55.04;55.04],get(gca,'cLim'),'Color','b')


yl=[55.04,55.04];
plot(get(gca,'clim'),yl,'k:','LineWidth',1.5);
yl=[29.67;29.67];
plot(get(gca,'ylim'),yl,'k:','LineWidth',1.5);
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

