function predicados = converteRotulo(predicadosOutroPadrao, rotulosTreino)

    classes=unique(rotulosTreino);

    predicados = zeros(size(predicadosOutroPadrao,1),1);
    for coluna = 1:size(predicadosOutroPadrao,2)
        for linha = 1:size(predicadosOutroPadrao,1)
            if predicadosOutroPadrao(linha,coluna) == 1
                predicados(linha,1) = classes(coluna);
            end
        end
    end
end