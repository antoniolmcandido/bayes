function [classes, priori, media, matrizesCovariancia] = bayesTreino(dadosTreino, rotulosTreino)
    
    % qquantidade de classes
    classes = unique(rotulosTreino);
    nClasses = length(classes);
    
    % calculando priori
    for i = 1:nClasses
        priori(i) = sum(double(rotulosTreino == classes(i)))/length(rotulosTreino);
    end
    
    % calculando medias e matrizes de covariancias
    for i = 1:nClasses
        atributo = dadosTreino((rotulosTreino == classes(i)),:);
        media(i,:) = mean(atributo,1);
        matrizesCovariancia(:,:,i) = cov(atributo,1);
    end

end