clc;
close all;
clear all;

%% Section 1.1
%% Compute the projection matrix that goes from world 3D to image 2D.
%   su   ~       m1,1 m1,2 m1,3 m1,4         X
% [ sv ] =   [   m2,1 m2,2 m2,3 m2,4 ]   [   Y   ]
%   s            m3,1 m3,2 m3,3 m3,4         Z
%                                            1
%% Create a least squares function that will solve for 3x4 matrix M_normA given the normalized 2D and
% 3D lists.

points3D = importdata('Data/pts3d-norm.txt');
points3D(:,end+1) = ones(size(points3D,1), 1);
% Append column of 1 to the end
points2D = importdata('Data/pts2d-norm-pic_a.txt');

% Compute A based on Slides 18-Sep
A = PS3HelperFunctions.computeAMatrix(points3D, points2D);

% Find the Eigen Vector and create the M matrix
[eVector, ~ ] = (eigs(A' * A, 1, 'sm'));
M_normA = vec2mat(eVector, 4);
%% Test it on normalized 3D points. Do comparison by checking the residual.
% residual = sqrt(SSD(u,v))
compare2Dpoints = zeros(3, size(points3D,1));
for i  = 1:size(points3D,1)
    compare2Dpoints(:,i) = M_normA * points3D(i, :)';
    % Normalize it
    compare2Dpoints(:,i) = compare2Dpoints(:,i)./compare2Dpoints(3,i);
end

compare2Dpoints = compare2Dpoints';
compare2Dpoints(:,3) = [];

residualError = PS3HelperFunctions.findResidual(compare2Dpoints, points2D);

disp('================= SECTION 1.1 =================');
M_normA
disp('<u,v> projection of last point = ');
disp(compare2Dpoints(end,:));
disp('residualError = ');
disp(residualError(end));


%% Section 1.2
disp('================= SECTION 1.2 =================');
points2D = importdata('Data/pts2d-pic_b.txt');
points3D = importdata('Data/pts3d.txt');
points3D(:,end+1) = ones(size(points3D,1), 1);
avgRes = [];
minResidualError = inf;
% Randomly choose k points from 2d and 3d list where k = 8,12,16
for k = [8, 12, 16]
    for i = 1:10
        kInd = randi([1 20], k+4, 1);
        k_2d = points2D(kInd(1:end-4), :);
        k_3d = points3D(kInd(1:end-4), :);
        
        % Compute A based on Slides 18-Sep
        A = PS3HelperFunctions.computeAMatrix(points3D, points2D);
        
        % Find the Eigen Vector and create the M matrix
        [eVector, ~ ] = (eigs(A' * A, 1, 'sm'));
        M_normA_k = vec2mat(eVector, 4);
        
        k_2d_test = points2D(kInd(end-3:end), :);
        k_3d_test = points3D(kInd(end-3:end), :);
        
        
        compare2Dpoints = zeros(3, size(k_3d_test,1));
        for i  = 1:size(k_3d_test,1)
            compare2Dpoints(:,i) = M_normA_k * k_3d_test(i, :)';
            % Normalize it
            compare2Dpoints(:,i) = compare2Dpoints(:,i)./compare2Dpoints(3,i);
        end
        
        compare2Dpoints = compare2Dpoints';
        compare2Dpoints(:,3) = [];
        
        residualError = PS3HelperFunctions.findResidual(compare2Dpoints, k_2d_test);
        
        if mean(residualError) < minResidualError
            bestM = M_normA_k;
            minResidualError = mean(residualError);
            minK = k;
        end
        avgRes = [avgRes; mean(residualError)];
    end
    disp('k = ')
    disp(k)
    disp('average residual')
    disp(avgRes)
    disp('average of 10')
    disp(mean(avgRes))
    avgRes = [];
end
disp('M with lowest residual error');
disp(bestM)
disp('Min k')
disp(minK)

%% SECTION 1.3 - Camera Center C
Q = bestM(:,1:3)
m_4 = bestM(:,4)
C = - (inv(Q)) * m_4;
disp('================= SECTION 1.3 =================')
warning('Might be incorrect recheck');
disp('C = ')
disp(C)