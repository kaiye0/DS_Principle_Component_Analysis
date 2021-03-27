% EE 5531 Fall 2017
% University of Minnesota

% Test the ML version of ICA (w/o stochastic gradient)
%clear all
% close all
% clc
% 
% 
% sources = 2;
% samples = 100;
% t=linspace(0,3,samples);
% S = zeros(sources, samples);
% S(1,:) = sin(2*pi*1*t);
% S(2,:) = square(2*pi*exp(1)*t);
% %S(3,:) = 0.1*sin(2*pi*3*t);
% %%
% close all
% plot(S(1,:))
% hold on
% plot(S(2,:),'r')
% hold off
% %%
% 
% % create mixture
% A = randn(sources,sources);
% Y = A*S;

load mixture
Y = X;
samples = size(Y,2);
sources = size(Y,1);

figure(2)
subplot(2,1,1)
plot(Y(1,:))
subplot(2,1,2)
plot(Y(2,:))


%%

% whiten?
Yzm = Y-repmat(mean(Y,2),1,samples);
CY = Yzm*Yzm';
[U,Sd,V]=svd(CY);
sC = U*sqrt(inv(Sd));
Y = sC*Yzm;

figure(3)
subplot(2,1,1)
plot(Y(1,:))
subplot(2,1,2)
plot(Y(2,:))
%%
iter = 200000;

W = randn(sources,sources);
%W = inv(A);
alpha =  1e-5;

for t = 1:iter 
    %alpha = 1/t;
    Wtinv = inv(W');
    
    Wpart1 = zeros(sources,sources);
    for i=1:samples
    %i = fix(samples*rand)+1;
        %Wpart1 = Wpart1 + (ones(sources,1)-2*sigmoid(W*Y(:,i)))*(Y(:,i))';
        %Wpart1 = Wpart1 - 2*tanh(W*Y(:,i))*(Y(:,i))';
        Wpart1 = Wpart1 + (tanh(W*Y(:,i)) - W*Y(:,i))*(Y(:,i))';
        %Wpart1 = Wpart1 + (ones(sources,1)-2*sigmoid(W*Y(:,i)))*(Y(:,i))';
    end
    
    Wnew = W + alpha*(Wpart1 + sources*samples*Wtinv);
    %Wnew = W + alpha*(eye(2) + Wpart1)*W;
    W = Wnew;
    
    if mod(t,1000)==0
    Shat = W'*Y;
    figure(4)
    subplot(2,3,1)
    plot(Y(1,:))
    subplot(2,3,4)
    plot(Y(2,:))
    subplot(2,3,2)
    hist(Shat(1,:),50)%plot(Shat(1,:))
    subplot(2,3,5)
    hist(Shat(2,:),50)%plot(Shat(2,:))
    subplot(2,3,3)
    plot(Shat(1,:))
    subplot(2,3,6)
    plot(Shat(2,:))
    title(num2str(t))
    drawnow
    %W*A
    end
    
end

    