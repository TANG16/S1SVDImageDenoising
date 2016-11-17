%% Code for Image Denoising for S1_SVD Algorithm
clear all; %clc;  close all;

%% Data Initilization
n = 8;          % Patch size n x n
K = 100;        % Dictionary Atoms
Sigma = 10;     % Noise STD
nTrials = 5;    % # of Trials

Im_O = double((imread('..\images\peppers256.png')));   % use imshow to see with uint8 512x512 rgb2gray
% Im_O = Im_O(1:2:end,1:2:end);                   % 256 x 256

% Im_O(1:8:end,1:8:end) = 0;                      % Missing Pixels
PSNRIn = zeros(1,nTrials);
PSNROut = zeros(1,nTrials);   PSNROut_ = PSNROut; tic;
parfor i = 1:nTrials
%% Noise Addition and PSNR Calc
Noise = Sigma*randn(size(Im_O));
Im_N = Im_O + Noise;
PSNRIn(1,i) = 20*log10(255/sqrt(mean(Noise(:).^2)));

%% Denoising using Overcomplete DCT Dictionary
% [Im_DCT,D_DCT] = Denoise_DCT(Im_N,Sigma,K,n);
% 
% PSNROut = 20*log10(255/sqrt(mean((Im_DCT(:)-Im_O(:)).^2)));
% figure;
% subplot(1,3,1); imshow(Im_O,[]); title('Original clean image');
% subplot(1,3,2); imshow(Im_N,[]); title(strcat(['Noisy image, ',num2str(PSNRIn),'dB']));
% subplot(1,3,3); imshow(Im_DCT,[]); title(strcat(['Clean Image by DCT dictionary, ',num2str(PSNROut),'dB']));
% figure;
% I = displayDictionaryElementsAsImage(D_DCT, floor(sqrt(K)), floor(size(D_DCT,2)/floor(sqrt(K))),n,n,0);
% title('The DCT dictionary');

%% Denoising with K-SVD
[Im_KSVD,D_K] = Denoise(Im_N,Sigma,K,n,'KSVD');

PSNROut(1,i) = 20*log10(255/sqrt(mean((Im_KSVD(:)-Im_O(:)).^2)));
% figure;
% subplot(1,3,1); imshow(Im_O,[]); title('Original clean image');
% subplot(1,3,2); imshow(Im_N,[]); title(strcat(['Noisy image, ',num2str(PSNRIn(1,i)),'dB']));
% subplot(1,3,3); imshow(Im_KSVD,[]); title(strcat(['Clean Image by K-SVD , ',num2str(PSNROut(1,i)),'dB']));
% figure;
% I = displayDictionaryElementsAsImage(D_K, floor(sqrt(K)), floor(size(D_K,2)/floor(sqrt(K))),n,n,0);
% title('The K-SVD dictionary');

%% Denoising with S_2 & S_3 Algorithms
% [Im_S,D_S] = Denoise(Im_N,Sigma,K,n,'S5');

% PSNROut_(1,i) = 20*log10(255/sqrt(mean((Im_S(:)-Im_O(:)).^2)));
% figure;
% subplot(1,3,1); imshow(Im_O,[]); title('Original clean image');
% subplot(1,3,2); imshow(Im_N,[]); title(strcat(['Noisy image, ',num2str(PSNRIn(1,i)),'dB']));
% subplot(1,3,3); imshow(Im_S,[]); title(strcat(['Clean Image by S_2 , ',num2str(PSNROut_(1,i)),'dB']));
% figure;
% I = displayDictionaryElementsAsImage(D_S, floor(sqrt(K)), floor(size(D_S,2)/floor(sqrt(K))),n,n,0);
% title('The S_2 dictionary');

end
mean(PSNROut)
toc/60