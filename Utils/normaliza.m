function dados = normaliza(dados)
    atributos = dados(:,1:end-1);
    rotulos = dados(:,end);

    atributos = atributos - min(atributos);
    atributos = atributos ./ (max(atributos) - min(atributos));
    
    dados = [atributos rotulos]; 
end