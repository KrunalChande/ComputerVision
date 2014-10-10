function dispMap = normCrossCorr(img, imgTemplate, windowSize, dispMax)

% [yRows,xCols] = size(img);
%
% dispMin = 0;
% dispMap=zeros(yRows, xCols);
%
% padSize = floor(windowSize/2);
%
% for y=1+padSize:1:yRows-padSize
%     for x=1+padSize:1:xCols-padSize-dispMax
%         prevNCC = 0.0;
%         bestMatchSoFar = dispMin;
%         for dispRange=dispMin:1:dispMax
%             nccNumerator=0.0;
%             nccDenominatorRightWindow=0.0;
%             nccDenominatorLeftWindow=0.0;
%             for a=-padSize:1:padSize
%                 for b=-padSize:1:padSize
%                    nccNumerator=nccNumerator+(imgTemplate(y+a,x+b)*img(y+a,x+b+dispRange));
%                    nccDenominatorRightWindow=nccDenominatorRightWindow+(imgTemplate(y+a,x+b)*imgTemplate(y+a,x+b));
%                    nccDenominatorLeftWindow=nccDenominatorLeftWindow+(img(y+a,x+b+dispRange)*img(y+a,x+b+dispRange));
%                 end
%             end
%             nccDenominator=sqrt(nccDenominatorRightWindow*nccDenominatorLeftWindow);
%             ncc=nccNumerator/nccDenominator;
%             if (prevNCC < ncc)
%                 prevNCC = ncc;
%                 bestMatchSoFar = dispRange;
%             end
%         end
%         dispMap(y,x) = bestMatchSoFar;
%     end
% end


padSize= floor(windowSize/2) + dispMax;
windowMax = floor(windowSize/2);

[yRows, xCols] = size(imgTemplate);

%% Pad template and image with zeros.
imgTemplatePadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgTemplatePadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) = imgTemplate;

imgPadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgPadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) = img;


%% Compute Normalized Correlation

dispMap = zeros(yRows, xCols);
prevMax = 0;
for y=(padSize+1):(padSize+yRows)
    for x=(padSize+1):(padSize+xCols)
        prevMax = 0;
        for d = -dispMax:1:dispMax
            imgTemplateSection = imgTemplatePadded(y-windowMax:y+windowMax,x-windowMax:x+windowMax);
            imgSection = imgPadded(y-windowMax:y+windowMax,x+d-windowMax:x+d+windowMax);
            if(std(imgTemplateSection(:))~=0)
                nccCoeff = normxcorr2(imgTemplateSection,imgSection);
                if max(nccCoeff(:)) > prevMax
                    [ypeak, xpeak] = find(nccCoeff==max(nccCoeff(:)));
                    dispMap(y-padSize,x-padSize) = (d);%xpeak - padSize - windowMax;
                    prevMax = max(nccCoeff(:));
                end
            end
        end
    end
    
    
end