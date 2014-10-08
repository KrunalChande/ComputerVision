function [ R ] = computeHarrisValue( I_x, I_y, a )
%computeHarrisValue Compute harris value based on formula
M = 0;

[height width] = size(I_x);
result = zeros(height,width); 
R = zeros(height,width);
for x = 1:rows
    for y = 1:cols
        I_matrix = [    I_x^2       I_x*I_y     ;
            I_x*I_y     I_y^2       ];
        
        m_ = (w(x,y) * I_matrix);
        M = M + m_;
    end
end
R = det(M) - a * trace(M);


end

