function [ KFD_data ] = KFD_func( class_data )
class_L = size(class_data{1,1},1);
for k = 1:class_L
    [cha,num] = size(class_data{1,1}{k,1});
    B = class_data{1,1}{k,1};
    C = [1:num];
    for i = 1:cha
        for j = 2:num
            dis1(i,j-1) = norm([C(1,j-1),B(i,j-1)]-[C(1,j),B(i,j)]); %第n秒時與第n-1秒之點距離
            dis2(i,j-1) = norm([C(1,1),B(i,1)]-[C(1,j),B(i,j)]); %第某時之點與第n秒之點距離
        end
        L = sum(dis1(:,1:num-1),2); %某一點到其他點之距離長總和
        d = max(dis2,[],2); %每列所有距離長中最長之距離
        KFD_data(k,i) = log(num-1) / (log(d(i,1)/L(i,1)) + log(num-1) );
    end
end
end

