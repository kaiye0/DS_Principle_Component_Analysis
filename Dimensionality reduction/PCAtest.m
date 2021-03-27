%clc; clear;

% "center" the matrix
[n,p]=size(Z);
colmean = sum(Z,2)/p;
Zc = zeros(n,p);
for i=1:p
    Zc(:,i) = Z(:,i)-colmean;
end

% find U using the singular value decomposition
[A,B,C] = svd(Zc/sqrt(p-1));

image = zeros(1200,320); %to store image result
iter =1;
Tx=zeros(n,2);
Tx(:,1)=T(:,1)-colmean; %centered test data
Tx(:,2)=T(:,2)-colmean;

for r = [20 80 140 200]
    U = zeros(n,r);
    for i=1:r
        U(:,i)=A(:,i); %subspace of estimator
    end

    %PCA
    Ty=zeros(n,2); 
    for i=1:2
        %apply estimator and add back empirical mean
        Ty(:,i)=U*U'*Tx(:,i)+colmean; 
    end
    
    %recover the images into 2D data
    image((iter-1)*120+1:iter*120,1:160) = reshape(Ty(:,1), 120,160);
    image((iter-1)*120+1:iter*120,161:320) = reshape(Ty(:,2), 120,160); 
    iter = iter+1;
end

figure(1)
axis equal
subplot(2,3,1)
imagesc(reshape(T(:,1), 120,160))
title('Original')
axis equal
subplot(2,3,2)
imagesc(image(1:120*1,1:160))
title('r=20')
axis equal
subplot(2,3,3)
imagesc(image(1+120:120*2,1:160))
title('r=80') 
axis equal
subplot(2,3,4)
imagesc(image(1+120*2:120*3,1:160)) 
colormap gray 
title('r=140') 
axis equal
subplot(2,3,5)
imagesc(image(1+120*3:120*4,1:160)) 
colormap gray 
title('r=200') 
axis equal
% subplot(2,3,6)
% imagesc(image(1+120*4:120*5,1:160)) 
% colormap gray 
% title('r=l00') 
% axis equal

figure(2)
subplot(2,3,1)
imagesc(reshape(T(:,2), 120,160))
title('Original')
axis equal
subplot(2,3,2)
imagesc(image(1:120*1,161:320))
title('r=20')
axis equal
subplot(2,3,3)
imagesc(image(1+120:120*2,161:320))
title('r=80') 
axis equal
subplot(2,3,4)
imagesc(image(1+120*2:120*3,161:320)) 
colormap gray 
title('r=140') 
axis equal
subplot(2,3,5)
imagesc(image(1+120*3:120*4,161:320)) 
colormap gray 
title('r=200') 
axis equal
% subplot(2,3,6)
% imagesc(image(1+120*4:120*5,161:320)) 
% colormap gray 
% title('r=l00') 
% axis equal

figure(3)
b = diag(B);
plot(b.^2);