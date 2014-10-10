function dispMap = normCrossCorr(leftImage, imgTemplate, windowSize, dispMax)

[yRows,xCols] = size(leftImage);

dispMin = 0;
dispMap=zeros(yRows, xCols);

padSize = floor(windowSize/2);

for y=1+padSize:1:yRows-padSize
    for x=1+padSize:1:xCols-padSize-dispMax
        prevNCC = 0.0;
        bestMatchSoFar = dispMin;
        for dispRange=dispMin:1:dispMax
            nccNumerator=0.0;
            nccDenominatorRightWindow=0.0;
            nccDenominatorLeftWindow=0.0;
            for a=-padSize:1:padSize
                for b=-padSize:1:padSize
                   nccNumerator=nccNumerator+(imgTemplate(y+a,x+b)*leftImage(y+a,x+b+dispRange));
                   nccDenominatorRightWindow=nccDenominatorRightWindow+(imgTemplate(y+a,x+b)*imgTemplate(y+a,x+b));
                   nccDenominatorLeftWindow=nccDenominatorLeftWindow+(leftImage(y+a,x+b+dispRange)*leftImage(y+a,x+b+dispRange));
                end
            end
            nccDenominator=sqrt(nccDenominatorRightWindow*nccDenominatorLeftWindow);
            ncc=nccNumerator/nccDenominator;
            if (prevNCC < ncc)
                prevNCC = ncc;
                bestMatchSoFar = dispRange;
            end
        end
        dispMap(y,x) = bestMatchSoFar;
    end
end




end