function solution = findLeastSquares(A)
%findLeastSquares Implement solution to the equation Ax = 0 for an
%overconstrained system
        [eVector, ~ ] = (eigs(A' * A, 1, 'sm'));
        M_normA_k = vec2mat(eVector, 4);
solution = eVector;

[S V D] = svd(A);

solution = D(:,9);

end

