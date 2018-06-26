% limpa terminal, limpa memoria, fecha janelas e nao imprime avisos
clc; clear all; close all; warning('off');

addpath('../Datasets/');
addpath('../Utils/');

dados = importdata('iris.mat');
% dados = importdata('coluna2c.mat');
% dados = importdata('coluna3c.mat');
% dados = importdata('dermatology.mat');
% dados = importdata('cancer.mat');

dados = normaliza(dados);
percentualTreino = 0.8;
realizacoes = 30;
iteracoes = 100;

for i  = 1:realizacoes    
    acuraciaAnterior = 0;
    
    for j = 1:iteracoes
        dados = embaralha(dados);
        
        [dadosTreino, rotulosTreino, dadosTeste, rotulosTeste] = separa(dados, percentualTreino);
        
        [classes, priori, media, matrizesCovariancia] = bayesTreino(dadosTreino, rotulosTreino);
        
        predicados = bayesTeste(dadosTeste, classes, priori, media, matrizesCovariancia, 1);
        
        acuracia(j) = calculaAcuracia(predicados, rotulosTeste);
        
        % guardando a melhor matriz de confusao
        if (acuracia(j) > acuraciaAnterior)
            melhorMatrizConfusao = confusionmat(predicados, rotulosTeste);
        end
        acuraciaAnterior = acuracia(j);
    end
    todasMatrizConfusao(:,:,i) = melhorMatrizConfusao;
    mediasAcuracia(i) = mean(acuracia);
    desviosAcuracia(i) = std(acuracia);
    
    fprintf('--------------------------------------------------\n');
    fprintf('REALIZAÇÃO %d\n', i);
    fprintf('Acuracias de %d Iteracoes: \n', iteracoes);
    fprintf('Acuracia Maxima: %.2f%%. \n', max(acuracia));
    fprintf('Acuracia Media:  %.2f%%. \n', mean(acuracia));
    fprintf('Acuracia minima: %.2f%%. \n', min(acuracia));
    fprintf('Desvio Padrao: %.2f. \n', std(acuracia));
    fprintf('Melhor Matriz Confusao\n');
    disp(todasMatrizConfusao(:,:,i));
end
% plotaIris(dados);
% plotaPDF(dados, 1);
% plotaRegiaoDecisaoBayes(dados, 1);
plotaAcuracia(realizacoes, mediasAcuracia);
plotaDesvioPadrao(realizacoes, desviosAcuracia);