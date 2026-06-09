function Plot_PVSRS_new(fn, pvsrs)

%4CP PVSRS plot
figure;
hold on;
EMTBR_4CP(fn, pvsrs, 8); % Size_2 = 8 z.B.
loglog(fn,pvsrs,'k','LineWidth',1);

set (gca,'XLim', [100 10000], 'YLim',[0.01 30]);
set (gca,'FontSize',12);



title('PVSRS Q=10','Fontname','Arial','FontWeight','normal','FontSize',16,'Interpreter', 'none');
xlabel('Frequency (Hz)','Fontname','Arial','FontSize',14,'Interpreter', 'none');
ylabel('Pseudo-Velocity (m/s)','Fontname','Arial','FontSize',14,'Interpreter', 'none');


grid on;
hold off;

end

% /*---------------------------------------------------
% * Definition of function EMTBR_4CP(F,PV,Target,Size_2)
% * Parameters:
% *
% * Return value:
% *
% ------------------------------------------------------*/


function EMTBR_4CP(F,PV,Size_2)


% color spec
color_spec1=[0 0 0];
color_spec2=[0.7 0.7 0.7];

% frequency limit low and high
fl=10; %old value 100
fr=100000; %old value 30000
flr=[fl fr];

xlim([ 100,30000]);
ylim([ 0.01,30]);

%-> Shortening of code
kl=2*pi*fl;
kr=2*pi*fr;

% major acceleration and displacement  lines are created
for i=1:1:10
    g_dec(i,:)=[1*10^i/kl,1*10^i/kr];
end
%assignin('base',"g_dec",g_dec);
for i=1:1:10
    z_dec(i,:)=[1*10^(-i)*kl,1*10^(-i)*kr];
end

hold on;


% minor acceleration lines (m/s2) decade lines are plotted
z=1;
for i=1:1:10
    for k=2:1:9
        g_dec_minor(z,:)=g_dec(i,:)*k;
        p3=loglog(flr,g_dec_minor(z,:),'LineWidth',0.1,'color',color_spec2);

        z=z+1;
    end
end

% minor displacment lines (m) lines are plotted
for i=1:1:10
    for k=2:1:9
        z_dec_minor(z,:)=z_dec(i,:)*k;
        p4=loglog(flr,z_dec_minor(z,:),'LineWidth',0.1,'color',color_spec2);

        z=z+1;
    end
end

% major acceleration and displacement  lines are ploted at last (thus they are on top)
for j=1:1:10
    loglog(flr,g_dec(j,:),'LineWidth',0.2,'color',color_spec1);

end

for j=1:1:10
    loglog(flr,z_dec(j,:),'LineWidth',0.2,'color',color_spec1);

end

grid on;


plot(F,PV,'b','LineWidth',1);

set(gca,'DefaultTextRotation',30);
text(200, 0.015,'1e-5m','color','r','FontSize',Size_2);
text(200, 0.15,'1e-4m','color','r','FontSize',Size_2);
text(200, 1.5,'1e-3m','color','r','FontSize',Size_2);
%text(Target,'Position',[200 15],'String','1e-2m','color','r','FontSize',Size_2)

set(gca, 'DefaultTextRotation',-30);
text(2500, 8e-2,'1000 m/s2','color','r','FontSize',Size_2);
text(2500, 8e-1,'10000 m/s2','color','r','FontSize',Size_2);
text(2500, 8,'100000 m/s2','color','r','FontSize',Size_2);
%text(Target,'Position',[7000 30],'String','1 000 000 m/s2','color','r','FontSize',Size_2)

set(gca,'DefaultTextRotation',0);


end


