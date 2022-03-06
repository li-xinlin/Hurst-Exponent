%Calculate hurst_exponent
function HE=hurst_exponent(aaldata)
%import data
data=aaldata;

N=length(data);
m=[2,3,4,6,8,12,16,24,32];
for i = 1:9
    % Calculate the sub-periods
    a=floor(N/m(i));
    
    % Make the sub-periods matrix
    X=reshape(data(1:m(i)*a),m(i),a);
    
    % Estimate the mean of each sub-period
    ave=mean(X);
    
    % Remove the mean from each sub-period
    cumdev=X-ones(m(i),1)*ave;
    
    % Estimate the cumulative deviation from the mean
    cumdev=cumsum(cumdev);
    
    %Standard Deviation
    S=std(X,1);
    
    % Estiamte the rescaled range
    RS=(max(cumdev)-min(cumdev))./S;
    
    % Calculate R/S statistic
    Q(i)=mean(RS);
    
    n(i)=m(i);
end
fit=polyfit(log(n),log(Q),1);
% plot(log(n),log(Q),'bo')
% hold on
%result
HE=fit(1);
% plot(log(n),polyval(fit,log(n)),'r-',log(n),.5*log(n),'g--','LineWidth',2)
% legend('R/S','Hurst Line', 'Normal Line','Location','North')
end