function residualError = findResidual(points2D1, points2D2)
%findResidual: Function returns an error vector of the residuals of the
%points passed
%   residualError = nx1 vector of residuals
%   points2D1 =     nx2 vector of points
%   points2D2 =     nx2 vector of points.

residualError = zeros(size(points2D1,2),1);
for i = 1:size(points2D1,1)
    residualError(i) = sqrt((points2D1(i,1)-points2D2(i,1))^2  + (points2D1(i,2)-points2D2(i,2))^2);
end

