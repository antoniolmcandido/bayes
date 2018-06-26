function predicados = bayesTeste(dadosTeste, classes, priori, media, matrizesCovariancia, opcao)
    
    [linhas, colunas] = size(dadosTeste);
    nClasses = length(classes); % number of classes
    %ns = length(dTe); % test set
    
    %% verossimilhança e probabilidades a posteriori
    switch opcao
        % matriz de covariância diferentes e prioris diferentes
        case 1          
            for i = 1:nClasses
                if (rcond(matrizesCovariancia(:,:,i)) < 1e-12)
                    matrizesCovariancia(:,:,i) = matrizesCovariancia(:,:,i) + (0.01 * eye(colunas));
                end
                fu = mvnpdf(dadosTeste,media(i,:),matrizesCovariancia(:,:,i));
                F(i,:) = priori(:,i) .* fu;
            end
        % matriz de covariância diagonal com mesma variância e prioris diferentes
        case 2 
            for i = 1:nClasses
                fu = mvnpdf(dadosTeste,media(i,:),...
                     diag(diag(ones(colunas))).*.5);
                F(i,:) = priori(:,i) .* fu;
            end
        % matriz de covariância diagonal com mesma variância e equiprovável
        case 3 
            priori = ones(1, nClasses)./nClasses;
            for i = 1:nClasses
                fu = mvnpdf(dadosTeste,media(i,:),...
                     diag(diag(ones(colunas))).*.5);
                F(i,:) = priori(:,i) .* fu;
            end
        case 4 % equiprovável e matriz de covariância diferentes
            priori = ones(1, nClasses)./nClasses;
            for i = 1:nClasses
                if (rcond(matrizesCovariancia(:,:,i)) < 1e-12)
                    matrizesCovariancia(:,:,i) = matrizesCovariancia(:,:,i) + (0.01 * eye(colunas));
                end
                fu = mvnpdf(dadosTeste,media(i,:),matrizesCovariancia(:,:,i));
                F(i,:) = priori(:,i) .* fu;
            end
        % caso geral, matriz de covariância diferentes e prioris diferentes
        otherwise 
            ...
    end

    % predicado
    [pv0,predicados] = max(F);
    for i=1:length(linhas)
        pv(i,1) = classes(predicados(i));
    end

end