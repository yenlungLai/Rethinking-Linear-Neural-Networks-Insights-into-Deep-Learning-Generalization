clear all

load("data/0.mat");
load("data/1.mat");
load("data/2.mat");
load("data/3.mat");
load("data/4.mat");
load("data/5.mat");
load("data/6.mat");
load("data/7.mat");
load("data/8.mat");
load("data/9.mat");


img=(zero(:,:,1)./255);
imgneg=(-zero(:,:,1)./255);

[vec1] =m2vec(img);
u=vec1;

output_folder_flip = 'output_images_flip'; % Folder for img2inv images
output_folder = 'output_images'; % Folder for img2 images

% Create the folders if they don't exist
if ~exist(output_folder_flip, 'dir')
    mkdir(output_folder_flip);
end

if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end


gen = [];
gen2 = [];
n = 5000;
L = 5;
[mat, g1] = main_alg(u, n, L); % Algorithm 1 for training with input u
for i = 2:100
    % normalized and unwrap testing images
    img2 = (zero(:,:,i) ./ 255); % for unflip test label
    [vec2] = m2vec(img2);

    img2inv = (-zero(:,:,i) ./ 255);  % for flipped test label
    [vec2inv] = m2vec(img2inv);

    % Display the image (optional)
%     imshow(img, []);
%     imshow(img2inv, []);

    g2 = mat * vec2;
    g2inv = mat * vec2inv;
    dis1 = acos(dot(g1, g2) / (norm(g1) * norm(g2))) / pi;
    dis2 = acos(dot(g1, g2inv) / (norm(g1) * norm(g2inv))) / pi;
    gen = [gen; dis1];
    gen2 = [gen2; dis2];


    % Save the img2inv image
    filename_inv = fullfile(output_folder_flip, sprintf('img2inv_%d.png', i));
    imwrite(mat2gray(img2inv), filename_inv);

    % Save the img2 image
    filename = fullfile(output_folder, sprintf('img2_%d.png', i));
    imwrite(mat2gray(img2), filename);
end




[decidability]=plot_score_distributions2(gen, gen2)































function [vec] =m2vec(m)
vec=reshape(m,size(m,1)*size(m,2),1);
end




function [mat]=vec2m(m)
mat=reshape(m,28,28);
end


function [yfil,frmat]=Encoding_mat(x,n,t)
k=size(x,1);

rmat=randn(n,k);
% rmat=orth(rmat);
y=rmat*x;
absy=(y);
[sorted_data, sortedindex ]= sort(absy, 'ascend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end




function [RandomfieldM,yfil] =main_alg(Ib,n,L)

xpos=[];  % bob first generate RandomfieldM= WL WL-1 ... LW1
ii=1; inI=Ib(:);
RandomfieldM=eye(length(inI)); 
while ii<=L
    [yfil,frmat]=Encoding_mat(inI,n,length(inI));

    %     yfil=yfil/norm(yfil);
    inI=yfil;
    RandomfieldM=frmat*RandomfieldM;
 
    ii=ii+1;
end
end