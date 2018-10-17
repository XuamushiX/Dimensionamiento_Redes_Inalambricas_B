%==========================================================================
% Autor: Mstr. Esteban Inga Ortega
% 02-05-2016
%==========================================================================
%clc; clear all; close all
load escenario.mat
fid = fopen('wlan_cobertura_capacidad1.csv', 'r');
tline = fgetl(fid); 
tline = fgetl(fid);
ind=1;
%Reading of the results from LPSOLVE
while 1
    tline = fgetl(fid);
    if ~ischar(tline),
        break,
    end
    array=split(tline,';');% Símbolo de Tabulación
    if str2num(array{end})>0
        data{ind}=array{1};
        value(ind)=str2num(array{end});
        ind=ind+1;
    end
end
fclose(fid);
%====================================================================
for i=1:length(value)
     
    temp=split(data{i},'_');% Símbolo de división luego de la letra "Z"
    if temp{1}=='Z'
    n1=str2num(char(temp(2)));%Obtengo el segundo valor junto a "Z"
    %n2=str2num(char(temp(3))); %Esto ya no se usa porque LPSolve solo
    %entrega los valores de Z
    sln(i)=[n1]
    %sln=sln'

    end
end
load escenario;
escenario.sln=sln;
graficar_escenario_wlan(escenario);
%==========================================================================
print -dpng -r800 optimal_cap_cob
print -depsc -r450 optimal_cap_cob
