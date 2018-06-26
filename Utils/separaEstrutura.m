function [dadosTreino, dadosTeste] = separaEstrutura(dados, percentualTreino)
    %% computa quantidade de linhas e colunas da base
    [linhas, colunas] = size(dados);	

    %% separa grupo de Treino (de acordo com o percentual)
    dadosTreinoGeral = dados(1:linhas * percentualTreino,:);
    
    %% separa grupo de Teste
    dadosTesteGeral = dados((linhas * percentualTreino) + 1 : linhas,:);
    
    %% separa padroes e rotulos do Treino
    dadosTreino.x = dadosTreinoGeral(:,1:colunas-1);
    dadosTreino.y = dadosTreinoGeral(:,colunas);
        
    %% separa padroes e rotulos do Teste
    dadosTeste.x = dadosTesteGeral(:,1:colunas-1);
    dadosTeste.y = dadosTesteGeral(:,colunas);    
end