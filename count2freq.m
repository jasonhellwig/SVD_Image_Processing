%computes the frequency vector of a given occurence count vector

function [A] = count2freq(countvector)
   total = sum(countvector);
   A = countvector./total;
end