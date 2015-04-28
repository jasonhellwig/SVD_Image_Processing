function image_svd(filename,filetype)

%rank constant n
%n = 10;

%read in an image
img = imread(filename,filetype);
%img = im2double(img); %function not avialable in the lab

img = double(img)./255; %use this if im2double is not available

%combined channels
% imshow(img)
image(img)

% %red channel only
% figure
% im_r = img;
% im_r(:,:,2:3) = 0;
% image(im_r)
% 
% %green channel only
% figure
% im_g = img;
% im_g(:,:,1:2:3) = 0;
% image(im_g)
% 
% %blue channel only
% figure
% im_b = img;
% im_b(:,:,1:2) = 0;
% image(im_b)

%we only need to compute the actua SVD once, after that we can use copies
%to make approximations
U = zeros(size(img,1),size(img,1),3);
S = zeros(size(img,1),size(img,2),3);
V = zeros(size(img,2),size(img,2),3);
for i = 1:3
    [U(:,:,i),S(:,:,i),V(:,:,i)] = svd(img(:,:,i));
end

%since U is diagonal we can take the sqareroot which we'll need for the
%actual compression
D = sqrt(S);

for n = 1:20:61
    img2 = img;
    %do svd on each channel

    for i = 1:3        
%         img2(:,:,i) = U(:,1:n,i)*S(1:n,1:n,i)*V(:,1:n,i)'; %old style
         img2(:,:,i) = U(:,1:n,i)*D(1:n,1:n,i)*D(1:n,1:n,i)*V(:,1:n,i)'; 
    end
    
    


%if not using imshow this is a faster way to constrain the values
    for i = 1:numel(img2)
        img2(i) = max(img2(i),0);
        img2(i) = min(img2(i),1);
    end


%     %clean up out of range values
%     %this method is very slow! Use the above instead
%     for i = 1:3
%         for j = 1:size(img2(:,:,i),1)
%             for k = 1:size(img2(:,:,i),2)
%                 img2(j,k,i) = max(img2(j,k,i),0);
%                 img2(j,k,i) = min(img2(j,k,i),1);
%             end
%         end
%     end

    %combined channels
    figure
%     imshow(img2)
    image(img2)

%     %red channel only
%     figure
%     im_r = img2;
%     im_r(:,:,2:3) = 0;
%     image(im_r)
%     
%     %green channel only
%     figure
%     im_g = img2;
%     im_g(:,:,1:2:3) = 0;
%     image(im_g)
%     
%     %blue channel only
%     figure
%     im_b = img2;
%     im_b(:,:,1:2) = 0;
%     image(im_b)
end

end %end function

