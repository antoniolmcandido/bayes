function [dadosTreino, rotulosTreino, dadosTeste, rotulosTeste] = separa(dados, percentualTreino)
    %% computa quantidade de linhas e colunas da base
    [linhas, colunas] = size(dados);	

    %% separa grupo de Treino (de acordo com o percentual)
    dadosTreino = dados(1:linhas * percentualTreino,:);
    
    %% separa grupo de Teste
    dadosTeste = dados((linhas * percentualTreino) + 1 : linhas,:);
    
    %% separa padroes e rotulos do Treino
    rotulosTreino = dadosTreino(:,colunas);
    dadosTreino = dadosTreino(:,1:colunas-1);
    
    %% separa padroes e rotulos do Teste
    rotulosTeste = dadosTeste(:,colunas);
    dadosTeste = dadosTeste(:,1:colunas-1);
end