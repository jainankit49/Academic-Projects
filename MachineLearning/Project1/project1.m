    format long
    clear
    clear all;
    close all;
    clc;
    load('project1_data.mat');
    %Dividing data in training, validation and test

    trainData = A(1:55698,2:47);
    trainRank = A(1:55698,1:1);
    validData = A(55699:62660,2:47);
    validRank = A(55699:62660,1:1);
    testData = A(62661:69623,2:47);
    testRank = A(62661:69623,1:1);
    
   
    %Calling train, validation and test functions
    [modelC modelC_val W_train W_val Erms_trainData,Erms_validData,mean_f,var_f] = train_cfs(trainData,trainRank,validData,validRank,Erms_trainData,Erms_validData);
    [modelC_test lambdaRange rms_test Erms_testData] = test_cfs(W_train,testData,testRank,trainData,Erms_testData);
    [W_gd W_gd_val phi_train phi_valid RMS_gd RMS_gd_val] = train_gd(trainData, trainRank, validData, validRank);
    [phi_test RMS_gd_test rms_gd_test modelC_gd_test lambda_gd]=test_gd(W_gd, testData, testRank);    
    
    
    fprintf('My ubit name is %s \n','ajain22');
    fprintf('My student number is %d \n',50097432);
    fprintf('the model complexity M cfs is %d \n', modelC_test);
    fprintf('the model complexity M gd is %d \n', modelC_gd_test);
    fprintf('the regularization parameters lambda cfs is %4.2f \n', lambdaRange);
    fprintf('the regularization parameters lambda gd is %4.2f \n', lambda_gd);
    fprintf('the root mean square error for the closed form solution is %4.2f \n', rms_test);
    fprintf('the root mean square error for the gradient descent method is %4.2f \n', rms_gd_test);
    
    save ('project1_data.mat');  
    save ('mu_cfs.mat','mean_f');
    save ('s_cfs.mat','var_f');
    save ('W_cfs.mat','W_train'); 
    save ('W_gd.mat','W_gd');
    save ('mu_gd.mat','mean_f');
    save ('s_gd.mat','var_f');
