function SSD(t, x)
%SSD : This function finds the Sum of Squared Differences Measure(SSD)
% t = Template window (source)
% x = proposed location window
warning('Function not yet tested')
[tplRows, tplCols] = size(t);
[imgRows, imgCols] = size(x);
s_tx = zeros(size(x()));
for r = 1:imgRows
    for c = 1:imgCols
        for j = 1:tplRows
            for i = 1:tplCols
                s_tx(r,c) = (t(j,i) - x(r + j- 0.5*tplRows, c + i - 0.5 * tplCols)).^2;
            end
        end
    end
end
end