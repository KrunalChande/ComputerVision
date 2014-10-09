function dispMap = normCrossCorr(img, imgTemplate, windowSize)


padSize= floor(windowSize/2);
windowMax = floor(windowSize/2);

[yRows, xCols] = size(imgTemplate);

%% Pad template and image with zeros.
imgTemplatePadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgTemplatePadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) = imgTemplate;

imgPadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgPadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) = img;


%% Compute Normalized Correlation

dispMap = zeros(yRows, xCols);

for y=(padSize+1):(padSize+yRows)
    for x=(padSize+1):(padSize+xCols)
        imgTemplateSection = imgTemplatePadded(y-windowMax:y+windowMax,x-windowMax:x+windowMax);
        imgSection = imgPadded(y-windowMax:y+windowMax,:);
        if(std(imgTemplateSection(:))~=0)
            nccCoeff = normxcorr2(imgTemplateSection,imgSection);
            [~, maxCol] = max(max(abs(nccCoeff)));
            dispMap(y-padSize,x-padSize) = maxCol - padSize - windowMax;
        end
    end
end
end