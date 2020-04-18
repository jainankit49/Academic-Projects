function[modelC modelC_val W_train W_val Erms_trainData,Erms_validData,mean_f,var_f] = train_cfs(trainData, trainRank,validData, validRank, Erms_trainData,Erms_validData)
  
    
    N = 1;
    rms_train = 1;
    modelC = 1;
     
    N_val = 1;
    rms_valid = 1;
    modelC_val = 1;
    
    % Calculating mean and variance for both training and Validation Data
    mean_f = zeros(1,size(trainData, 2));
    var_f = zeros(1,size(trainData, 2));
    mean_val = zeros(1,size(validData, 2));
    var_val = zeros(1,size(validData, 2));
    
    
   %%%%%Working on Train Data
    for modelCRange = 1:7
        mu_train = 1;
        for mu = .1:.1:.5
            for i = 1:size(trainData,2)
                mean_f(i) = mean(trainData(:,i))+(.5*mu);
                var_f(i) = mean(var(trainData(:,i)));
            end
         
            
         for count=1:N
                 phi_train = zeros(size(trainData));
                 for col = 1: size(trainData,2)
                      for row = 1: size(trainData, 1)
                          phi_train(row, col) = exp((-1/(2*var_f(col)))*((trainData(row, col)-(mean_f(col)))^2));
                      end
                 end
                 
                 phi_train = [ones(size(trainData, 1),1) phi_train];
                 if(count==1)
                    basis_train = phi_train;
                 else
                    basis_train = [basis_train phi_train];
                 end
          end      
           
        lambda = 1;
        for lambdaRange = .01:.01:.05
                lambda_range = lambdaRange*eye(size(basis_train, 2) , size(basis_train, 2));
                lambda_range(1,1) = 0;
                W_train  = inv((basis_train'*basis_train) + lambda_range)*basis_train'*trainRank;
                error = (basis_train * W_train - trainRank)'*(basis_train * W_train - trainRank);
                Erms_trainData(1,N) = sqrt(error / size(basis_train, 1));
                if(Erms_trainData(1,N) < rms_train)
                rms_train = sqrt(error / size(basis_train, 1));             
                modelC=modelCRange;
            end                        
            lambda = lambda + 1;
        end
        mu_train = mu_train + 1;
        end
        N = N + 1;
    end
%%%%%Training Ends

%%%%%Working on Validation Data
    for modelCRangeVal = 1:7
        mu_valid = 1;
        for mu_val = .1:.1:.5
            for i = 1:size(validData,2)
                mean_val(i) = mean(validData(:,i))+(.5*mu_val);
                var_val(i) = mean(var(validData(:,i)));
            end
         
            
            for count=1:N_val
                 phi_val = zeros(size(validData));
                    for col = 1: size(validData,2)
                      for row = 1: size(validData, 1)
                          phi_val(row, col) = exp((-1/(2*var_val(col)))*((validData(row, col)-(mean_val(col)))^2));
                      end
                    end
                 
                 phi_val= [ones(size(validData, 1),1) phi_val];
                 
                 if(count==1)
                   basis_valid = phi_val;
                 else
                    basis_valid = [basis_valid phi_val];
                 end
            end      
           
                lambda_val = 1;
            for lambdaRange_val = .01:.01:.05
                lambda_range_val = lambdaRange_val*eye(size(basis_valid, 2) , size(basis_valid, 2));
                lambda_range_val(1,1) = 0;
                W_val = inv((basis_valid'*basis_valid) + lambda_range_val)*basis_valid'*validRank;
                error = (basis_valid * W_val - validRank)'*(basis_valid * W_val- validRank);
                Erms_validData(1,N_val) = sqrt(error / size(basis_valid, 1));
                if(Erms_validData(1,N_val) < rms_valid)
                rms_valid = sqrt(error / size(basis_valid, 1));            
                modelC_val=modelCRangeVal;
                end                        
                lambda_val = lambda_val + 1;
            end
                mu_valid = mu_valid + 1;
        end
            N_val = N_val + 1;
    end
%%%%Validation Ends
end