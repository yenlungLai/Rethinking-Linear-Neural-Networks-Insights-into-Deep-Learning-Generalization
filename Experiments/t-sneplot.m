clear all

n=5000; L=9;  k=512; N=1000;
gens=[]; u=randi([0 255],1,k); u=u/norm(u);
ii=1; inI=u(:);
RandomfieldM=eye(length(inI));
uvec=u;vvec=[];

uvec=[];
while ii<=L
    [y1,frmat]=Encoding_mat(inI,n,length(inI));

    inI=y1;   y1=y1/norm(y1);
    frmatii{ii}=frmat;
    uvec=[uvec;y1'];

    ii=ii+1;



end



for i=1:N

    disp(['gen', num2str(i)])
    v=randn(1,k);
    vvec=[];
    vf=v;
    for ii=1:L
        fmatii=frmatii{ii};
        y2=fmatii*vf';
        y2=y2/norm(y2); vf=y2';
        vvec=[vvec;y2'];
    end
    vveccell{i}=vvec;

end

for ll=1:L
    uvL=uvec(ll,:);
    vv=[];
    for jj=1:N
        vvecjj=vveccell{jj};
        vvecs=vvecjj(ll,:);
        vv=[vv;vvecs];
    end

    vvL{ll}=vv;
end

x=uvL;


for i = 1:L
    y{i} = vvL{i}; % Example data for y in each cell
end

% Number of rows and columns for subplots
rows = ceil(sqrt(L));
cols = ceil(L / rows);
% Marker size and edge thickness
markerSize1 = 100; % Adjust the size as needed
markerSize2= 300; % Adjust the size as needed
lineWidth = 2; % Adjust the thickness as needed

% Perform t-SNE for each pair of x and y = z{i}, and plot in subplots
figure;
for i = 1:L
    combined_data = [x; y{i}];
    rng('default'); % For reproducibility
    Y = tsne(combined_data);
    
    % Create subplot
    subplot(rows, cols, i);
    scatter(Y(2:end, 1), Y(2:end, 2), markerSize1, '.', 'MarkerEdgeColor', '#0072BD', 'LineWidth', lineWidth, 'DisplayName', '$\frac{x_L}{||x_L||}$'); % Circle for y vectors
    hold on;
    scatter(Y(1, 1), Y(1, 2), markerSize2, '.', 'MarkerEdgeColor', '#A2142F', 'LineWidth', lineWidth, 'DisplayName', '$\frac{x''^{(j)}_L}{||x''^{(j)}_L||}$'); % Square for x vector
    hold off;
    title(['$L$=' num2str(i)], Interpreter="latex");
    xlabel('t-SNE Dimension 1');
    ylabel('t-SNE Dimension 2');
    legend(Interpreter="latex");
    axis equal; % Set the aspect ratio to be equal
end
% sgtitle('t-SNE Visualization of x and Multiple y Sets'); % Overall title for the subplots
%
% [decie]=plot_score_distributions(gens,gens)
%
%
%
%













function read_and_save_csv_first_column(filename)
% Read the file into a table
T = readtable(filename, 'ReadVariableNames', false);

% Extract the first column
T_without_first_column = T(:, 1);

% Convert the table to a numeric matrix
index = table2array(T_without_first_column);

% Save data in .mat format
[~, index, ~] = fileparts(index);
save([index, 'index.mat'], 'index');
end







function [mat]=generate_m(n)
mat=randn(n,512);

end

function [ww] = LSH(w,mat)

v=mat*w';
ww=sign(v);
ww(ww==-1)=0;
ww=ww';
end



function [frr, far] = getfarfrr(gen,imp,mine,maxe,dec)
gar=[];
for t=mine:dec:maxe



    gencal=gen(gen(:)<=t);
    if isempty(gencal)
        genrate=0;
    else
        genrate=length(gencal)/length(gen);
    end
    gar=[gar;genrate];


end
frr=1-gar;



far=[];

for t=mine:dec:maxe
    impcal=imp(imp(:)<=t);
    if isempty(impcal)
        imprate=0;
    else
        imprate=length(impcal)/length(imp);
    end

    far=[far;imprate];

end




end











function [yfil,frmat]=Encoding_mat(x,n,t)
k=size(x,1);

rmat=randn(n,k);
% rmat=orth(rmat);
y=rmat*x;
absy=abs(y);
[sorted_data, sortedindex ]= sort(absy, 'descend');
topindex=(sortedindex(1:t));
frmat=rmat(topindex,:);
yfil=y(topindex);

end




function [RandomfieldM,yfil] =main_alg(Ib,n,L)


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



