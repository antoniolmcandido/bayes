function dados = embaralha(dados)
    
    dados = dados(randperm(length(dados)),:);
end