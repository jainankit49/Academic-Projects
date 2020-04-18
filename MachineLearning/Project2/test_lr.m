W_new = train_lr;

X_0_test=load ('features_test\0.txt');   %150 x 512
X_1_test=load ('features_test\1.txt');   %150 x 512
X_2_test=load ('features_test\2.txt');   %150 x 512
X_3_test=load ('features_test\3.txt');   %150 x 512
X_4_test=load ('features_test\4.txt');   %150 x 512
X_5_test=load ('features_test\5.txt');   %150 x 512
X_6_test=load ('features_test\6.txt');   %150 x 512
X_7_test=load ('features_test\7.txt');   %150 x 512
X_8_test=load ('features_test\8.txt');   %150 x 512
X_9_test=load ('features_test\9.txt');   %150 x 512

X_test_combine=[X_0_test;X_1_test;X_2_test;X_3_test;X_4_test;X_5_test;X_6_test;X_7_test;X_8_test;X_9_test];
dim = size(X_test_combine);
rowTest = dim(:,1);
colTest = dim(:,2);

X_testData = [ones(rowTest,1),X_test_combine];
dim_test = size(X_testData); %19978*513
row_Test = dim_test(:,1);

%Activation Function
a_test = X_testData*W_new;  %1500x513 513x10
Y_test=bsxfun(@rdivide,exp(a_test),sum(exp(a_test),2));     %Softmax Function

T_test=zeros(row_Test,10); 
for i=1:10
    for j=1:150
        T_test(j+(i-1)*150,1)=i;
    end
end

col=0;
count=0;
fid = fopen('classes_lr.txt', 'w+');
for i=1:row_Test
    [val col(i)]=max(Y_test(i,:));
    fprintf( fid ,'%d\n',col(i));
    if(col(i) == T_test(i));
        count = count +1;
    end
end
fclose(fid);
mismatch=1500-count;
error_rate=(mismatch/1500)*100;
sprintf('Misclassification rate %f', error_rate)




