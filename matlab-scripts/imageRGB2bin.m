function imageRGB2bin(fileImage1,outputfile)
% This function transforms an RGB image, bmp format to
% a file storing its binary data.
% version 1.0
% JLTX
% 18/02/2014
% imageRGB2bin = ('file.bmp', 'outputfile') 
% e.g. imageRGB2bin = ('file.bmp', 'data.txt')
%
% This function only works on binary images or gray scale images
% of square sizes 

A = imread(fileImage1);
[ren,col,indx] = size(A); 

A1 = A(:,:,1);  A2 = A(:,:,2); A3 = A(:,:,3);

KA1 = reshape(A1,ren*col,1);
binstringA1 = dec2bin(KA1, 8);

KA2 = reshape(A2,ren*col,1);
binstringA2 = dec2bin(KA2, 8);

KA3 = reshape(A3,ren*col,1);
binstringA3 = dec2bin(KA3, 8);

fid = fopen(outputfile, 'w');

for indx = 1:(ren*col)
    %fprintf(fid,'%s\t %s\t %s\r\n',binstringA1(indx,:), binstringA2(indx,:),binstringA3(indx,:));
    fprintf(fid,'%s\r\n',binstringA1(indx,:));
end
fclose(fid);
