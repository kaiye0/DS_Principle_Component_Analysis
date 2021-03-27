clear; clc;
load('./Hubble.mat');
load('./fireworks.mat')
%% Part 3 Galaxy
size = length(clean_galaxy);
impulse = zero_pad(estimated_g, size, size);
impulse_freq = fft2(impulse);
N = 1000; %f=k/N; N=k/f
peri_est = 1/N^2.*abs(fft2(clean_galaxy)).^2; %periodogram estimate
original = fft2(blurred_galaxy);
sigma = 0.1;
filter = conj(impulse_freq).*peri_est./(abs(impulse_freq).^2.*peri_est+sigma^2);
processed_freq = filter.*original;
processed = ifft2(processed_freq);
processed_real = real(processed);
imagesc(processed_real)
colormap gray

%% Part 4 Firework
% crop impulse response
estimated2 = blurry_fireworks(195:258,107:170);
size2 = length(blurry_fireworks);
impulse2 = zero_pad(estimated2, size2, size2);
impulse_freq2 = fft2(impulse2);

% clean image guess for power spectral density
clean_fw = imread('./clean_fw.png');
clean_firework = double(rgb2gray(clean_fw));
N2 = 1000; %f=k/N; N=k/f
peri_est2 = 1/N2^2.*abs(fft2(clean_firework)).^2; %periodogram estimate
original2 = fft2(blurry_fireworks);
sigma = 0.001;
filter2 = conj(impulse_freq2).*peri_est2./(abs(impulse_freq2).^2.*peri_est2+sigma^2);
processed_freq2 = filter2.*original2;
processed2 = ifft2(processed_freq2);
processed_real2 = real(processed2);
imagesc(processed_real2)
colormap gray


%% Part 4.2 Firework extension
% crop impulse response
estimated3 = blurry_fireworks(42:99,449:506);
impulse3 = zero_pad(estimated3, 512, 164);
impulse_freq3 = fft2(impulse3);

% clean image guess for power spectral density
clean_firework3 = blurry_fireworks(1:512,1:164);
N3 = 1000; %f=k/N; N=k/f
peri_est3 = 1/N3^2.*abs(fft2(clean_firework3)).^2; %periodogram estimate

%subimage
subimage = blurry_fireworks(1:512,1:164);
original3 = fft2(subimage);

sigma3 = 0.001;
filter3 = conj(impulse_freq3).*peri_est3./(abs(impulse_freq3).^2.*peri_est3+sigma3^2);
processed_freq3 = filter3.*original3;
processed3 = ifft2(processed_freq3);
processed_real3 = real(processed3);
imagesc(processed_real3)
colormap gray


