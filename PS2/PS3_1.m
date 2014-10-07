clc;
close all;
clear all;


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
M_normA = vec2mat(eVector, 4)

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

disp('<u,v> projection of last point = ');
disp(compare2Dpoints(end,:));
disp('residualError = ');
disp(residualError(end));
