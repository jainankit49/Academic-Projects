function [W] = train
clear all;
format long;
close all;

%Loading training data
X_0 = load('features_train\0.txt');
X_1 = load('features_train\1.txt');
X_2 = load('features_train\2.txt');
X_3 = load('features_train\3.txt');
X_4 = load('features_train\4.txt');
X_5 = load('features_train\5.txt');
X_6 = load('features_train\6.txt');
X_7 = load('features_train\7.txt');
X_8 = load('features_train\8.txt');
X_9 = load('features_train\9.txt');

%Since X is a N*(D+1) matrix with N being number of samples and D being
%number of features

%Creating another column for class label and then combining all data into one
%training data matrix

X_combine = [X_0;X_1;X_2;X_3;X_4;X_5;X_6;X_7;X_8;X_9];   %19978*512 
dim = size(X_combine);
rowCount = dim(:,1);
colCount = dim(:,2);

X_trainData = [ones(rowCount,1),X_combine];
size_train = size(X_trainData); %19978*513

%Finding W and T 
W=rand(513,10);
T=zeros(rowCount,10);
T(1:2000,1)=ones(2000,1);
T(2001:3979,2)=ones(1979,1);
T(3980:5978,3)=ones(1999,1);
T(5979:7978,4)=ones(2000,1);
T(7979:9978,5)=ones(2000,1);
T(9979:11978,6)=ones(2000,1);
T(11979:13978,7)=ones(2000,1);
T(13979:15978,8)=ones(2000,1);
T(15979:17978,9)=ones(2000,1);
T(17979:19978,10)=ones(2000,1);

[row col] = size(T);   %513*10

%Activation fuction(a) and Softmax function
%Dimension of X_trainData is 19978*513 and W is 513*10. Therfore a = X_trainData*W is
%going to be 19978*10. 

a=X_trainData*W;  %19978*10
Y=bsxfun(@rdivide,exp(a),sum(exp(a),2));     %Softmax Function


%Finding Error and delta Error(error gradient)
err= -1*sum(sum(T.*log(Y),2));
error_gradient = X_trainData'*(Y-T);   % 513x19978 19978x10


%Finding minimum error
err_old = inf;
err_new = err;
eta = 0.00003;

%Gradient Descent to train W
for i=1:1000
    W = W - (eta*error_gradient);
    a=X_trainData*W;  %19978*10
    Y=bsxfun(@rdivide,exp(a),sum(exp(a),2));     %Softmax Function 19978*10
    error_gradient_old=error_gradient;
    err_old = err_new;
    error_gradient = X_trainData'*(Y-T);  %513*10
    err_new= -1*sum(sum(T.*log(Y)));  
    if (err_new < err_old)
        err_old=err_new;
    else
        W=W+(eta*error_gradient_old);
        error_gradient=error_gradient_old;
        eta=0.75*eta;
    end
    Error(i)= err_new;
       
end

plot(1:1000,Error);
xlabel('Number of iterations');
ylabel('Error');
end
%Err_rate=test_lr(W);


