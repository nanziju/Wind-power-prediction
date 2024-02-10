function beeswarmplot(data)
    % 确定每个数据点的位置
    [sortedData, sortedIndices] = sort(data);
    positions = zeros(size(data));
    spread = 0.3; % 设置数据点的扩散范围

    for i = 1:length(data)
        % 对于每个数据点，找到一个合适的位置以避免重叠
        position = 1;
        while any(abs(positions(sortedIndices(1:i-1)) - position) < spread)
            position = position + spread;
        end
        positions(sortedIndices(i)) = position;
    end

    % 绘制蜂群图
    scatter(positions, sortedData, 'filled');
    ylabel('Value');
    xlabel('Data Points');
    title('Bee Swarm Plot');
end
