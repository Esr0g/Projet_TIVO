function [matchedPoints1,matchedPoints2] = methodChoice(I1,I2, detectionMethod, descriptorMethod)
    switch detectionMethod
        case 'Harris'
            points1 = detectHarrisFeatures(I1);
            points2 = detectHarrisFeatures(I2);
        case 'MinEigen'
            points1 = detectMinEigenFeatures(I1);
            points2 = detectMinEigenFeatures(I2);
        case 'FAST'
            points1 = detectFASTFeatures(I1);
            points2 = detectFASTFeatures(I2);
        case 'SIFT'
            points1 = detectSIFTFeatures(I1);
            points2 = detectSIFTFeatures(I2);
        case 'SURF'
            points1 = detectSURFFeatures(I1);
            points2 = detectSURFFeatures(I2);
        case 'KAZE'
            points1 = detectKAZEFeatures(I1);
            points2 = detectKAZEFeatures(I2);
        case 'BRISK'
            points1 = detectBRISKFeatures(I1);
            points2 = detectBRISKFeatures(I2);
        case 'MSER'
            points1 = detectMSERFeatures(I1);
            points2 = detectMSERFeatures(I2);
        case 'ORB'
            points1 = detectORBFeatures(I1);
            points2 = detectORBFeatures(I2);
        otherwise
            error('Unexpected detection method')
    end

    switch descriptorMethod
        case 'HOG'
            [f1, vpts1] = extractHOGFeatures(I1, points1);
            [f2, vpts2] = extractHOGFeatures(I2, points2); 
        case 'LBP'
            [f1, vpts1] = extractLBPFeatures(I1, points1);
            [f2, vpts2] = extractLBPFeatures(I2, points2); 
        otherwise
            [f1, vpts1] = extractFeatures(I1, points1, 'Method',descriptorMethod);
            [f2, vpts2] = extractFeatures(I2, points2, 'Method',descriptorMethod); 
    end
    
    indexPairs = matchFeatures(f1, f2) ;
    matchedPoints1 = vpts1(indexPairs(1:end, 1));
    matchedPoints2 = vpts2(indexPairs(1:end, 2));
end

