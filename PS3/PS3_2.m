%% Fundamental Matrix Estimation
% Wish to estimate the mapping of points in one image to lines in another.

pa = importdata('Data/pts2d-pic_a.txt');
pb = importdata('Data/pts2d-pic_b.txt');

%% Create least squares function that solves the 3x3 matrix F s.t. it satisfies the equipolar constraints

pa_1 = [pa ones(length(pa),1)];
pb_1 = [pb ones(length(pb),1)];

A = [pa_1(1) * pb_1 pa_1(2) * pb_1 ones(length(pa),1) pa] ;

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

pic_a = imread('Data/pic_a.jpg');
[height_a, width_a, ~] = size(pic_a);
pic_b = imread('Data/pic_b.jpg');
% [height_b, width_b, ~] = size(pic_b);
height_b = 1;
width_b = 1;

p_ul = [0 0 0];
p_bl = [0 height_b 0];
p_ur = [width_b 0 0];
p_br = [width_b height_b 0];

l_L = cross(p_ul, p_bl);
l_R = cross(p_ur, p_br);
% l_R = [1 1 0];
for i = 1:20
p_bL(i,:) = cross(l_b(i,:), l_L');
p_bR(i,:) = cross(l_b(i,:), l_R');
end
hImage = imshow(pic_b);
for i = 1:20
hold on;
line(p_bL(i,1:2), p_bR(i,1:2));
end
