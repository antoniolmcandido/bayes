function plotaAcuracia(realizacoes, acuracia)
    acuraciaMedia = mean(acuracia);
        
    y = linspace(0,realizacoes);
    h = figure; 
    plot(acuracia, '--bo',...
        'LineWidth',2,...
        'MarkerSize',10,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5]); 
    hold on
    plot(y,acuraciaMedia, '-*r');  
    xlabel('Realizações','FontSize',10);
    ylabel('Acurácia','FontSize',10);
    grid on
    legend('Acurácia','Média',...
        'Location','northoutside','Orientation','horizontal')
end