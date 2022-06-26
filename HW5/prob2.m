%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 2
% 
% [Directions]
% 1. Please read the problem specified in the .pdf file.
% 2. Replace 'PLEASE_FILL' with appropriate functions, strings, numbers.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clearvars();

%% 2-a,b
filename = 'mincho.jpg';
img = imread(filename);
subplot(1, 4, 1);
imshow(img);
title('Original Image')

%% 2-c
new_img = zeros(size(img, 1), size(img, 2), 3);
new_img = uint8(new_img);
spi = 1:2:size(img, 1);
spj = 1:2:size(img, 2);

new_img(spi, spj, :) = img(spi, spj, :);
subplot(1, 4, 2);
imshow(new_img);
title('Sampled Image')


%% 2-d,e
filter = fspecial('gaussian', 3, 1);
fix_img = zeros(size(img, 1), size(img, 2), 3);
fix_img(:, :, 1) = conv2(new_img(:, :, 1), filter, "same");
fix_img(:, :, 2) = conv2(new_img(:, :, 2), filter, "same");
fix_img(:, :, 3) = conv2(new_img(:, :, 3), filter, "same");
subplot(1, 4, 3);
fix_img = uint8(fix_img);
imshow(fix_img);
title('Gaussian Smoothing')

%% 2-f,g
K = 4;
final_img = K * fix_img;
subplot(1, 4, 4);
imshow(final_img);
title('Final Image')