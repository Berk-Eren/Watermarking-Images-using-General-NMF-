clear all;
close all;

m = 1;
n = 9;
iter = 500;
A_size = [m, n];

[file, path] = uigetfile({'*.png;*.jpeg;*.jpg;*.bmp'}, "Select your image to be watermarked.","Pictures/");
original_img = imread(fullfile(path, file));

[file, path] = uigetfile({'*.png;*.jpeg;*.jpg;*.bmp'}, "Select your image to be used as watermark.", "Pictures/");
watermark = imread(fullfile(path, file));

if(size(size(original_img), 2) == 3)
    original_img = im2double(rgb2gray(original_img));
else
    original_img = im2double(original_img);
end

if(size(size(watermark), 2) == 3)
    watermark = im2double(rgb2gray(watermark));
else
    watermark = im2double(watermark);
end

[A_org, B_org, step_org] = factorize_matrix(original_img, iter, m, n);
[basis_org, coeff_org] = inverse_lstp(step_org, A_org, B_org);

C_original = lstp(basis_org, coeff_org);
[watermarked_image, min_val] = watermark_embed(basis_org, coeff_org, watermark);
extracted_watermark = watermark_extract(C_original, watermarked_image, iter, min_val, m, n);

psnr_org = psnr(original_img, C_original);
psnr_wat = psnr(watermark, extracted_watermark);
ssim_wat = ssim(watermark, extracted_watermark);

f = figure(1);
set(f, 'Position', [1400, 0, 500, 500]);
subplot(121), imshow(watermark), title("Watermark Image");
subplot(122), imshow(extracted_watermark), title("Extracted Watermark");
sgtitle({'PSNR = '+string(psnr_wat), 'SSIM = '+string(ssim_wat)});

f = figure(2);
set(f, 'Position', [0, 0, 500, 500]);
subplot(221), imshow(original_img), title("Original Image");
subplot(222), imshow(watermarked_image), title("Watermarked Image");
subplot(223), imshow(watermark), title("Watermark");
subplot(224), imshow(extracted_watermark), title("Extracted Watermark");

f = figure(3);
subplot(121), imshow(original_img), title("Original Image");
subplot(122), imshow(C_original), title("Reconstructed Image");
sgtitle('PSNR = '+string(psnr_org));