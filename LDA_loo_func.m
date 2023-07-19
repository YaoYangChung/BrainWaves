function [ CR_LDA ] = LDA_fix_function( trn_data, feature, class1_L, class2_L )
BP_value = trn_data(:,1:feature);
class_1 = BP_value(1:class1_L,:);
class_2 = BP_value(class1_L+1:class1_L+class2_L,:);
database = {class_1;class_2};
[num_data,num_feature] = size(BP_value);
N  = [size(class_1,1) ,size(class_2,1)]; % [N1,N2]
C  = [1 ,1]; % user_defined  [C12,C21]
training_data = BP_value;
u_1 = (mean(training_data(1 : N(1,1),:)))'; % class_1_無變動的 u_1
u_2 = (mean(training_data(N(1,1) + 1 : num_data,:)))'; % class_2_無變動的 u_2
pi = [(size(training_data(1:N(1,1),1),1))/(size(training_data,1)-1),... % class_1_無變動的 事前機率
    (size(training_data(N(1,1) + 1 : num_data,1),1))/(size(training_data,1)-1)]; % class_2_無變動的 事前機率
%correct = 0;
labels = [ones(size(class_1,1),1);ones(size(class_2,1),1).*-1]';
for i = 1:num_data  % Leave-one-out 的第 i 筆 test
    training_data(i,:) = []; % 抽第 i 筆為 test_data 剩餘為 training_data
    for j = 1 : num_data - size(database,1) % 抽第 i 筆時 那筆 i 值所在類別會少一列 因有二類 故為 num_data - 2
        if i <= N(1,1) && j<= N(1,1)-1 % 計算class_1 變動的共變異矩陣
            u = (mean(training_data(1 : N(1,1)-1,:),1))'; % class_1_變動的 u
            A{:,j} = ((training_data(j,:))' - u)*((training_data(j,:))' - u)';
            pi_1 = (size(training_data(1 : N(1,1)-1,1),1))/size(training_data,1); % class_1_變動的 事前機率
            sigma{1,i} = pi_1*sum(cat(3,A{:}),3)/(size(A,2)-1); % 方便共同共變異矩陣計算 先乘上 事前機率
        end   
        if i > N(1,1) && j>= N(1,1) % 計算 class_2 變動的共變異矩陣
            a = j+1;  % 抽第 i 筆 test_data 於跨類別時 因 j 值不會隨著 i 值增加 故要 +1 
                      % 確保抽取到 training_data 中的 class_2 
            u = (mean(training_data(N(1,1)+1 : num_data-1,:),1))'; % class_2_變動的 u
            A{:,j} = ((training_data(a,:))' - u)*((training_data(a,:))' - u)';
        end
        if i > N(1,1) && j == num_data - 2; % 計算 class_2 時 training_data 中的 class_1 的 k 值無作用         
            A(:,1:N(1,1)-1) = [];           % 故 抽取掉 A 矩陣在 class_1 中無作用的行
            pi_2 = (size(training_data(N(1,1)+1 : num_data-1,1),1))/size(training_data,1); % class_2_變動的 事前機率
            sigma{2,i} = pi_2*sum(cat(3,A{:}),3)/(size(A,2)-1);
        end
    end
    training_data = BP_value;
    for k = 1 : num_data 
        if  i <= N(1,1) && k > N(1,1) % 計算class_2 無變動的共變異矩陣
            B{:,k} = ((training_data(k,:))' - u_2)*((training_data(k,:))' - u_2)';
        end
        if  i <= N(1,1) && k == num_data  % 計算 class_2 時 training_data 中的 class_1 的 k 值無作用
            B(:,1:N(1,1)) = [];           % 故 抽取掉 B 矩陣在 class_1 中無作用的行
            sigma{2,i} = pi(1,2)*sum(cat(3,B{:}),3)/(size(B,2)-1);
            B(:,N(1,1)+1 : num_data - N(1,1)) = []; % 把無法覆蓋的行抽取掉
        end
        if  i > N(1,1) && k <= N(1,1) % 計算class_1 無變動的共變異矩陣
            B{:,k} = ((training_data(k,:))' - u_1)*((training_data(k,:))' - u_1)';
            sigma{1,i} = pi(1,1)*sum(cat(3,B{:}),3)/(size(class_1,1)-1);
        end
    end
    sigma_all{1,i} = sigma{1,i}+sigma{2,i};
    if i <= N(1,1)  % class_1
        w{1,i} = ((u - u_2)')*(pinv(sigma_all{1,i}));
        b(1,i) = (-(w{1,i} * (u + u_2))/2 - log((C(1,1)*pi(1,2))/(C(1,2)*pi_1))); %bias
    end
    if i > N(1,1)  % class_2
        w{1,i} = ((u_1 - u)')*(pinv(sigma_all{1,i}));
        b(1,i) = (-(w{1,i} * (u_1 + u))/2 - log((C(1,1)*pi_2)/(C(1,2)*pi(1,1)))); %bias
    end
    LDA_ans(1,i) = w{1,i} * training_data(i,:)' + b(1,i);
    labels_guessed(i) = sign(LDA_ans(i));
%     if i <= N(1,1) && LDA_ans(1,i) > 0
%         correct = correct+1;
%     end
%     if i > N(1,1) && LDA_ans(1,i) < 0
%         correct = correct+1;
%     end
end
CR_LDA = (sum(labels_guessed == labels)/ num_data)*100;
%CR = (correct / num_data)*100

% for q= 1:j
%     A{:,q} = [];
%     B{:,q} = [];
% end
end