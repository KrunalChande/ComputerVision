function A = computeAMatrix(points3D, points2D)
%computeAMatrix Compute 2nx12 A matrix as given in slides CS4495-Calibration.pdf
%   
zero4 = zeros(1,4);
A = zeros(2*size(points3D,1), 12);

for i = 1:size(points3D,1)
A((2*i)-1,:) = [ points3D(i,:)  zero4  (-points2D(i,1)*points3D(i,:))];
A((2*i),:) = [ zero4 points3D(i,:)  (-points2D(i,2) * points3D(i,:))];
end
end

