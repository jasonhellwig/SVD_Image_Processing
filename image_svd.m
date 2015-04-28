function image_svd(fname,filetype)
%read in an image
close all
img = imread(fname,filetype);
%img = im2double(img); %function not avialable without image toobox
img = double(img)./255; %use this if im2double is not available


%######  Display the original  ###########################
%combined channels
% imshow(img) %not available without image toobox
image(img)

% %red channel
% figure
% im_r = img;
% im_r(:,:,2:3) = 0;
% image(im_r)
% 
% %green channel
% figure
% im_g = img;
% im_g(:,:,1:2:3) = 0;
% image(im_g)
% 
% %blue channel
% figure
% im_b = img;
% im_b(:,:,1:2) = 0;
% image(im_b)



%###########  Matrix Decomposition  ###################################
%we only need to compute the actua SVD once, after that we can use copies
%to make approximations
U = zeros(size(img,1),size(img,1),3);
S = zeros(size(img,1),size(img,2),3);
V = zeros(size(img,2),size(img,2),3);
for i = 1:3
    [U(:,:,i),S(:,:,i),V(:,:,i)] = svd(img(:,:,i));
end


D = sqrt(S); %we will use the squareroot for the actual compression


ranks = [1 5 10 15 20 30 40 50 60 70 80 100 125 150 175 200 300 400];
filesizes = [];
%#########  Image Filtering  ############################################
disp('Compressed images from most to least compressed');
for n = ranks;
    img2 = img;
    Ucomp = 0;
    Vcomp = 0;
       
    %do svd on each channel
    for i = 1:3
        Ucomp = U(:,1:n,i)*D(1:n,1:n,i);
        Vcomp = D(1:n,1:n,i)*V(:,1:n,i)';
        img2(:,:,i) = Ucomp*Vcomp;
        %img2(:,:,i) = U(:,1:n,i)*S(1:n,1:n,i)*V(:,1:n,i)'; %old version using S
    end 
    
    disp(size(Ucomp))
    disp(size(Vcomp))

    %Need to constrain any out of range values, or we'll get an error
    img2(img2 > 1) = 1;
    img2(img2 < 0) = 0;
    
    
    %wait for user action to show images    
    fprintf('Next n value : %d\n', n);
    input('Press enter to show the image');

    %write image vectors to file
    filename = sprintf('compressed_image_data.dat');
    save(filename,'Ucomp', 'Vcomp','-mat');
    bytes=dir(filename);
    filesizes = [filesizes, bytes.bytes];
%#########Display of resutant image##########################
    %combined channels
    figure
%   imshow(img2) %not available without image toolbox
    image(img2)

%     %red channel
%     figure
%     im_r = img2;
%     im_r(:,:,2:3) = 0;
%     image(im_r)
%     
%     %green channel
%     figure
%     im_g = img2;
%     im_g(:,:,1:2:3) = 0;
%     image(im_g)
%     
%     %blue channel
%     figure
%     im_b = img2;
%     im_b(:,:,1:2) = 0;
%     image(im_b)
end
plot(ranks,filesizes,ranks,filesizes,'ro');
xlabel('rank');
ylabel('file size (bytes)');

%show oringinal file size as a line
bytes=dir(sprintf('%s.%s',fname,filetype)); %todo figure out a better way to store image vectors or plot the original image matrix instead of the jpg
bytes = bytes.bytes;
line(xlim, [bytes,bytes], 'color', 'black');

end %end function

