function plotaDesvioPadrao(realizacoes, desvioPdrao)
    desvioPadraoMedio = mean(desvioPdrao);
        
    y = linspace(0,realizacoes);
    h = figure; 
    plot(desvioPdrao, '--bo',...
        'LineWidth',2,...
        'MarkerSize',10,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5]); 
    hold on
    plot(y,desvioPadraoMedio, '-*r');  
    xlabel('Realizações','FontSize',10);
    ylabel('Desvio Padrão','FontSize',10);
    grid on
    legend('Desvio Padrão','Média',...
        'Location','northoutside','Orientation','horizontal')
end