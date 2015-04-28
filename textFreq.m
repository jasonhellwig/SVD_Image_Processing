%reads a file and returns a matrix of the frequency of all words used

function [A] = textFreq(file)

%open file
fid = fopen(file,'r');

%read file in blocks of n strings
file_blk = '';
while true
	word = fscanf(fid,'%s',1)
	if length(word) == 0
		break
	end
	file_blk = [file_blk; word];
end


A = '';
for i = 1:rows(file_blk)
	strin = file_blk(i,:);
	strout = '';
	for j = 1:columns(strin)
		if isalpha(strin(j)) || isdigit(strin(j))
			strout = [strout strin(j)];
		end
	end
	strout = upper(strout);
	A = [A; strout];	
end

fclose(fid);


