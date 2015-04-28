%reads a file and returns a matrix of the count of all leters in a
%file

function [A] = charCount(file)

%open file
fid = fopen(file,'r');

%this will hold the count of all the letters
letters = zeros(1,26);

%get 1000 chars at a time and parse the letters
while ~feof(fid)
    in_str = fscanf(fid,'%s',1024);
    %disp(in_str);  %used to test the read block
    for c = in_str
        if isletter(c)
            idx = uint8(upper(c))-64; %adjusts the ascii decimal value to the correct index of our array
            if idx > 0 && idx < 27 %throw out any 'weird' non a-z letters (accents, etc)
                letters(idx) = letters(idx) + 1;
            end
        end
    end    
end
fclose(fid);
A = letters;






