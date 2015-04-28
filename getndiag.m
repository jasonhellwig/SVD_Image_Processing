%gets the specified number of eigenvectors from the SVD diagonal matrix
%retuns the new matrix as well as a vector of the retrieved values

function [X,V] = getndiag(S, n)
    X = zeros(size(S,1));
    V = zeros(1,size(S,1));
    for i = 1:n
        X(i,i) = S(i,i);
        V(i) = S(i,i);
    end
end