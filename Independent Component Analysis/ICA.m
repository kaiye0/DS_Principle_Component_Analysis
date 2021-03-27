load mixture
load mixture_sol

% centering and whitening the data
[m,n]=size(X);
colmean = sum(X,2)/n;
Xc = zeros(m,n);
for i=1:n
    Xc(:,i) = X(:,i)-colmean;
end
[U,Sd,V]=svd(Xc*Xc');
%whitened data
Y = U*sqrt(inv(Sd))*Xc;

% ICA with gradient ascent
iter = 1;
W = randn(m,m); %initial random guess
ascent=1; %any initial value
alpha = 1e-5; % constant step size

while abs(det(ascent))>1e-5
    %implement equations in Task 1&2
    dW = zeros(m,m);
    for i=1:n
        dW = dW - 2*tanh(W*Y(:,i))*(Y(:,i))'; %supergaussian
        %dW = dW + (tanh(W*Y(:,i)) - W*Y(:,i))*(Y(:,i))'; %subgaussian
    end 
    Wtinv = inv(W');
    ascent = (dW/n + Wtinv);
    Wnew = W + alpha*ascent;
    W = Wnew; 
    iter = iter +1;
end

%make the plot
Estsourse = W*Y;
figure(1)
subplot(2,1,1)
plot(Estsourse(1,:))
hold on
plot(S(1,:))
legend({'Estimation', 'Original'},'location', 'northeast')
title('Estimated original source 1')
subplot(2,1,2)
plot(Estsourse(2,:))
hold on
plot(S(2,:))
legend({'Estimation', 'Original'},'location', 'northeast')
title('Estimated original source 2')
