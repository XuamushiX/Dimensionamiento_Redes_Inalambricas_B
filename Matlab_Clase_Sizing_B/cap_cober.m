clc; clear all; close all; 
fid = fopen('wlan_cobertura_capacidad1.lp', 'w');
%fprintf('%6.2f %12.8f\n', y);
R=8; 
Cap=2; 
Porc=0.9;
%x=(rand(N,1))*200; 
%y=(rand(N,1))*200;
x=[60.071275, 62.623340, 66.376377, 65.926012, 59.320668, 62.773461, 60.671761, 63.824312, 65.926012, 68.628199, 71.930871, 74.032571, 73.882450, 73.882450, 68.778320, 68.628199, 71.630628];
y=[53.536022, 53.381810, 53.381810, 56.311824, 55.849191, 56.003402, 57.391303, 57.391303, 58.008148, 53.536022, 52.919177, 52.919177, 54.769712, 57.699726, 57.545514, 55.386557, 55.694979];
N=length(x); 

xs=[59.620911, 63.524069, 66.526498, 66.526498, 63.073704, 59.620911, 59.771032, 63.073704, 66.526498, 67.577348, 71.480506, 74.633057, 74.633057, 72.381235, 67.577348, 68.177834, 71.330385, 74.633057];
ys=[52.610754, 52.764965, 52.610754, 55.849191, 55.540768, 55.386557, 57.853937, 57.545514, 57.853937, 52.456543, 52.456543, 52.456543, 55.540768, 55.540768, 55.386557, 58.162359, 57.853937, 57.853937];

M=length(xs);
for i=1:M; 
    for j=1:N
        dist(i,j)=sqrt((xs(i)-x(j))^2+(ys(i)-y(j))^2); 
    end
end
clc
fprintf(fid, 'min: ');
for j=1:M
    fprintf(fid, '+Z_%d',j); 
end
fprintf(fid, ';\n'); 

fprintf(fid, 'min_num_usuarios_conectados: ');
for j=1:N
    fprintf(fid, '+Y_%d',j); 
end
fprintf(fid, '>=%f;\n',Porc*N); 

for j=1:N
    %Ecuacion de restriccion de conexion de cada usuario
    fprintf(fid, 'USUARIO%d: Y_%d=',j,j); 
    for i=1:M
        fprintf(fid, '+X_%d_%d',i,j);
    end
    fprintf(fid, ';\n');
end
%RESTRICCION DE CAPACIDAD DE LAS ESTACIONES BASE
for i=1:M
    fprintf(fid, 'CAPACIDAD_AP_%d: ',i);
    for j=1:N
        fprintf(fid, '+X_%d_%d',i,j);
    end
    fprintf(fid, '<=%f * Z_%d;\n',Cap,i);
end

%RESTRICCION DE CONECTIVIDAD SI EXISTE COBERTURA Y ACTIVIDAD EN EL SITIO i
for i=1:M
    for j=1:N
        if dist(i,j)<=R
            fprintf(fid, 'COBERTURA_AP_%d_USUARIO_%d: X_%d_%d<=Z_%d;\n',i,j,i,j,i); 
        else
            fprintf(fid, 'COBERTURA_AP_%d_USUARIO_%d: X_%d_%d<=0;\n',i,j,i,j); 
        end
    end
end
fprintf(fid, 'binary '); 
for i=1:M
    for j=1:N
        fprintf(fid, 'X_%d_%d, ',i,j); 
    end
end
for i=1:N
    fprintf(fid, 'Y_%d, ',i); 
end
for i=1:(M-1)
    fprintf(fid, 'Z_%d, ',i); 
end
fprintf(fid, 'Z_%d;\n',M); 
fclose(fid);

%Para poder graficar luego
escenario.x=x; escenario.y=y; escenario.xs=xs; escenario.ys=ys; escenario.R=R; 
escenario.dist=dist; 
graficar_escenario_wlan(escenario); 
print -dpng -r800 grafo_cap_cob_original
print -depsc -r800 grafo_cap_cob_original

save escenario.mat escenario; 

