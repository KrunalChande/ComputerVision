% SIFT Features
clc;
clear all;
% For the interest points above, plot the lines and a little line that
% shows the direction of the gradient.
scale = 10;      % Scale in structure 'f', for vl_plotframe and for computing descriptors
figureIndex  = 1;
% img = zeros([480 640 4]);
img(:, :, 1) = imread('Data/transA.jpg');
img(:, :, 2) = imread('Data/transB.jpg');
% img(:, :, 1) = imread('Data/check.bmp');
% img(:, :, 2) = imread('Data/check_rot.bmp');

img(:, :, 3) = imread('Data/simA.jpg');
img(:, :, 4) = imread('Data/simB.jpg');
a = 0.1;
filter = 'sobel';
% filter = 'naive';
windowSize = 15;
sigma = 1;
width = size(img(:, :, 1),2);
maxNoOfInliers = 0;
threshold = 20;
for i  = 1:1
    %% Section 1 - Write a function to compute the angle.
    [ I_x_1, I_y_1] = PS4HelperFunctions.findXYGradients( img(:, :, i), windowSize, sigma, filter );
    [Rmax_1, R_1] = PS4HelperFunctions.computeHarrisValue(I_x_1, I_y_1, a);
    [posX_1,posY_1] = PS4HelperFunctions.doNonMaximalSupression(Rmax_1, R_1);
    figure(figureIndex),clf,set(gcf,'Name','Harris Corners'); figureIndex = figureIndex + 1;
    subplot(1,2,1);
    imshow(img(:, :, i),[min(min(img(:, :, i))) max(max(img(:, :, i)))] ); hold on;
    computedAngle_1  = atan2(I_y_1(posY_1), I_x_1(posX_1));
    f_1 = [posX_1, posY_1, ones(length(computedAngle_1), 1)*scale, computedAngle_1]';
    h1_1 = vl_plotframe(f_1(:,1:15:end));
    h2_1 = vl_plotframe(f_1(:,1:15:end));
    set(h1_1,'color','k','linewidth',3) ;
    set(h2_1,'color','y','linewidth',2) ;
    
    
    
    [ I_x_2, I_y_2] = PS4HelperFunctions.findXYGradients( img(:, :, i+1), windowSize, sigma, filter );
    [Rmax_2, R_2] = PS4HelperFunctions.computeHarrisValue(I_x_2, I_y_2, a);
    [posX_2,posY_2] = PS4HelperFunctions.doNonMaximalSupression(Rmax_2, R_2);
    %     figure(figureIndex),clf,set(gcf,'Name','Harris Corners'); figureIndex = figureIndex + 1;
    subplot(1,2,2);
    imshow(img(:, :, i+1),[min(min(img(:, :, i+1))) max(max(img(:, :, i+1)))] ); hold on;
    computedAngle_2  = atan2(I_y_2(posY_2), I_x_2(posX_2));
    f_2 = [posX_2, posY_2, ones(length(computedAngle_2), 1)*scale, computedAngle_2]';
    h1_2 = vl_plotframe(f_2(:, 1:15:end));
    h2_2 = vl_plotframe(f_2(:,1:15:end));
    set(h1_2,'color','k','linewidth',3) ;
    set(h2_2,'color','y','linewidth',2) ;
    
    
    
    
    %% SECTION 2 - Extract features. Call matchihng functions to compute best matches. Create putative image pair.
    
    I_1 = single(img(:, :, i));
    I_2 = single(img(:, :, i+1));
    
    [f_1_2,d_1] = vl_sift(I_1,'frames',f_1) ;
    [f_2_2,d_2] = vl_sift(I_2,'frames',f_2) ;
    
    [matches, scores] = vl_ubcmatch(d_1, d_2) ;
    f_1_Index = matches(1,:);
    f_2_Index = matches(2,:);
    f_1Matched = f_1_2(f_1_Index);
    f_2Matched = f_2_2(f_2_Index);
    
    combinedImages = [img(:, :, i) img(:, :, i+1)];
    
    %     figure(figureIndex),clf,set(gcf,'Name','Putative Figure'); figureIndex = figureIndex + 1;
    figure(figureIndex),clf,set(gcf,'Name','Putative Figure'); figureIndex = figureIndex + 1;
    imshow(combinedImages,[min(min(img(:, :, i+1))) max(max(img(:, :, i+1)))]); hold on;
    p1 = [posX_1(matches(1,:)) posY_1(matches(1,:))];
    plot(p1(:,1), p1(:,2), 'g*','linewidth',1);
    p2 = [posX_2(matches(2,:)) (posY_2(matches(2,:)))];
    
    p2_shifted = [(posX_2(matches(2,:))+width) (posY_2(matches(2,:)))];
    
    plot(p2_shifted(:,1), p2_shifted(:,2), 'r*','linewidth',1);
    
    x = [p1(:,1) p2_shifted(:,1)];
    y = [p1(:,2) p2_shifted(:,2)];
    warning('selecting some points for display');
    for j = 1:10:size(matches,2)
        plot(x(j,:),y(j,:),'Color','b','LineWidth',2)
    end
    
    %% PROBLEM 3 - RANSAC
    
    for RANSACIteration = 1:200
        % Select 2 feature points
        randIndex = randi(length(p1),2);
        
        p1_rand = p1(randIndex, :);
        p2_rand = p2(randIndex, :);
        
        % Compute exact similarity transform Hk. eq of line y = mx + c
        
        %    diffX = p2_rand(1) - p1_rand(1);
        %    diffY = p2_rand(2) - p1_rand(2);
        %
        %
        
        u1 = p1_rand(1,1);
        v1 = p1_rand(1,2);
        u2 = p1_rand(2,1);
        v2 = p1_rand(2,2);
        
        
        u1_ = p2_rand(1,1);
        v1_ = p2_rand(1,2);
        u2_ = p2_rand(2,1);
        v2_ = p2_rand(2,2);
        
        
        A = [   u1 -v1 1 0 ;...
            v1  u1 0 1 ;...
            u2 -v2 1 0 ;...
            v2  u2 0 1];
        
        r = [u1_ ;v1_ ;u2_ ;v2_];
        
        x = A\r;
        a = x(1);
        b = x(2);
        c = x(3);
        d = x(4);
        
        H_k = [a -b c; b a d];
        
%         % compute inliers where SSD(pi, Hkpi) < e
%         p2_transformed = H_k * [p2 ones(length(p2), 1)]';
%         p2_transformed = p2_transformed';
%         distances = sqrt((p2_transformed(:,2)-p1(:,2)).^2 + (p2_transformed(:,1)-p1(:,1)).^2);
%         
%         % Keep this HK if it is the largest set of inliers
%         inliersInThisH_k = find(distances < threshold);
%         
%         noOfInliers1(RANSACIteration) = length(inliersInThisH_k);
        
        
        p1_transformed = H_k * [p1 ones(length(p1), 1)]';
        p1_transformed = p1_transformed';
        distances = sqrt((p1_transformed(:,2)-p2(:,2)).^2 + (p1_transformed(:,1)-p2(:,1)).^2);
        
        % Keep this HK if it is the largest set of inliers
        inliersInThisH_k = find(distances < threshold);
        
        noOfInliers2(RANSACIteration) = length(inliersInThisH_k);
        
        
        if (noOfInliers2(RANSACIteration) > maxNoOfInliers)
            H_k_best = H_k
            noOfInliers2(RANSACIteration)
            maxNoOfInliers = noOfInliers2(RANSACIteration);
        end
        
    end
    
    % Recompute least squares estimate to find H on inliers
    
    
    
end

