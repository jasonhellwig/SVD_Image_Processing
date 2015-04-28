%computes the frequency of all character pairs given the paired character
%matrix

function plotPairedFreq(filename)

X = count2freq_arr(pairCharCount(filename));
X

letters = 'abcdefghijklmnopqrstuvwxyz';
labels = [];
bars = zeros(1,26*26);
count = 1;
for i = 1:size(X,1)
    for j = 1:size(X,2)
        labels =  [labels; sprintf('%s%s',letters(i), letters(j))];
        bars(count) =  X(i,j);
        count = count + 1;
    end
end

labels
bars
[bars_s, idx] = sortrows(bars,'descend');

for i = 1:20
    fprintf('%s : %f\n', letters(idx,:), bars_s(i))
end

bar(bars);

end