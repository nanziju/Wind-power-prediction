csvwrite('decompose_imfs.csv', imfs);

figure;
for k=1:rows
    subplot(rows,1,k);
    plot(modes(k,:));
    ylabel (['IMF' num2str(k)]);    
    if k~=rows
        set(gca,'xtick',[])
    end
    set(gca,'FontName','Courier New','FontSize',5,'FontWeight','Bold','Box','on','TickDir','in');
    axis tight;
end