% A3B31TES, cvi�en� �. 1, �vod do Matlabu a vykreslov�n� z�kladn�ch sign�l�
 
% �asov� odhad: celkem 30 minut
 
% Z�KLADN� V�PO�TY
2 + 3*4     % norm�ln� kalkula�ka, v�sledek 14
[2, 1; 1, 2] .* [1 2; 3 4]  % .* n�sob� prvn� prvek s prvn�m,
                            % druh� s druh�m...
% kurzorov� �ipka nahoru - nap�e posledn� p��kaz, sta�� umazat te�ku
[2, 1; 1, 2] * [1 2; 3 4]   % prvky na ��dku odd�lujeme mezerou nebo
                            % ��rkou, ��dky st�edn�kem
 
A = ans;  % Pokud ukon��me ��dek st�edn�kem, nezobraz� se v�stup - vhodn�
          % pro programov�n�.  V ans je v�dy posledn� v�sledek.
          % = je oper�tor p�i�azen� prav� strany do strany lev�,
          % nejedn� se o rovnici. Rozli�uj� se velikosti p�smen! Prom�nn�
          % 'a' v tuto chv�li neexistuje. Prom�nn� mus� za��nat p�smenem,
          % mohou n�sledovat i ��sla, podtr��tka.
 
2*A
A + 1
 
A.' % transpozice. Pozor! Existuje oper�tor A' - ten d�l� tak� transpozici,
    % ale s komplexn� sdru�en�mi ��sly (opa�n� znam�nko u imagin�rn� ��sti),
    % na re�ln� ��sla to tedy nem� vliv, na komplexn� ano!
 
 
sum(A)   % vstup je matice, se�te hodnoty v ka�d�m sloupci zvl᚝
 
sum(ans) % vstup je jedno��dkov� matice, se�te prvky, v�sledkem je jedno ��slo
 
% jin� mo�nost se�ten� v�ech prvk� v matici
A(:)        % z matice ud�l� vektor (jede postupn� po sloupc�ch shora dol�)
sum(A(:))   % sou�et v�ech prv� v matici
 
det(A)   % determinant
inv(A)   % inverzn� matice
 
A(2, 1) % prvek na 2. ��dku v 1. sloupci
 
A(2, 3) = 5  % matice se automaticky zv�t��
 
rref(A) % Gaussova eliminace - �e�en� rovnic 
 
size(A)    % rozm�ry [��dky sloupce]
size(A, 2) % po�et sloupc�
length(A)  % nejdel�� rozm�r
 
%%%%% 15 minut
 
 
% OPER�TOR :
1: 10     % vygeneruje vektor 1 a� 10
1: 2: 11  % 1 a� 11 s krokem 2
7: -1: 0  % z�porn� p��r�stek
sin(0: pi/4: pi)  % mnoho funkc� um� po��tat s vektorem vstupn�ch ��sel
 
help sin  % z�kladn� n�pov�da k funkci sin
doc sin   % roz���en� n�pov�da
 
linspace(1, 10, 10)   % 10 ��sel od 1 do 10
linspace(1, 10, 20)   % 20 ��sel, pro n�kter� �ok, �e krok nen� 0.5,
                      % to bychom obdr�eli jen 19 ��sel :-)
% Pokud p�eme dlouh� n�zev funkce nebo prom�nn�, sta�� napsat prvn�ch
% n�kolik znak� a stisknout TAB.
logspace(0, 2, 20)  % 20 hodnot 10^0 a� 10^2, logaritmicky rozd�leno
                    % (stejn� po�et hodnot na dek�du (desetin�sobek hodnoty)).
 
 
A(1: 2, 2)   % ��dky 1 a� 2 druh�ho sloupce
A(:, end)    % v�echny ��dky (samostatn� dvojte�ka) posledn�ho sloupce
A([2 1], :)  % 2. ��dek, a pak 1., v�echny sloupce
A(:, 1) = [] % smaz�n� v�ech ��dk� prvn�ho sloupce
 
sum = rand(1, 10) % n�hodn� ��sla (�um), pr�v� jsme si zru�ili funkci sum :-(
mean(sum) % st�edn� hodnota (pr�m�r)
sum(1:5) % prvn�ch 5 prvk� matice sum v po�ad� po sloupc�ch shora dol�
clear    % zru�� prom�nn�, funkce sum op�t funguje
sum(1:5) % sou�et 1 a� 5
 
clc % sma�e celou obrazovku
 
B = zeros(3, 3)  % matice nul, t�i ��dky a t�i sloupce
C = 5*ones(3, 3) % matice jedni�ek vyn�soben� konstantou 5
 
D = [B; C] % spojen� matic - dol� pod sebe
E = [B C] % spojen� matic - doprava vedle sebe
 
 
help        % celkov� n�pov�da rozd�len� do kategori�
help ops    % p�ehled oper�tor�
help elfun  % element�rn� funkce
help elmat  % element�rn� funkce zam��en� na matice
 
 
% Seznam prom�nn�ch je v okn� Workspace,
% p��padn� menu Desktop, Workspace.