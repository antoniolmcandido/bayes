function plotaPDF(dados,opcao)
       
    percentualTreino = 0.8;
    
    cores = jet(3);
    cor = jet(10);
    
    minX = min(dados(:, 1));
    maxX = max(dados(:, 1));
    minY = min(dados(:, 2));
    maxY = max(dados(:, 2));
    
    passoX = (maxX - minX) *.01;
    passoY = (maxY - minY) *.01;
    %inc = 0.005;
    
    x1 = minX:passoX:maxX;
    x2 = minY:passoY:maxY;
    
    [X, Y] = meshgrid(x1, x2);
    
    %% juntando
    pdf = [X(:), Y(:)];
    atributos = size(pdf, 2);
    
    dados = normaliza(dados);
    
    dados = embaralha(dados);

    [dadosTreino, rotulosTreino, ~, ~] = separa(dados, percentualTreino);

    p = combnk(1:size(dadosTreino,2),2);
    p = sortrows(p);

    for k = 1:size(p,1)
        treino = dadosTreino(:,p(k,:));
       
        [classes, priori, media, matrizesCovariancia] = bayesTreino(treino, rotulosTreino);

        nClasses = length(classes);
        
        %% calculando funções de verossimilhança ...
            % e probabilidades a posteriori
        switch opcao
            % caso geral, matriz de covariância ...
                    % diferentes e prioris diferentes
            case 1 
                for i = 1:nClasses
                    fu = mvnpdf(pdf,media(i,:),matrizesCovariancia(:,:,i));
                    F(i,:) = priori(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e prioris diferentes
            case 2 
                for i = 1:nClasses
                    fu = mvnpdf(pdf,media(i,:),...
                         diag(diag(ones(atributos))).*.5);
                    F(i,:) = priori(:,i) .* fu;
                end
            % matriz de covariância diagonal ...
                % com mesma variância e equiprovável
            case 3 
                priori = ones(1, nClasses)./nClasses;
                for i = 1:nClasses
                    fu = mvnpdf(pdf,media(i,:),...
                         diag(diag(ones(atributos))).*.5);
                    F(i,:) = priori(:,i) .* fu;
                end
            case 4 % equiprovável e matriz de covariância diferentes
                priori = ones(1, nClasses)./nClasses;
                for i = 1:nClasses
                    fu = mvnpdf(pdf,media(i,:),matrizesCovariancia(:,:,i));
                    F(i,:) = priori(:,i) .* fu;
                end
            otherwise 
                ...
        end

        [v predicados] = max(F);        
        RD = reshape(predicados,[length(X) length(X)]);
        h = figure;
        surf(x1,x2,reshape(v,[length(X) length(X)]), reshape(cores(predicados,:),[length(X) length(X) 3]))       
    end      
end