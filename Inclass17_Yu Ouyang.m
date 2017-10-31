%In this folder, you will find two images img1.tif and img2.tif that have
%some overlap. Use two different methods to align them - the first based on
%pixel values in the original images and the second using the fourier
%transform of the images. In both cases, display your results. 

img1 = imread('img1.tif');
img2 = imread('img2.tif');
figure;
subplot(1,2,1); imshow(img1,[]);
subplot(1,2,2); imshow(img2,[]);
diffs = zeros(1,500);
for ov = 1:799
    pix1 = img1(:,(800-ov):800);
    pix2 = img2(:,1:(1+ov));
    diffs(ov) = sum(sum(abs(pix1-pix2)))/ov;
end
[~,overlap] = min(diffs)

img2_align = [zeros(800,size(img2,2)-overlap+1),img2];
imshowpair(img1, img2_align);


%fourier transform
img1 = imread('img1.tif');
img2 = imread('img2.tif');
figure;
subplot(1,2,1); imshow(img1,[]);
subplot(1,2,2); imshow(img2,[]);
corr = zeros(1,500);
for ii = 1:799
    for jj =1:799
        pix1 = img1((800-ii):800,(800-jj):800);
        pix2 = img2(1:(1+ii),1:(1+jj));
        corr(ii,jj) = mean2((pix1-mean2(pix1)).*(pix2-mean2(pix2)));
    end
end
[max_ii,jj] = max(corr);
[max_jj,ii] = max(max_ii);
pos = [jj(ii), ii];

img2_shift = [zeros(size(img2)+[800-ii,800-jj]),img2];
imshowpair(img1, img2_shift);

% It seems that the 2D comparison takes a lot of time to run and I could
% not get the final results. 
