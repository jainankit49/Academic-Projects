function[phi_test RMS_gd_test rms_gd_test modelC_gd_test lambda_gd]=test_gd(W_gd, testData, testRank)    

    mean_t = zeros(1,size(testData, 2));
    var_t = zeros(1,size(testData, 2));
    rms_gd_test=1;
    
    for mu = .1:.1:.5
            for i = 1:size(testData,2)
                mean_t(i) = mean(testData(:,i))+(.5*mu);
                var_t(i) = mean(var(testData(:,i)));
            end
            
    end
    
     for model_gd = 1:7   
     k=1;
     X = size(testData);
     phi_test = ones(X(1,1),(model_gd-1)*46+1);
                 for col = 1: (size(testData,2)-1)
                      for row = 1: size(testData, 1)
                          phi_test(row, col+1) = exp((-1/(2*var_t(col)))*((testData(row, col)-(mean_t(col)))^2));
                      end
                    mean_t=mean_t+0.5;
                    var_t=var_t+0.5;
                    k=k+46; 
                 end
                 
        [row1 col1] = size(phi_test);
        W_gd = zeros(col1,1);
        
        count=1;
        %for model_gd = 1:7
            for lambdaRange = .01:.01:.05
                    for i = 1:500
                       D = (lambdaRange/row1)*W_gd;  
                       W_gd = W_gd-0.001*(D+((phi_test'*((phi_test*W_gd)-testRank))/row1));
                    end
                error_train_gd=(0.5*(phi_test*W_gd-testRank)'*(phi_test*W_gd-testRank))+(0.5*lambdaRange*(W_gd'*W_gd));
                RMS_gd_test(1,count)=sqrt((2*error_train_gd)/size(testData,1)); 
                if(RMS_gd_test(1,count) < rms_gd_test)
                        rms_gd_test = RMS_gd_test(1,count); 
                        rms_gd_test=rms_gd_test+0.01;
                        modelC_gd_test = model_gd;
                        lambda_gd = lambdaRange;
                end 
                count=count+1;
            end   
        end
end