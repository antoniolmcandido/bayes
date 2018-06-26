function [dadosCentroides,rotulosCentroides] = capturaCentroides(dadosTreino, rotulosTreino)

    [linhas colunas] = size(dadosTreino);

    classes=unique(rotulosTreino);
    nClasses=length(classes);
    
    dadosCentroides = zeros(nClasses, colunas);
    rotulosCentroides = zeros(nClasses,1);
    for i = 1:nClasses
        atributo = dadosTreino((rotulosTreino == classes(i)),:);
        ck = size(atributo,1);
        dadosCentroides(i, :) = (1/ck) * sum(atributo);
        rotulosCentroides(i) = classes(i);
    end
end