function [w_ji w_kj] = train_nn()
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

maxIter = 300;
error_in_Iteration = zeros(maxIter,1);
%Since X is a N*(D+1) matrix with N being number of samples and D being
%number of features

%Creating another column for class label and then combining all data into one
%training data matrix

X_combine = [X_0;X_1;X_2;X_3;X_4;X_5;X_6;X_7;X_8;X_9];   %19978*512 
dim = size(X_combine);
rowCount = dim(:,1);
colCount = dim(:,2);

train_X = [ones(rowCount,1),X_combine];
size_train = size(train_X); %19978*513
d = size_train(:,2);
c = size_train(:,1);


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

%Step 1: Set number of hidden neurons
m = 20;
eta = 0.00003;


%Step 2: Initialize weight matrices
k = 10;
w_ji = rand(m,d) - 0.5;
w_kj = rand(k,m+1) - 0.5;
z_j =  ones(c,m+1);

for iter=1:maxIter
%Feed Forward Stage
%1) Finding a_j
a_j = train_X * w_ji';

%2) Finding z_j
z_j(:,1) = 1;
z_j(:,2:end) = tanh(a_j);

%3) Finding a_k
a_k = z_j * w_kj';

%4) Finding y_k
err=0;
y_k=bsxfun(@rdivide,exp(a_k),sum(exp(a_k),2));
for i=1:d
   err=err +(-1 * sum(sum(T .* log(y_k))));
end
error_in_Iteration(iter) = err;

%Back Propagation Stage
delta_k = y_k - T;
error_gradient_two = delta_k'*z_j;
delta_j = delta_k*w_kj;
error_gradient_one = ((delta_j(:,2:end).*(ones(c,m)-(z_j(:,2:end)).^2))')*train_X;


%Gradient Descent to learn weights
%w_ji_prev = w_ji;
%w_kj_prev = w_kj;
w_ji = w_ji - eta*error_gradient_one;
w_kj = w_kj - eta*error_gradient_two;
eta=0.75*eta;
end

it=1:iter;
plot(it,error_in_Iteration);
xlabel('No. of iterations');
ylabel('Cross Entropy Error (E)');

end



