function [ CR_KNN ] = KNN_loo_func( K, trn_data, feature, class1_L, class2_L )
trn = trn_data(:,1:feature);
class_1 = trn(1:class1_L,:);
class_2 = trn(class1_L+1:class1_L+class2_L,:);
truth = [ones(size(class_1,1),1)*1;ones(size(class_2,1),1)*-1];

trn_num = size(trn,1);
for i = 1:trn_num
    for j = 1:trn_num
        dis(i,j) = norm(trn(i,:)-trn(j,:));
    end
end
[KNN_value,KNN_index] = sort(dis,2,'ascend');

yes = 0;
for k = 1:size(KNN_index,1)
    guess(k,1:K) = truth(KNN_index(k,2:K+1),1);
    M(k,1) = mode(guess(k,:));
    if M(k,:) == truth(k,:)
        yes = yes + 1;
    end
end
CR_KNN = (yes/size(KNN_index,1))*100;
end

