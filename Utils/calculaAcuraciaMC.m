function acuracia = calculaAcuracia(predicados, rotulosTeste)
       
    matrizConfusao = confusionmat(rotulosTeste,predicados);
    cm = matrizConfusao./sum(matrizConfusao(:));
    acuracia = (trace(cm) / sum(cm(:))) * 100;    
end

