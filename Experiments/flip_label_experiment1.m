clear all

n=5000; L=3;

gens=[]; u=randn(1,512);
[RandomfieldM,y1] =main_alg(u,n,L);
for i=1:3000
    disp(['gen', num2str(i)])
    
    v=randn(1,512);
    y2=RandomfieldM*v'; 
    dis=acos(dot(y1, y2) / (norm(y1) * norm(y2))) / pi;
    gens=[gens;dis];

end




[decie]=plot_score_distributions(gens,gens)

















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


 
