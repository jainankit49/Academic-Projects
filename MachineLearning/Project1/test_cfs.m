function [modelC_test lambdaRange rms_test Erms_testData] = test_cfs(W_train,testData,testRank,trainData,Erms_testData)
  
    
    rms_test=1;
    modelC_test=1;
    N=1;
  
    % Designing mean and variance for testing data
    mean_f=zeros(1,size(testData, 2));
    var_f=zeros(1,size(testData, 2));
         
    for modelCRange=1:7
        mu_test=1;
        
        %Calculating mean and variances 
        for mu=.1:.1:.5
            for i=1:size(testData,2)
                mean_f(i)= mean(testData(:,i))+(.5*mu);
                var_f(i)= mean(var(testData(:,i)));
            end       
            
                 %Calculating design matrix
                 for count=1:N
                    phi_test = zeros(size(testData));
                    for col = 1: size(testRank,2)
                      for row = 1: size(testData, 1)
                          phi_test(row, col) = exp((-1/(2*var_f(col)))*((testData(row, col)-(mean_f(col)))^2));
                      end
                    end
                 
                    phi_test = [ones(size(testData, 1),1) phi_test];
                 
                    if(count==1)
                        basis_test = phi_test;
                    else
                        basis_test = [basis_test phi_test];
                    end
                 end
           
            % Iterating over different values of lamba and finding ERMS test    
            lambda = 1;
                for lambdaRange = .01:.01:.05
                    lambda_range = lambdaRange*eye(size(basis_test, 2) , size(basis_test, 2));
                    lambda_range(1,1) = 0;
                    Wt = inv((basis_test'*basis_test) + lambda_range)*basis_test'*testRank;
                    W_train = Wt;
                    error = (basis_test * W_train - testRank)'*(basis_test * W_train - testRank);
                    Erms_testData(N, mu_test,lambda) = sqrt(error / size(basis_test, 1));
                    if(Erms_testData(N, mu_test,lambda) < rms_test)
                        rms_test = sqrt(error / size(basis_test, 1));             
                        modelC_test = modelCRange;
                    end                        
                    lambda = lambda + 1;
                end
                mu_test = mu_test + 1;
        end
            N = N + 1;
    end
end
