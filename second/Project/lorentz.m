clear; clc; close all;
for k=[2 4 6 8]
    data=readmatrix("gini_plot.xlsx",Sheet="2020");
    
    NumArr=data(:,k)';
    
    NumArrSorted=sort([0,NumArr]);
    
    NumArrPercent=NumArrSorted/sum(NumArrSorted);
    
    NumArrSortedLen=length(NumArrSorted);
    
    NumArrAcc=zeros(1,NumArrSortedLen);
    
    for i=1:NumArrSortedLen
    
    NumArrAcc(i)=sum(NumArrPercent(1:i));
    
    end
    
    x1=linspace(0,1,NumArrSortedLen);
    
    x2=0:(1/NumArrSortedLen/10):1;
    
    cfithandle=fit(x1',NumArrAcc','smoothingspline');
    
    d=cfithandle(x2);
    
    % 生产图形
    
    hold on
    plot(x1,x1,'b-.',x1,NumArrAcc,'o',x2,d,'-')
    
    plot([0,1],[0,1],x1,NumArrAcc,'-s',MarkerEdgeColor='auto')
     
    title('洛伦兹曲线')
    
    xlabel('人口累计')
    
    ylabel('卫生资源累计')
    
    axis equal
    axis([0,1,0,1])
   grid on
    
end
