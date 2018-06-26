function acuracia = calculaAcuracia(predicao, rotulosTeste)
    acertos = 0;
    qtdPadroes = size(rotulosTeste, 1);
    
    for i = 1:qtdPadroes
        if rotulosTeste(i) == predicao(i)
            acertos = acertos + 1;
        end   
    end
    acuracia = acertos / qtdPadroes * 100;
end

