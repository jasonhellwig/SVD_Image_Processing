%computes the frequency vector of a given occurence count vector

function [A] = count2freq_arr(countarr)
   total = sum(sum(countarr));
   A = countarr./total;
end