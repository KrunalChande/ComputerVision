function [ Rmax, R ] = computeHarrisValue( Ix, Iy, a )
%computeHarrisValue Compute harris value based on formula


Ix2 = Ix.^2;
Iy2 = Iy.^2;
Ixy = Ix.*Iy;

%applying gaussian filter on the computed value
h= fspecial('gaussian',[5 5],2);
Ix2 = filter2(h,Ix2);
Iy2 = filter2(h,Iy2);
Ixy = filter2(h,Ixy);
height = size(Ix,1);
width = size(Ix,2);
R = zeros(height,width);

Rmax = 0;
for i = 1:height
    for j = 1:width
        M = [Ix2(i,j) Ixy(i,j);Ixy(i,j) Iy2(i,j)];
        R(i,j) = det(M)-0.01*(trace(M))^2;
        if R(i,j) > Rmax
            Rmax = R(i,j);
        end;
    end;
end;

end
