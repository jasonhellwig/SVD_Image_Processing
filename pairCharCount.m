%reads a file and returns a matrix of the count of all leters in a
%file

function [A] = pairCharCount(file)

%open file
fid = fopen(file,'r');
if (fid == -1)
	fprintf('could not open file %s.\n',file);
	A = 0;
	return;
end

%this will hold the count of all the letters
letters = zeros(26,26);

%get 1000 chars at a time and parse the letters
prev = 0; %prev is a follower of idx
idx = 0; %the index of the current character
while ~feof(fid)
    in_str = fscanf(fid,'%s',1024);
    %disp(in_str);  %used to test the read block
    for c = uint8(in_str);
        idx = c;
		if idx > 64 && idx < 91;
			idx = idx+32;
		end
		if idx > 96 && idx < 123
			idx = idx - 96;				
			if prev ~= 0 %only skip adding the matrix on the first iteration
				letters(prev,idx) = letters(prev,idx) + 1; %add the pair to the matrix
			end
			prev = idx; %update the follower
		else
			prev = 0; %don't pair up characters seperated by non characters
		end		
    end    
end
fclose(fid);
A = letters;






