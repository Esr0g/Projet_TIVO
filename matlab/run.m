function run()
close all;
%% définition du répertoire contenant les images vidéo, lecture de la première image
img_path = uigetdir();
files = dir(strcat(img_path, '/*.jpg'));
fname = fullfile(img_path, files(1).name);
I = imread(fname);
fig_video = figure();
imshow(I);
%% Calibration de la caméra à partir des points de fuite
[P,Hw0,K,s] = calibrate(I);
drawcube(P,1/2,s/2,1/2);
% %% Tracking de caméra
% ransac_ntests = 1000;
% ransac_thres = 1.5;
% Hwi = Hw0;
% fig_match = figure;
% I1 = rgb2gray(I);
% for im_num = 2:length(files)
%     fname = fullfile(img_path, files(im_num).name);
%     I = imread(fname);
%     I2 = rgb2gray(I);
%     points1 = detectHarrisFeatures(I1);
%     points2 = detectHarrisFeatures(I2);
%     [f1, vpts1] = extractFeatures(I1, points1, 'Method','Block');
%     [f2, vpts2] = extractFeatures(I2, points2, 'Method','Block'); 
%     indexPairs = matchFeatures(f1, f2) ;
%     matchedPoints1 = vpts1(indexPairs(1:end, 1));
%     matchedPoints2 = vpts2(indexPairs(1:end, 2));
%     n = length(matchedPoints1);   
%     if n >= 4
%         %% RANSAC       
%         locations1 =  matchedPoints1.Location';
%         locations1(3,:) = 1;
%         locations2 =  matchedPoints2.Location';
%         locations2(3,:) = 1;
%         num_max = 0;
%         Hbest = eye(3,3);
%         inliers_best = zeros(1,n);
%         for r = 1:ransac_ntests
%             samples_id = randsample(n,4);
%             samples1 = locations1(:,samples_id);
%             samples2 = locations2(:,samples_id);
%             H = homography(samples1,samples2);
%             locations2p = H*locations1;
%             locations2p = locations2p./(ones(3,1)*locations2p(3,:));
%             diff = locations2 - locations2p;
%             res = sqrt(sum(diff.*diff));
%             inliers = res < ransac_thres;
%             num = sum(inliers);
%             if num > num_max
%                 num_max = num;
%                 Hbest = H;
%                 inliers_best = inliers;
%             end
%         end
%         if num_max >= 4
%             %% Visualize putative matches
%             figure(fig_match);
%             showMatchedFeatures(I1,I2,matchedPoints1(inliers_best),matchedPoints2(inliers_best),'montage');
%             Hwi = Hbest * Hwi; 
%             P = H2P(Hwi,K);
%             %% Visualize the projection matrix
%             figure(fig_video);
%             imshow(I);
%             drawcube(P,1/2,s/2,1/2);
%             I1 = I2; 
%         else
%             figure(fig_video);
%             imshow(I);
%         end
%     end
% end