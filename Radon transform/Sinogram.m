clc; clear;close all;


image = imread('SheppLogan_Phantom.svg.png');
image = imresize(image(:, :, 1), [512, 512]);
% image = padarray(image_real, [0 0], 0, 'both');
[height, width] = size(image);


y_theta = 0:0.5:179.5;

radon_image = radon(image, y_theta);
radon_image = imrotate(radon_image, 90);

sinogram_image = zeros(size(radon_image, 2), size(radon_image, 2));

figure
imshow(radon_image, [])
xlabel('ro')
ylabel('theta')

figure('Position',[0 200 600 600])
imshow(image, [])
figure
for i=360:-1:1
    ro_s = radon_image(360-i+1, :);
    ro_s = repmat(ro_s, size(radon_image,2), 1);
    sinogram_image = sinogram_image+ imrotate(ro_s, y_theta(i), "bilinear", 'crop');
    imshow(sinogram_image, [])
    drawnow
    pause(0.0005)
end










