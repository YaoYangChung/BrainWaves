function [ CR_SVM ] = SVM_loo_func( C, trn_data, feature, class1_L, class2_L )
dataSet = trn_data(:,1:feature);
class_1 = dataSet(1:class1_L,:);
class_2 = dataSet(class1_L+1:class1_L+class2_L,:);

trnY   = [ones(1,size(class_1,1)),ones(1,size(class_2,1))*-1]';

trn_num = size(dataSet,1);

% C = 100; 
SVM_data = dataSet;
trnY1 = trnY;
L = length(trnY);

% for C = 1:100
    true1 = 0;
    true2 = 0;
for a = 1:L
    u1 = SVM_data(a,:);                                           %輪流一筆當test
    SVM_data(a,:) = [];                                           %在data中去掉
    trnY1 = trnY(a,:);                                            %取同位置之標籤
    trnY(a,:) = [];                                               %在標籤中去掉
    Aeq =trnY';
    for h = 1:L-1
        u(h,:) = SVM_data(h,:);
        for g = 1:L-1
            v(g,:) = SVM_data(g,:);
            H(h,g) = trnY(h)*trnY(g)*u(h,:)*v(g,:)';              %計算H
        end
    end
    f = -ones(L-1,1);
    beq = 0;
    lb = zeros(L-1,1) ;
    ub  = C*ones(L-1,1) ;
    alpha = quadprog(H,f,[],[],Aeq,beq,lb,ub,[],[]);
    alphaOri = alpha;
    alpha( alpha <    sqrt(eps)    ) = 0;
    alpha( alpha > ( C-sqrt(eps) ) ) = C;
    real_alpha(a,:) = alpha';
    for c = 1:L-1
        dd(c,:) = real_alpha(a,c) * trnY(c,1) * SVM_data(c,:);    %%計算W
        w = sum(dd);                                              %%計算W
    end
    for c = 1:L-1
        if real_alpha(a,c) ~= 0                                    
            column = c;               %當等於1時，取該行列
            break;
        end
    end
    b(a,:) = (1/trnY(column,1)) - (w * (SVM_data(column,:))');    %計算b值
    
    SVM_data = [SVM_data(1:a-1,:);u1;SVM_data(a:end,:)];          %將該列去掉之"值"補回去
    trnY = [trnY(1:a-1,:);trnY1;trnY(a:end,:)];                   %將該列去掉之"標籤"補回去
    
    D(a,:) = w * (SVM_data(a,:))' + b(a,1);                       %決策函式
    if a < size(class_1,1) + 1 && D(a,1) > 0
           true1 = true1 + 1;
    end
    if a > size(class_1,1) && D(a,1) < 0
           true2 = true2 + 1;
    end
end

CR_SVM = (true1+true2) / L*100;                                    %計算分類率
% end

end

