function dispMap = SSD(img,imgTemplate, windowSize, maxDisparity)
%SSD : This function finds the Sum of Squared Differences Measure(SSD)
% t = Template window (source)
% x = proposed location window

padSize= floor(windowSize/2) + maxDisparity;
window_max = floor(windowSize/2);

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
            diff = imgTemplatePadded(y-window_max:y+window_max,x-window_max:x+window_max) ...
                - imgPadded(y-window_max:y+window_max,x+d-window_max:x+d+window_max );
            ssdArray(d+maxDisparity+1,1)= sum(sum(diff.^2));
        end
        [ssdMap(y-padSize,x-padSize), ind] = min(ssdArray);
        dispMap(y-padSize,x-padSize) = (ind-maxDisparity-1);
    end
end








% warning('might give incorrect detection on edges');
% if nargin < 1
%     img = zeros(9,9);
%     img(4:6, 4:6) = 1;
%     img_template = ones(3,3);
%     figure(1), clf;set(gcf,'Name','original img and template');
%     subplot(1,2,1); imshow(img);
%     title('original image');
%     subplot(1,2,2); imshow(img_template);
%     title('image template');
% end
%
% %% set up variables
% [tplRows, tplCols] = size(img_template);
% [imgRows, imgCols] = size(img);
% s_tx = zeros(size(img()));
%
% %% Move template over image one pixel at a time.
% for r = ((tplRows+1)/2:(imgRows-(tplRows-1)/2))
%     for c = (tplCols+1)/2:(imgCols - (tplCols-1)/2)
%         s_tx(r, c) = sum(sum(img_template(1:tplRows, 1:tplCols) ...
%             - img(r-((tplRows-1)/2):r+((tplRows-1)/2), c-((tplCols-1)/2):c+((tplCols-1)/2)).^2));
%         %%
%         if nargin < 1
%             figure, imshow(s_tx);
%         end
%     end
% end
% maxs_tx = max(max(s_tx));
% s_tx(1:floor(tplRows/2), :) = maxs_tx;
% s_tx(:, 1:floor(tplCols/2)) = maxs_tx;
%
% s_tx(end - floor(tplRows/2):end, :) = maxs_tx;
% s_tx(:, end-floor(tplCols/2):end) = maxs_tx;



