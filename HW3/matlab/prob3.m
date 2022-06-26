%% 3
clearvars();

%% 3.(a)
img = imread('mystery_img.png');
dimg = im2double(img);
dimg_gray = double(im2gray(img));
imshow(img);

%% 3.(b)
%% load image
checker = imread('checkerboard.png');
checker_blur = imread('checkerboard_blurred.png');

colormap(gray);
subplot(2, 1, 1), imshow(checker);
subplot(2, 1, 2), imshow(checker_blur);

%% check FT of checker, checker_blur
C = fft2(double(checker));
C_blur = fft2(double(checker_blur));

figure, mesh(abs(fftshift(C)), [1, 10000]);
figure, mesh(abs(fftshift(C_blur)), [1, 10000]);
changer_FT = C_blur./(C+0.0001);
% Y축에서 f=0 근방의 값을 주로 유지하므로, y축 방향으로 움직였음을 알 수 있다.

%% (find filter)
figure, mesh(abs(fftshift(changer_FT)));

changer = ifft2(changer_FT);
figure, mesh(changer), colormap(gray);

figure;
reblurred = ifft2(C.*changer_FT);
subplot(211), imagesc(abs(reblurred));
subplot(212), imagesc(checker_blur), colormap(gray);

% changer의 amplitude로 보아하니 y축 frequency 0 근처에서 x축 frequency만 남김. -> y축에서는 DC bias만 남기고싶은 것임.
% angle: 그냥 난리남

%% (another version of changer -> works!)
changer(1:20, 1:20) = 4*changer(1:20, 1:20)
changer(1:40, 21:40) = 0;
changer(21:40, 1:40) = 0;
changer(21:30, 1:40) = changer(21:30, 1:40) + changer(1:10, 1:40)/2;
changer(1:10, 1:40) = changer(1:10, 1:40)/2;
mesh(changer);

% checker 이미지가 20, 20 주기이기도 하다는 점을 참고하면
% 위와 같이 단순화시킬 수 있다.

changer_FT = fft2(changer);

%% (restore blurred img)
C_rest = C_blur./(changer_FT+0.000001);
imagesc(ifft2(C_rest), [1, 256]), colormap(gray);

%% (custom blur filter - ideal motion blur)
c_custom = zeros(40, 40);
c_custom(1:30, 15) = 1;
c_custom = c_custom/15;

mesh(c_custom);

dblr_custom = fft2(double(checker_blur))./fft2(c_custom);
dblr_custom(isnan(dblr_custom)) = 0;
mesh(angle(dblr_custom));
ifft2(dblr_custom);

%mesh(abs(fftshift(fft2(c_custom))));
%imagesc(abs(ifft2(fft2(double(checker_blur))./(fft2(c_custom)+0.0001)))), colormap(gray);

%% (custom filter - gaussian)
gsize = 11; gsigma = 3;
gausian = fspecial('gaussian', gsize, gsigma);
gausian_blur = gausian(floor(gsize/2)+1:end, floor(gsize/2)+1);
plot(gausian_blur);
gausian_rst = deconvwnr(double(checker_blur), gausian_blur);
imagesc(gausian_rst), colormap(gray);

%% 3.(c)
%% make custom filter
cldf_len = 100;
cldf = zeros(100, 100);
cldf(:, 24) = 100:-1:1;
cldf = cldf./sum(cldf, 'all');
figure, imagesc(cldf), colormap(gray);

%% deconv with cldf
cldf_FT = fft2(cldf, 512, 512);
mimg_FT = fft2(double(img));
mimg_deblurred_FT = zeros(size(mimg_FT));
mimg_deblurred_FT(:,:,1) = mimg_FT(:,:,1)./cldf_FT;
mimg_deblurred_FT(:,:,2) = mimg_FT(:,:,2)./cldf_FT;
mimg_deblurred_FT(:,:,3) = mimg_FT(:,:,3)./cldf_FT;

mimg_deblurred = ifft2(mimg_deblurred_FT);
imagesc(uint8(mimg_deblurred));




%% deconv with gaus - success!!!!!
gsize = 100; gsigma = 10000;
gausian = fspecial('gaussian', gsize, gsigma);
gausian_blur = gausian(floor(gsize/2)+1:end, floor(gsize/2)+1);
figure(2), plot(gausian_blur);
gausian_rst = deconvwnr(dimg_gray, gausian_blur);
figure(1);
subplot(211), imagesc(gausian_rst), colormap(gray);
subplot(212), imagesc(dimg_gray), colormap(gray);

%% deconv with motion blur
blur_len = 3;
motion = fspecial('motion', blur_len, 90);
%plot(gausian_blur);
gausian_rst = deconvwnr(dimg_gray, motion);
figure(1);
subplot(211), imagesc(gausian_rst), colormap(gray);
subplot(212), imagesc(dimg_gray), colormap(gray);

%%
offset_X = 24;
blur_len = 5;
img_size = 512;

blur_filter = zeros(512, 512);
blur_filter(1:blur_len, offset_X) = 0.5;
blur_filter(1:blur_len/2, offset_X) = 1;
blur_filter = blur_filter./sum(blur_filter, 'all');

blur_filter_FT = fft2(blur_filter);
figure, mesh(abs(fftshift(blur_filter_FT)));

blur_filter_FT_inv = 1./(blur_filter_FT);

mys_img = im2gray(imread('mystery_img.png'));
figure, imagesc(double(mys_img)), colormap(gray);

mys_FT = fft2(mys_img);
figure, imagesc(abs(fftshift(mys_FT)), [1, 10000]), colormap(gray);

mys_rst = ifft2(mys_FT.*blur_filter_FT_inv);
figure, imagesc(abs(mys_rst)), colormap(gray);

%% iteration
for n=1:2:99
    offset_X = 24;
    blur_len = n;
    img_size = 512;

    blur_filter = zeros(512, 512);
    blur_filter(1:blur_len, offset_X) = 0.5;
    %blur_filter(1:blur_len/2, offset_X) = 1;
    blur_filter = blur_filter./sum(blur_filter, 'all');

    blur_filter_FT = fft2(blur_filter);
    %figure, mesh(abs(fftshift(blur_filter_FT)));

    blur_filter_FT_inv = 1./(blur_filter_FT);

    mys_img = im2gray(imread('mystery_img.png'));
    %figure, imagesc(double(mys_img)), colormap(gray);

    mys_FT = fft2(mys_img);
    %figure, imagesc(abs(fftshift(mys_FT)), [1, 10000]), colormap(gray);

    mys_rst = ifft2(mys_FT.*blur_filter_FT_inv);
    figure, imagesc(abs(mys_rst)), colormap(gray);
end

%%

offset_X = 1;
blur_len = 21;
img_size = 512;

blur_filter = zeros(512, 512);
blur_filter(1:blur_len, offset_X) = 0.5;
%blur_filter(1:blur_len/2, offset_X) = 1;
blur_filter = blur_filter./sum(blur_filter, 'all');

blur_filter_FT = fft2(blur_filter);
figure, mesh(abs(fftshift(blur_filter_FT)));

blur_filter_FT_inv = 1./(blur_filter_FT);
figure, mesh(abs(fftshift(blur_filter_FT_inv)));

mys_img = im2gray(imread('mystery_img.png'));
figure, imagesc(double(mys_img)), colormap(gray);

mys_FT = fft2(mys_img);
figure, imagesc(abs(fftshift(mys_FT)), [1, 10000]), colormap(gray);

mys_rst = ifft2(mys_FT.*blur_filter_FT_inv);
figure, imagesc(abs(mys_rst)), colormap(gray);










%% old version
%% 3.(c)
df_size = 512;

blur_offset = 0;
blur_len = 10;

blur_filter = zeros(df_size, df_size);
blur_filter(1:blur_len, blur_offset+2) = 1;
blur_filter(end-blur_len:end, blur_offset+2) = 1;
blur_filter(1:blur_len, end-blur_offset) = 1;
blur_filter(end-blur_len:end, end-blur_offset) = 1;
blur_filter = blur_filter./sum(blur_filter, 'all');

figure, mesh(blur_filter);

bf_FT = fft2(blur_filter);
%figure, mesh(abs(fftshift(df_FT)));

bf_FT_inv_z = 1./(bf_FT+0.0001);
figure, imagesc(abs(fftshift(bf_FT_inv_z)), [1, 1000]);

%% how about this custom filter?
bf_custom = zeros(512);
bfc_len = 10;
bf_custom(1:bfc_len,1) = 1;
bf_custom(end-bfc_len+1:end,1) = 1;
mesh(bf_custom);

bf_custom_FT = fft2(bf_custom);
mesh(abs(bf_custom_FT));

bf_custom_FT_inv = 1./(bf_custom_FT+0.0001);
mesh(abs(bf_custom_FT_inv));

%%
test_img = im2double(imread('test_img.png'));
test_img = im2gray(test_img);
imshow(test_img);
timg_FT = fft2(test_img);
%figure, mesh(abs(timg_FT));
timg_blur_FT = timg_FT.*bf_FT;
%figure, mesh(abs(timg_blur_FT));
timg_blur = ifft2(timg_blur_FT);
figure, imagesc(abs(timg_blur)), colormap(gray);

%%
timg_blur_rst = ifft2(timg_blur_FT.*bf_FT_inv_z);
figure, imagesc(real(timg_blur_rst));

%%
timg_blur_cust_rst = ifft2(timg_blur_FT.*bf_custom_FT_inv);
figure, imagesc(real(timg_blur_cust_rst));

%%
mys_img = im2gray(imread('mystery_img.png'));
imshow(mys_img);

mys_FT = fft2(mys_img);
figure, imagesc(abs(fftshift(mys_FT)), [1, 10000]), colormap(gray);

mys_rst = ifft2(mys_FT.*bf_custom_FT_inv);
figure, imagesc(abs(mys_rst)), colormap(gray);




