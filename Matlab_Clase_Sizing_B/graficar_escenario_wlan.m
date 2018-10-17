function graficar_escenario_wlan1(escenario)
    figure(1);
    %======================================================================
    img=imread('ingenieriasp1.png'); K=0.10465;
    if length(escenario.R)==1
        escenario.R=escenario.xs*0+escenario.R;
    end
    H=size(img,1); W=size(img,2);  
    image([0 W*K],[0 H*K], img); 
    hold on;
    %=====================================================================
    z1=plot(escenario.x,escenario.y,'o','markerfacecolor',[0.6 0.6 0.6],'markeredgecolor','r','markersize',4,'linewidth',1.25);
    hold on
    z2=plot(escenario.xs,escenario.ys,'s','markerfacecolor',[1 0.4 0.2],'markeredgecolor','g','markersize',6,'linewidth',1.35); 
    grid on; 
    axis equal; 
    hold on; 
    xc=cos(0:0.01:2*pi+0.01); yc=sin(0:0.01:2*pi+0.01); 
    M=length(escenario.xs); % Longitud de muestras de AP 
    N=length(escenario.x);  % Longitud de muestras de usuarios
    
    % Graficar circunferencias de Cobertura de cada AP
    
    for i=1:M
        
        z3=plot(xc*escenario.R(i)+escenario.xs(i), yc*escenario.R(i)+escenario.ys(i),'-m'); 
%         text(escenario.xs(i), escenario.ys(i),sprintf('\nBS%d',i)); %Texto id
        for j=1:N
%             if i==1
%                 text(escenario.x(j), escenario.y(j),sprintf('us%d',j)); 
%             end
            if escenario.dist(i,j)<=escenario.R
                z4=plot([escenario.xs(i) escenario.x(j)],[escenario.ys(i) escenario.y(j)],'-','color',[0.6 0.6 0.6]);
            end
        end
    end
    hold off; 
    xlabel('Posición en X','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    ylabel('Posición en Y','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    leyenda=legend('Sensores','AP','Cobertura','Enlace Inalámbrico','Location','SE');
    set(leyenda,'FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal')
%===================================================================================================================================
    if isfield(escenario, 'sln')
        figure(2); 
    %===============================================    
    img=imread('ingenieriasp1.png'); K=0.10465;
    if length(escenario.R)==1
        escenario.R=escenario.xs*0+escenario.R;
    end
    H=size(img,1); W=size(img,2);  
    image([0 W*K],[0 H*K], img); 
    hold on;
    %================================================

        z5=plot(escenario.x,escenario.y,'o','markerfacecolor',[0.6 0.6 0.6],'markeredgecolor','r','markersize',5,'linewidth',1.5);
        hold on;
        z6=plot(escenario.xs(escenario.sln),escenario.ys(escenario.sln),'s','markerfacecolor',[1 0.4 0.2],'markeredgecolor','g','markersize',8,'linewidth',1.5);
        grid on; axis equal; hold on; 
        xc=cos(0:0.01:2*pi+0.01); yc=sin(0:0.01:2*pi+0.01); 
        M=length(escenario.xs(escenario.sln)); 
        N=length(escenario.x); 
        for i=1:M
%             fill(escenario.R(i)*1.01*xc+escenario.xs((escenario.sln(i))),escenario.R(i)*1.01*yc+escenario.ys((escenario.sln(i))),[0.83 1 1],'facealpha',0.1); 
            z7=plot(escenario.R(i)*xc+escenario.xs((escenario.sln(i))), escenario.R(i)*yc+escenario.ys((escenario.sln(i))),'--m','linewidth',1.25); 
            text(escenario.xs((escenario.sln(i))), escenario.ys((escenario.sln(i))),sprintf('\n\nBS%d',(escenario.sln(i)))); 
            for j=1:N
                if i==1
                  %  text(escenario.x(j), escenario.y(j),sprintf('\n\nus%d',j)); 
                end
                if escenario.dist(escenario.sln(i),j)<=escenario.R
                    z8=plot([escenario.xs((escenario.sln(i))) escenario.x(j)],[escenario.ys((escenario.sln(i))) escenario.y(j)],'--','linewidth',1.35,'color',[0.6 0.6 0.6]);
                end
            end
        end
        hold off; 
    end
    xlabel('Posición en X','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    ylabel('Posición en Y','FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal');
    leyenda=legend('Sensores','AP','Cobertura','Enlaces Inalámbricos','Location','SE');
    set(leyenda,'FontName','Times New Roman','FontUnits','points','FontSize',11,'FontWeight','normal','FontAngle','normal')
