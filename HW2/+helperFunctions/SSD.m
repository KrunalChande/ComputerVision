function s_tx = SSD(img,img_template)
%SSD : This function finds the Sum of Squared Differences Measure(SSD)
% t = Template window (source)
% x = proposed location window

warning('might give incorrect detection on edges');
if nargin < 1
    img = zeros(9,9);
    img(4:6, 4:6) = 1;
    img_template = ones(3,3);
    figure(1), clf;set(gcf,'Name','original img and template');
    subplot(1,2,1); imshow(img);
    title('original image');
    subplot(1,2,2); imshow(img_template);
    title('image template');
end

%% set up variables
[tplRows, tplCols] = size(img_template);
[imgRows, imgCols] = size(img);
s_tx = zeros(size(img()));

%% Move template over image one pixel at a time.
for r = ((tplRows+1)/2:(imgRows-(tplRows-1)/2))
    for c = (tplCols+1)/2:(imgCols - (tplCols-1)/2)
        s_tx(r, c) = sum(sum(img_template(1:tplRows, 1:tplCols) ...
            - img(r-((tplRows-1)/2):r+((tplRows-1)/2), c-((tplCols-1)/2):c+((tplCols-1)/2)).^2));
        %%
        if nargin < 1
            figure, imshow(s_tx);
        end
    end
end
maxs_tx = max(max(s_tx));
s_tx(1:floor(tplRows/2), :) = maxs_tx;
s_tx(:, 1:floor(tplCols/2)) = maxs_tx;

s_tx(end - floor(tplRows/2):end, :) = maxs_tx;
s_tx(:, end-floor(tplCols/2):end) = maxs_tx;

