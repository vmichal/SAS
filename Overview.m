% A3B31TES, cvièení è. 1, úvod do Matlabu a vykreslování základních signálù
 
% èasovı odhad: celkem 30 minut
 
% ZÁKLADNÍ VİPOÈTY
2 + 3*4     % normální kalkulaèka, vısledek 14
[2, 1; 1, 2] .* [1 2; 3 4]  % .* násobí první prvek s prvním,
                            % druhı s druhım...
% kurzorová šipka nahoru - napíše poslední pøíkaz, staèí umazat teèku
[2, 1; 1, 2] * [1 2; 3 4]   % prvky na øádku oddìlujeme mezerou nebo
                            % èárkou, øádky støedníkem
 
A = ans;  % Pokud ukonèíme øádek støedníkem, nezobrazí se vıstup - vhodné
          % pro programování.  V ans je vdy poslední vısledek.
          % = je operátor pøiøazení pravé strany do strany levé,
          % nejedná se o rovnici. Rozlišují se velikosti písmen! Promìnná
          % 'a' v tuto chvíli neexistuje. Promìnná musí zaèínat písmenem,
          % mohou následovat i èísla, podtrítka.
 
2*A
A + 1
 
A.' % transpozice. Pozor! Existuje operátor A' - ten dìlá také transpozici,
    % ale s komplexnì sdruenımi èísly (opaèné znaménko u imaginární èásti),
    % na reálná èísla to tedy nemá vliv, na komplexní ano!
 
 
sum(A)   % vstup je matice, seète hodnoty v kadém sloupci zvláš
 
sum(ans) % vstup je jednoøádková matice, seète prvky, vısledkem je jedno èíslo
 
% jiná monost seètení všech prvkù v matici
A(:)        % z matice udìlá vektor (jede postupnì po sloupcích shora dolù)
sum(A(:))   % souèet všech prvù v matici
 
det(A)   % determinant
inv(A)   % inverzní matice
 
A(2, 1) % prvek na 2. øádku v 1. sloupci
 
A(2, 3) = 5  % matice se automaticky zvìtší
 
rref(A) % Gaussova eliminace - øešení rovnic 
 
size(A)    % rozmìry [øádky sloupce]
size(A, 2) % poèet sloupcù
length(A)  % nejdelší rozmìr
 
%%%%% 15 minut
 
 
% OPERÁTOR :
1: 10     % vygeneruje vektor 1 a 10
1: 2: 11  % 1 a 11 s krokem 2
7: -1: 0  % zápornı pøírùstek
sin(0: pi/4: pi)  % mnoho funkcí umí poèítat s vektorem vstupních èísel
 
help sin  % základní nápovìda k funkci sin
doc sin   % rozšíøená nápovìda
 
linspace(1, 10, 10)   % 10 èísel od 1 do 10
linspace(1, 10, 20)   % 20 èísel, pro nìkteré šok, e krok není 0.5,
                      % to bychom obdreli jen 19 èísel :-)
% Pokud píšeme dlouhı název funkce nebo promìnné, staèí napsat prvních
% nìkolik znakù a stisknout TAB.
logspace(0, 2, 20)  % 20 hodnot 10^0 a 10^2, logaritmicky rozdìleno
                    % (stejnı poèet hodnot na dekádu (desetinásobek hodnoty)).
 
 
A(1: 2, 2)   % øádky 1 a 2 druhého sloupce
A(:, end)    % všechny øádky (samostatná dvojteèka) posledního sloupce
A([2 1], :)  % 2. øádek, a pak 1., všechny sloupce
A(:, 1) = [] % smazání všech øádkù prvního sloupce
 
sum = rand(1, 10) % náhodná èísla (šum), právì jsme si zrušili funkci sum :-(
mean(sum) % støední hodnota (prùmìr)
sum(1:5) % prvních 5 prvkù matice sum v poøadí po sloupcích shora dolù
clear    % zruší promìnné, funkce sum opìt funguje
sum(1:5) % souèet 1 a 5
 
clc % smae celou obrazovku
 
B = zeros(3, 3)  % matice nul, tøi øádky a tøi sloupce
C = 5*ones(3, 3) % matice jednièek vynásobená konstantou 5
 
D = [B; C] % spojení matic - dolù pod sebe
E = [B C] % spojení matic - doprava vedle sebe
 
 
help        % celková nápovìda rozdìlená do kategorií
help ops    % pøehled operátorù
help elfun  % elementární funkce
help elmat  % elementární funkce zamìøené na matice
 
 
% Seznam promìnnıch je v oknì Workspace,
% pøípadnì menu Desktop, Workspace.