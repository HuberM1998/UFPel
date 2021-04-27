function img_resultante = leucocitos(imagem)
%Lendo a imagem.
le_img = imread(imagem);
%Transformando a imagem em double, para fazer a multiplica��o pela m�scara
%binaria.
le_imgdb = double(le_img);
%Passando a imagem para escala de cinza.
le_gray = rgb2gray(le_imgdb);
%Ajustando o contraste da imagem em cinza.
le_ajust = imadjust(le_gray);
%Achando o thresholder.
level = graythresh(le_ajust);
%Binarizando a imagem.
bin_leucocitos = im2bw(le_ajust, level);
%Transformando a m�scara em double.
bin_leucocitos = double(bin_leucocitos);
%Multiplicando cada canal de cor da imagem pela sua m�scara binaria.
le_imgdb(:,:,1) = le_imgdb(:,:,1).*bin_leucocitos;
le_imgdb(:,:,2) = le_imgdb(:,:,2).*bin_leucocitos;
le_imgdb(:,:,3) = le_imgdb(:,:,3).*bin_leucocitos;
le_imgdb = uint8(le_imgdb);
%Obtendo o canal de cor vermelho da imagem p�s ser multiplicada pela sua
%equivalente em binario.
R = le_imgdb(:,:,1);
G = le_imgdb(:,:,2);
B = le_imgdb(:,:,3);
%Aqui, usei a fun��o max(max) e min(min) para achar o menor e o maior valor
%de cada pixel no canal de cor vermelho, o motivo disso foi de fato para
%achar o melhor delta para cada imagem, de forma que algumas tem a
%tonalidade mais forte necessitando de um delta maior para conseguir
%encontrar a c�lula inteira, por outro lado, usando o mesmo delta em
%imagens com tonalidade menor, obtem-se c�lulas indesejadas na segmenta��o.
maior = max(max(R));
menor = min(min(R));
%Posteriormente, foi usado um condicional, para que caso a imagem tenha
%tonalidades menores, seja usado um delta menor, e delta maior para
%tonalidades maiores.
    if maior <= 222 || menor == 50
        delta = R < 120;
    else
       delta = R < 170;
    end
%Achando o tamanho do delta (nossa imagem segmentada);    
[lin, col] = size(delta);
%Tornando-a bin�ria.
bin = im2bw(delta, level);
%Nota-se que algumas imagens aparecem leuc�citos grandes, e em outros casos
%menores c�lulas, nas maiores a imagem pega alguns res�duos de cor, ou
%algum tipo de ru�do inconveniente, de forma que se aplicarmos uma opera��o
%morfol�gica conseguimos retirar, por�m se isso for feito em todas as
%imagens, acabamos tendo erros em imagens pequenas, pois o algoritmo vai
%entender as pequenas c�lulas como ru�do e acabar eliminando elas. De forma
%a resolver esse problema, criei um contador de �rea, � not�vel que as
%c�lulas grandes possuem mais �rea de pixels que as imagens com c�lulas
%menores, dessa forma, contamos a �rea da imagem para posteriormente fazer
%um condicional que se a imagem for grande, aplicamos um processo
%morfol�gico de fechamento e eliminamos ru�dos e pequenos buracos, e se ela
%for pequena dilatamos ela de forma a observar melhor as c�lulas.
  area = 0;
    for i=1: lin
        for j=1: col
            if (bin(i,j)==1)
                area = area + 1;
            end
        end
    end
result = area;
%Aqui ca�mos no condicional das celulas pequenas. OBS: esse n�mero foi
%encontrado atrav�s de testes emp�ricos.
    if(result < 20092);    
%Crio um elemento de estrutura, em forma de disco, com raio 2.
    se = strel('disk', 2);
%Aqui usamos a fun��o para dilatar a imagem.
    dil = imdilate(delta, se);
%Usamos a fun��o para eliminar ru�dos e elementos pequenos demais que podem ter sido formados pelo efeito da dilata��o, onde a fun��o bwareaopen elimina pixels com raio menor que 100.    
    dil = bwareaopen(dil, 100);
%Usamos o bwlabel para contar o n�mero de objetos da imagem.    
    [L, num] = bwlabel(dil, 4);
%A vari�vel leucocitos recebe o valor dado pelo bwlabel.
    leucocitos = num;
%Recebemos a imagem obtido pelo processo acima, para posteriormente
%multiplicar pelos canais de cores r, g, b, de forma a tornar a imagem
%colorida novamente.
    mask = dil;
%Tranformamos a masc�ra em escala double.
    mask = double(mask);
%Transformamos a imagem em escala double.
    le_imgdb = double(le_imgdb);
%Multiplicamos a imagem pela masc�ra para tornala colorida.
    le_imgdb(:,:,1) = le_imgdb(:,:,1).*mask;
    le_imgdb(:,:,2) = le_imgdb(:,:,2).*mask;
    le_imgdb(:,:,3) = le_imgdb(:,:,3).*mask;
%Passamos a imagem para inteiro 8 bits sem sinal.
    le_imgdb = uint8(le_imgdb);
%Mostramos a imagem obtida pelo processo de segmenta��o lado a lado com a
%imagem original atrav�s da fun��o imshowpair.
    figure; imshowpair(le_img, le_imgdb, 'montage');
%Aqui entramos no caso das imagens com c�lulas grandes.
    else
    S = strel('disk', 4);
%Aplicamos o processo morfol�gico de fechamento, de forma a fechar buracos
%na imagem.
    fec = imclose(delta, S);
%Usamos a fun��o bwareaopen para eliminar elementos menores que 500 pixels
%na imagem, de forma a deixar apenas as c�lulas e retirar qualquer tipo de
%apari��o avulsa de cor da c�lula.
    fec = bwareaopen(fec, 500);
%Aplicamos um filtro para retirar o ru�do.
    fec = imfill(fec, 'holes');
%Usamos a fun��o bwlabel para contar o n�mero de objetos na imagem.
    [L, cont] = bwlabel(fec, 4);
%A vari�vel leucocitos recebe o n�mero de objetos na imagem.
    leucocitos = cont;
%Recebemos a imagem obtido pelo processo acima, para posteriormente
%multiplicar pelos canais de cores r, g, b, de forma a tornar a imagem
%colorida novamente.
    mask = fec;
%Tranformamos a masc�ra em escala double.
    mask = double(mask);
%Transformamos a imagem em escala double.
    le_imgdb = double(le_imgdb);
%Multiplicamos a imagem pela masc�ra para tornala colorida.
    le_imgdb(:,:,1) = le_imgdb(:,:,1).*mask;
    le_imgdb(:,:,2) = le_imgdb(:,:,2).*mask;
    le_imgdb(:,:,3) = le_imgdb(:,:,3).*mask;
%Passamos a imagem para inteiro 8 bits sem sinal.
    le_imgdb = uint8(le_imgdb);
%Mostramos a imagem obtida pelo processo de segmenta��o lado a lado com a
%imagem original atrav�s da fun��o imshowpair.
    figure; imshowpair(le_img, le_imgdb, 'montage');
    end
%Mostramos na tela o n�mero de leuc�citos obtidos.
   fprintf('\t Total de leuc�citos: %d\n', leucocitos);
end