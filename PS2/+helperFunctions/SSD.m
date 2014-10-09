function dispMap = SSD(img,imgTemplate, windowSize, maxDisparity)
%SSD : This function finds the Sum of Squared Differences Measure(SSD)
% t = Template window (source)
% x = proposed location window

padSize= floor(windowSize/2) + maxDisparity;
windowMax = floor(windowSize/2);

[yRows, xCols] = size(imgTemplate);

%% Pad template and image with zeros.
imgTemplatePadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgTemplatePadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) ...
    = imgTemplate;



imgPadded = zeros(yRows +padSize*2, xCols + padSize*2);
imgPadded((padSize+1):(padSize+yRows),(padSize+1):(padSize+xCols)) ...
    = img;


%% Computing SSD

dispMap = zeros(yRows, xCols);
ssdMap = zeros(yRows, xCols);
ssdArray=zeros(2*maxDisparity+1,1);


for y=(padSize+1):(padSize+yRows)
    for x=(padSize+1):(padSize+xCols)
        for d = -maxDisparity:maxDisparity
            diff = imgTemplatePadded(y-windowMax:y+windowMax,x-windowMax:x+windowMax) ...
                - imgPadded(y-windowMax:y+windowMax,x+d-windowMax:x+d+windowMax );
            ssdArray(d+maxDisparity+1,1)= sum(sum(diff.^2));
        end
        [ssdMap(y-padSize,x-padSize), ind] = min(ssdArray);
        dispMap(y-padSize,x-padSize) = (ind-maxDisparity-1);
    end
end

