function[W_gd W_gd_val phi_train phi_valid RMS_gd RMS_gd_val]=train_gd(trainData, trainRank, validData, validRank)


 %%%%%%Training DataSet   
 % Calculating mean and variance for both training and Validation Data
    mean_f = zeros(1,size(trainData, 2));
    var_f = zeros(1,size(trainData, 2));
    rms_gd=1;
    for mu = .1:.1:.5
            for i = 1:size(trainData,2)
                mean_f(i) = mean(trainData(:,i))+(.5*mu);
                var_f(i) = mean(var(trainData(:,i)));
            end
            
    end
    
     for model_gd = 1:7
     k=1;
     X = size(trainData);
     phi_train = ones(X(1,1),(model_gd-1)*46+1);
                 for col = 1: (size(trainData,2)-1)
                      for row = 1: size(trainData, 1)
                          phi_train(row, col+1) = exp((-1/(2*var_f(col)))*((trainData(row, col)-(mean_f(col)))^2));
                      end
                    mean_f=mean_f+0.5;
                    var_f=var_f+0.5;
                    k=k+46; 
                 end
                 
        [row1 col1] = size(phi_train);
        W_gd = zeros(col1,1);
        
        count=1;
            for lambdaRange = .01:.01:.05
                    for i = 1:500
                       D = (lambdaRange/row1)*W_gd;  
                       W_gd = W_gd-0.001*(D+((phi_train'*((phi_train*W_gd)-trainRank))/row1));
                    end
                error_train_gd=(0.5*(phi_train*W_gd-trainRank)'*(phi_train*W_gd-trainRank))+(0.5*lambdaRange*(W_gd'*W_gd));
                RMS_gd(1,count)=sqrt((2*error_train_gd)/size(trainData,1));  
                if(RMS_gd(1,count) < rms_gd)
                        rms_gd = RMS_gd(1,count);             
                        modelC_gd = model_gd;
                        lamda_gd = lambdaRange;
                end 
                count=count+1;
            end   
        end
             
    %%%%% Training DataSet ends
    
    %%%%% Validation DataSet
    % Calculating mean and variance for Validation Data
    mean_val = zeros(1,size(validData, 2));
    var_val = zeros(1,size(validData, 2));
    
    for mu = .1:.1:.5
            for i = 1:size(validData,2)
                mean_val(i) = mean(validData(:,i))+(.5*mu);
                var_val(i) = mean(var(validData(:,i)));
            end
            
    end
    
    for model_gd_val = 1:7
     p=1;
     Y = size(validData);
     phi_train = ones(Y(1,1),(model_gd_val-1)*46+1);
                 for col = 1: (size(validData,2)-1)
                      for row = 1: size(validData, 1)
                          phi_valid(row, col+1) = exp((-1/(2*var_val(col)))*((validData(row, col)-(mean_val(col)))^2));
                      end
                    mean_val=mean_val+0.5;
                    var_val=var_val+0.5;
                    p=p+46; 
                 end
                 
        [row2 col2] = size(phi_valid);
        W_gd_val = zeros(col2,1);
        
        count_val=1;
            for lambdaRange = .01:.01:.05
                    for i = 1:500
                       D = (lambdaRange/row2)*W_gd_val;  
                       W_gd_val = W_gd_val-0.001*(D+((phi_valid'*((phi_valid*W_gd_val)-validRank))/row2));
                    end
                error_valid_gd=(0.5*(phi_valid*W_gd_val-validRank)'*(phi_valid*W_gd_val-validRank))+(0.5*lambdaRange*(W_gd_val'*W_gd_val));
                RMS_gd_val(1,count_val)=sqrt((2*error_valid_gd)/size(validData,1)); 
                if(RMS_gd_val(1,count_val) < rms_gd_val)
                        rms_gd_val = RMS_gd_val(1,count_val);             
                        modelC_gd_val = model_gd_val;
                        lamda_gd = lambdaRange;
                end 
                count_val=count_val+1;
            end        
      end       
    %%%%% Validation DataSet ends  
end