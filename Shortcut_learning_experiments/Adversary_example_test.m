clear all
imageSize = [50, 50]; % Adjust the size as needed
n = 12000; 
k = 2500; % output vector size
nter = 50;  %number of layer L
etha = 500;
j=77; % number of sample in cifar10 dataset


outputFolder = fullfile(pwd, 'restored_images'); % Folder to save restored images

% Create the output folder if it doesn't exist
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
end

imgrefpath = fullfile(pwd, 'LFW_mtcnn_aligned', 'Aaron_Eckhart', 'Aaron_Eckhart_0001.jpg');
img_aaron = imread(imgrefpath);
v1 = processImage(img_aaron, imageSize);

imggenpath = fullfile(pwd, 'LFW_mtcnn_aligned', 'Carlton_Baugh', 'Carlton_Baugh_0001.jpg');
img_amber = imread(imggenpath);
v2 = processImage(img_amber, imageSize);
imgv2=reshape(v2,imageSize(1),imageSize(2));

% Get transformation matrix H
H = eye(k);
invec = v1;




imgquerypath= strcat(pwd, '\cfaroutput\image_',num2str(j),'.png');
img_cfar=imread(imgquerypath);

vquery=processImage(img_cfar,imageSize);
imgv3=reshape(vquery,imageSize(1),imageSize(2));

for i = 1:nter
    [cstar, reducedMat] = Encoding(invec', n, k);
    invec = cstar' / norm(cstar);
    H = reducedMat * H;

    outv1 = invec';
    outv2 = H * v2' / norm(H * v2');
    outvquery = H * vquery' / norm(H * vquery');

    angledis = acos(dot(outvquery, outv2) / (norm(outvquery) * norm(outv2))) / pi;
    normdis = norm(outvquery -outv2)^2/4;
    hammingdis = sum(sign(outvquery)~=sign(outv2))/length(outv2);
    
    
    disp(['Iteration: ', num2str(i), ', Angle: ', num2str(angledis)]);
    disp(['Iteration: ', num2str(i), ', Norm: ', num2str(normdis)]);
    disp(['Iteration: ', num2str(i), ', Hamming: ', num2str(hammingdis)]);




    encodev=v1'+etha*outv2;
    decodev=encodev+etha*outvquery;

    restorimgv=reshape(decodev,imageSize(1),imageSize(2));
    imshow(restorimgv,[],'InitialMagnification', 200)
 

     % Save restored image
    imageName = ['restored_image_iter_', num2str(i)];
    imageName2 = 'noise_image';   imageName3 = 'query_image';
    saveAndDisplay(imageName, restorimgv, outputFolder);
    
end
saveAndDisplay(imageName2, imgv2, outputFolder);
saveAndDisplay(imageName3, imgv3, outputFolder);













function [yfil,frmat]=Encoding(x,n,t)
k=length(x);

rmat=randn(n,k);
% rmat=orth(rmat);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end





% Function to save and display the image in grayscale
function saveAndDisplay(imageName, image, outputFolder)
% Convert the image to uint8 for grayscale
grayscaleImage = uint8(255 * mat2gray(image));

% Save the image to the specified folder in grayscale
imagePath = fullfile(outputFolder, [imageName, '.png']);
imwrite(grayscaleImage, imagePath);
disp(['Image saved: ', imagePath]);
end


function v1 = processImage(img1, imageSize)
% Read the input image


% Convert to grayscale
grayImage1 = rgb2gray(img1);

% Convert to double
img1 = double(grayImage1);

% Resize the image
img_normalized1_resized = imresize(img1, imageSize);

% Calculate mean and standard deviation
meanimg1 = mean(img_normalized1_resized(:));
sdimg1 = std(img_normalized1_resized(:));

% Normalize the image
img_normalized1 = (img_normalized1_resized - meanimg1) / sdimg1;

% Reshape the normalized image to a vector
v1 = reshape(img_normalized1, 1, prod(imageSize));
end
