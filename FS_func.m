function [ FS_data, channel_txt ] = FS_func( data, channel, class1_L, class2_L )

class1 = data(1:class1_L,1:size(data,2));
class2 = data(class1_L+1:class1_L+class2_L,1:size(data,2));

L1 = size(class1,1);
L2 = size(class2,1);
L = [L1;L2];
class_num = size(L,1);

m1 = sum(class1)/L1;
m2 = sum(class2)/L2;
mm = [m1;m2];
m = sum(mm)/class_num;

for i = 1:L1
    cm1(i,:) = class1(i,:)-m1;
    c_m1(:,:,i) = cm1(i,:)'*cm1(i,:);
    S1 = diag(sum(c_m1,3)/L1)';
end
for j = 1:L2
    cm2(j,:) = class2(j,:)-m2;
    c_m2(:,:,j) = cm2(j,:)'*cm2(j,:);
    S2 = diag(sum(c_m2,3)/L2)';
end
Si = [S1;S2];

for k = 1:class_num
    P(1,k) = L(k)/sum(L);
    P_Si(k,:) = P(1,k)*Si(k,:);
    Sw = sum(P_Si);
    e(k,:) = mm(k,:)-m;
    f(:,:,k) = P(1,k)*e(k,:)'*e(k,:);
    Sb = diag(sum(f,3))';
end

for x = 1:size(data,2)
    FS(1,x) = Sb(1,x)/Sw(1,x);
end
o = [k];

[value,index] = sort(FS,2,'descend');


for y = 1:30
    FS_data(:,y) = data(:,index(1,y));
end

% for yy =1:99
%     for y = 1:yy
%         FS_data(:,y,yy) = data(:,index(1,y));
%     end
% end

for z = 1:size(data,2)
    channel_txt(:,z) = channel(index(1,z),:);
end
end

