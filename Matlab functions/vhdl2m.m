function vhdl2m(input_bin,imagesize, size_w);
% filename: vhdl2m.m
% author: JLTX
% date: 19/02/14
% detail: a program to read in the VHDL output file
%
% paramter: input_bin - vhdl output bin file
% imagesize: actually image size
% 
% This function works only on binary images or gray scale images
% square sizes 

fid = fopen(input_bin, 'r');
a = fscanf(fid, '%s');    % It has two rows now.
[r,c] = size(a);

b = zeros(1,c/8);
indx3 = 1;
indx2 = 8;
for indx1 = 1:8:c
    b(indx3) = bin2dec(a(1,indx1:indx1+7));
    indx1 = indx1 + 1;
    indx3 = indx3 + 1;
end

fclose(fid);
b = b';

b = uint8(b);
d = reshape(b,imagesize,size_w);
imwrite(d, 'output.jpg');
imshow(d);
