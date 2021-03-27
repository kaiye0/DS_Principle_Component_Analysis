clc; clear;
load("./training.mat");
load("./test.mat");

% "center" the matrix
[n,p]=size(Z);
colmean = sum(Z,2)/p;
Zc = zeros(n,p);
for i=1:p
    Zc(:,i) = Z(:,i)-colmean;
end

% find U using the singular value decomposition
[A,B,C] = svd(Zc/sqrt(p-1));

image = zeros(1120,184); %to store image result
iter =1;
Tx=zeros(n,2);
Tx(:,1)=T(:,1)-colmean; %centered test data
Tx(:,2)=T(:,2)-colmean;

for r = [0 1 25 50 100]
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
    image((iter-1)*112+1:iter*112,1:92) = reshape(Ty(:,1), 112,92);
    image((iter-1)*112+1:iter*112,93:184) = reshape(Ty(:,2), 112,92); 
    iter = iter+1;
end

figure(1)
axis equal
subplot(2,3,1)
imagesc(reshape(T(:,1), 112,92))
title('Original')
axis equal
subplot(2,3,2)
imagesc(image(1:112*1,1:92))
title('r=0')
axis equal
subplot(2,3,3)
imagesc(image(1+112:112*2,1:92))
title('r=l') 
axis equal
subplot(2,3,4)
imagesc(image(1+112*2:112*3,1:92)) 
colormap gray 
title('r=25') 
axis equal
subplot(2,3,5)
imagesc(image(1+112*3:112*4,1:92)) 
colormap gray 
title('r=50') 
axis equal
subplot(2,3,6)
imagesc(image(1+112*4:112*5,1:92)) 
colormap gray 
title('r=l00') 
axis equal

figure(2)
subplot(2,3,1)
imagesc(reshape(T(:,2), 112,92))
title('Original')
axis equal
subplot(2,3,2)
imagesc(image(1:112*1,93:184))
title('r=0')
axis equal
subplot(2,3,3)
imagesc(image(1+112:112*2,93:184))
title('r=l') 
axis equal
subplot(2,3,4)
imagesc(image(1+112*2:112*3,93:184)) 
colormap gray 
title('r=25') 
axis equal
subplot(2,3,5)
imagesc(image(1+112*3:112*4,93:184)) 
colormap gray 
title('r=50') 
axis equal
subplot(2,3,6)
imagesc(image(1+112*4:112*5,93:184)) 
colormap gray 
title('r=l00') 
axis equal

figure(3)
b = diag(B);
plot(b.^2);