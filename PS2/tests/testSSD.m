% Unit test to verify whether SSD works correctly.
clc;
%% Set figures correctly
set(0,'DefaultLineMarkerSize',3);
set(0,'DefaultAxesColorOrder',eye(3)); % XYZ=RGB
set(0,'DefaultFigureWindowStyle','docked');

%% Simple test - create an image and template
img = zeros(9,9);
img(4:6, 4:6) = 1;
img_template = ones(3,3);
figure(1), clf;set(gcf,'Name','original img and template');
subplot(1,2,1); imshow(img);
title('original image');
subplot(1,2,2); imshow(img_template);
title('image template');

% call SSD with the template and the original image
s_tx = helperFunctions.SSD(img, img_template);
figure(2), imshow(s_tx);
% the output should be the minimum values of where the match occurs
[t_rows, t_cols] = size(img_template);
[x_rows, x_cols] = size(img);


%% Now find the minimum value location
disp(s_tx)
[r,c] = find(s_tx == min(min(s_tx)))
% disp(r,c)
%% Actual test - test on sample image