% RANSAC

%% SECTION 3.1 - Pure translation

    p_1 = [posX_1(matches(1,:)) posY_1(matches(1,:))];
    p_2 = [(posX_2(matches(2,:))) (posY_2(matches(2,:)))];
    
    diffP1P2 = p_1-p_2;
max(hist(diffP1P2(:,1)))
max(hist(diffP1P2(:,2)))

%% SECTION 3.2 - Similarity Transform