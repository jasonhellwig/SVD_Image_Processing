%plots the first two principle components of the paired character matrix
%decomposition

function pairedCplot(filename)

[U,S,V] = svd(count2freq_arr(pairCharCount(filename)));

%we need to get the second principal compononent scores
p = getndiag(S,2);
k = U;%k = U*p; %scores using U
x = k(:,2);
j=V';%j = p*V';%scores using V
y = j(2,:);

%make a scatter plot
figure
scatter(x,y);



%add labels to each point
labels = ['a' 'b' 'c' 'd' 'e' 'f' 'g' 'h' 'i' 'j' 'k' 'l' 'm' 'n' 'o' 'p' 'q' 'r' 's' 't' 'u' 'v' 'w' 'x' 'y' 'z'];
text(x,y,labels', 'horizontalalignment','left', 'verticalalignment','bottom');
axis([-1 1 -1 1]);

%show axis lines
xL = xlim;
yL = ylim;
line([0 0], yL, 'color', 'black');  %x-axis
line(xL, [0 0], 'color', 'black');  %y-axis
title(filename);

end