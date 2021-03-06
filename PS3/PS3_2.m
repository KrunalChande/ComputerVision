%% Fundamental Matrix Estimation
% Wish to estimate the mapping of points in one image to lines in another.
clc;
clear;

pa = importdata('Data/pts2d-pic_a.txt');
pb = importdata('Data/pts2d-pic_b.txt');

%% Create least squares function that solves the 3x3 matrix F s.t. it satisfies the equipolar constraints

pa_1 = [pa ones(length(pa),1)];
pb_1 = [pb ones(length(pb),1)];

% A = [pa_1(1) * pb_1 pa_1(2) * pb_1 ones(length(pa),1) pa] ;

for i = 1:length(pa_1)
    u_ = pb_1(i,1);
    v_ = pb_1(i,2);
    u = pa_1(i,1);
    v = pa_1(i,2);
    A(i,:) =  [u_*u u_*v u_ v_*u v_*v v_ u v 1];
end

% A = [];

%% SECTION 2.1 - Solve using least squares to generate an estimate for F
F_all = PS3HelperFunctions.findLeastSquares(A);
F = vec2mat(F_all(:,1), 3);
disp('================= SECTION 2.1 =================');
disp('F');
disp(F);

%%  SECTION 2.2 - Find reduced rank F.
[U, S, V] = svd(F);
[a, b] = find(S == min(diag(S)));
S(a,b) = 0;
F_reducedRank = U * S * V;
disp('================= SECTION 2.2 =================');
disp('F_reducedRank');
disp(F_reducedRank);
disp('Rank of F_reducedRank = ')
disp(rank(F_reducedRank))

%% Section 2.3 - Find equipolar line l_b and l_a
l_b = (F * pa_1')';
l_a = (F' * pb_1')';
% for i = 1:20
% l_b(i,:) = l_b(i,:)./l_b(i,3);
% l_a(i,:) = l_a(i,:)./l_a(i,3);
% end
pic_a = im2double(imread('Data/pic_a.jpg'));
[height_a, width_a, ~] = size(pic_a);
pic_b = im2double(imread('Data/pic_b.jpg'));
[height_b, width_b, ~] = size(pic_b);
% height_b = 1;
% width_b = 1;

p_ul = [1 1 1];
p_bl = [1 height_b  1];
p_ur = [width_b 1 1];
p_br = [width_b height_b  1];

l_L = cross(p_ul, p_bl)
% l_L = l_L/l_L(3)
l_R = cross(p_ur, p_br)
% l_R = l_R/l_R(3)
% l_L = [1 1 1];
% l_R = [1072 1 1];
% l_R = [1 1 0];
figure(1), 
subplot(1,2,1); hold on;
hImage = imshow(pic_b); hold on;

for i = 1:20
    p_bL = cross(l_b(i,:), l_L');
    p_bL = p_bL./p_bL(3);
    p_bR = cross(l_b(i,:), l_R');
    p_bR = p_bR./p_bR(3);
    subplot(1,2,1);
        plot([p_bL(1) p_bR(1) ],[p_bL(2) p_bR(2)]);
end

