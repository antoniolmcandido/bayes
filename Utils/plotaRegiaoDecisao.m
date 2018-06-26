function plotaRegiaoDecisao(dados, opcao)
        
    percentualTreino = 0.8;
    
    % colorindo
    cmap2 = jet(3);
    cmap2 = cmap2*0.8;
    cmap1 = (cmap2 + 0.6) * 1.2;
    cmap1(cmap1 > 1) = 1;
    
    %% tamanho da base    
    minX = min(dados(:, 1));
    maxX = max(dados(:, 1));
    minY = min(dados(:, 2));
    maxY = max(dados(:, 2));
    
    %% Passo
    passoX = (maxX - minX) *.01;
    passoY = (maxY - minY) *.01;
    %inc = 0.005;
    
    x1 = minX:passoX:maxX;
    x2 = minY:passoY:maxY;
    
    [X, Y] = meshgrid(x1, x2);
    
    %% Concatencao
    regiao = [X(:), Y(:)];
    atributos = size(regiao, 2);
    
    dados = normaliza(dados);
    
    dados = embaralha(dados);

    [dadosTreino, rotulosTreino, ~, ~] = separa(dados, percentualTreino);

    p = combnk(1:size(dadosTreino,2),2);
    p = sortrows(p);

    for k = 1:size(p,1)

        treino = dadosTreino(:,p(k,:));

        [classes, priori, media, matrizesCovariancia] = bayesTreino(treino, rotulosTreino);

        nClasses = length(classes); % number of classes

        %% calculando funções de verossimilhança ...
            % e probabilidades a posteriori
        switch opcao
            % caso geral, matriz de covariância ...
                    % diferentes e prioris diferentes
            case 1 
                for i = 1:nClasses
                    fu = mvnpdf(regiao,media(i,:),matrizesCovariancia(:,:,i));
                    F(i,:) = priori(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e prioris diferentes
            case 2 
                for i = 1:nClasses
                    fu = mvnpdf(regiao,media(i,:),...
                         diag(diag(ones(atributos))).*.5);
                    F(i,:) = priori(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e equiprovável
            case 3 
                priori = ones(1, nClasses)./nClasses;
                for i = 1:nClasses
                    fu = mvnpdf(regiao,media(i,:),...
                         diag(diag(ones(atributos))).*.5);
                    F(i,:) = priori(:,i) .* fu;
                end
            case 4 % equiprovável e matriz de covariância diferentes
                priori = ones(1, nClasses)./nClasses;
                for i = 1:nClasses
                    fu = mvnpdf(regiao,media(i,:),matrizesCovariancia(:,:,i));
                    F(i,:) = priori(:,i) .* fu;
                end
            otherwise 
                ...
        end
        
        [~,predicados] = max(F);
        
        h = figure;
        scatter(regiao(:,1), regiao(:,2), 40, cmap1(predicados,:), 'filled');
        hold on;
        scatter(treino(:,1), treino(:,2), 80, cmap2(rotulosTreino',:), 'filled');
    end 
end
