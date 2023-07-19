function [ CR_LDA ] = LDA_fix_function( trn_data, feature, class1_L, class2_L )
BP_value = trn_data(:,1:feature);
class_1 = BP_value(1:class1_L,:);
class_2 = BP_value(class1_L+1:class1_L+class2_L,:);
database = {class_1;class_2};
[num_data,num_feature] = size(BP_value);
N  = [size(class_1,1) ,size(class_2,1)]; % [N1,N2]
C  = [1 ,1]; % user_defined  [C12,C21]
training_data = BP_value;
u_1 = (mean(training_data(1 : N(1,1),:)))'; % class_1_�L�ܰʪ� u_1
u_2 = (mean(training_data(N(1,1) + 1 : num_data,:)))'; % class_2_�L�ܰʪ� u_2
pi = [(size(training_data(1:N(1,1),1),1))/(size(training_data,1)-1),... % class_1_�L�ܰʪ� �ƫe���v
    (size(training_data(N(1,1) + 1 : num_data,1),1))/(size(training_data,1)-1)]; % class_2_�L�ܰʪ� �ƫe���v
%correct = 0;
labels = [ones(size(class_1,1),1);ones(size(class_2,1),1).*-1]';
for i = 1:num_data  % Leave-one-out ���� i �� test
    training_data(i,:) = []; % ��� i ���� test_data �Ѿl�� training_data
    for j = 1 : num_data - size(database,1) % ��� i ���� ���� i �ȩҦb���O�|�֤@�C �]���G�� �G�� num_data - 2
        if i <= N(1,1) && j<= N(1,1)-1 % �p��class_1 �ܰʪ��@�ܲ��x�}
            u = (mean(training_data(1 : N(1,1)-1,:),1))'; % class_1_�ܰʪ� u
            A{:,j} = ((training_data(j,:))' - u)*((training_data(j,:))' - u)';
            pi_1 = (size(training_data(1 : N(1,1)-1,1),1))/size(training_data,1); % class_1_�ܰʪ� �ƫe���v
            sigma{1,i} = pi_1*sum(cat(3,A{:}),3)/(size(A,2)-1); % ��K�@�P�@�ܲ��x�}�p�� �����W �ƫe���v
        end   
        if i > N(1,1) && j>= N(1,1) % �p�� class_2 �ܰʪ��@�ܲ��x�}
            a = j+1;  % ��� i �� test_data ������O�� �] j �Ȥ��|�H�� i �ȼW�[ �G�n +1 
                      % �T�O����� training_data ���� class_2 
            u = (mean(training_data(N(1,1)+1 : num_data-1,:),1))'; % class_2_�ܰʪ� u
            A{:,j} = ((training_data(a,:))' - u)*((training_data(a,:))' - u)';
        end
        if i > N(1,1) && j == num_data - 2; % �p�� class_2 �� training_data ���� class_1 �� k �ȵL�@��         
            A(:,1:N(1,1)-1) = [];           % �G ����� A �x�}�b class_1 ���L�@�Ϊ���
            pi_2 = (size(training_data(N(1,1)+1 : num_data-1,1),1))/size(training_data,1); % class_2_�ܰʪ� �ƫe���v
            sigma{2,i} = pi_2*sum(cat(3,A{:}),3)/(size(A,2)-1);
        end
    end
    training_data = BP_value;
    for k = 1 : num_data 
        if  i <= N(1,1) && k > N(1,1) % �p��class_2 �L�ܰʪ��@�ܲ��x�}
            B{:,k} = ((training_data(k,:))' - u_2)*((training_data(k,:))' - u_2)';
        end
        if  i <= N(1,1) && k == num_data  % �p�� class_2 �� training_data ���� class_1 �� k �ȵL�@��
            B(:,1:N(1,1)) = [];           % �G ����� B �x�}�b class_1 ���L�@�Ϊ���
            sigma{2,i} = pi(1,2)*sum(cat(3,B{:}),3)/(size(B,2)-1);
            B(:,N(1,1)+1 : num_data - N(1,1)) = []; % ��L�k�л\��������
        end
        if  i > N(1,1) && k <= N(1,1) % �p��class_1 �L�ܰʪ��@�ܲ��x�}
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