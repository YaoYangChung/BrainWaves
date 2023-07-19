clc;clear;close all;

rest_t = 120;
task_t = 60;
cut_t = 6;
trial = task_t/cut_t;
channel = 30;
round = 2;
times = 3;

%%  Member1

rest11 = struct2array(load('D:\USER\Desktop\0611_project\rest\rest11.mat'));
run111_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run111_data1.mat'));
run111_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run111_data2.mat'));
run111_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run111_data3.mat'));
run113_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run113_data1.mat'));
run113_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run113_data2.mat'));
run113_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run11\run113_data3.mat'));

rest12 = struct2array(load('D:\USER\Desktop\0611_project\rest\rest12.mat'));
run121_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run121_data1.mat'));
run121_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run121_data2.mat'));
run121_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run121_data3.mat'));
run123_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run123_data1.mat'));
run123_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run123_data2.mat'));
run123_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run12\run123_data3.mat'));

rest_1 = [rest11;rest12];
task_11 = [run111_data1;run111_data2;run111_data3;run121_data1;run121_data2;run121_data3];
task_13 = [run113_data1;run113_data2;run113_data3;run123_data1;run123_data2;run123_data3];

rest_L = length(rest_1);
task_L = length(task_11);

a = 0;
for i = 0:500*cut_t:rest_L-500*cut_t
    a = a + 1;
    a_1(a,:) = reshape (rest_1(:,i+1:i+500*cut_t)',1, numel(rest_1(:,i+1:i+500*cut_t)'));
end
a1 = reshape (a_1',1, numel(a_1'));
rest1 = reshape(a1,500*cut_t,channel*round*rest_L/(500*cut_t))';
for aa = 0:channel:size(rest1,1)-channel
    rest1_1(aa+1,:) = {rest1(aa+1:aa+30,:)};
end
rest1_1(cellfun(@isempty,rest1_1)) = [];

b = 0;
for j = 0:500*cut_t:task_L-500*cut_t
    b = b + 1;
    b_11(b,:) = reshape (task_11(:,j+1:j+500*cut_t)',1, numel(task_11(:,j+1:j+500*cut_t)'));
end
b11 = reshape (b_11',1, numel(b_11'));
task11 = reshape(b11,500*cut_t,channel*times*round*trial)';
for bb = 0:channel:size(task11,1)-channel
    task1_1(bb+1,:) = {task11(bb+1:bb+30,:)};
end
task1_1(cellfun(@isempty,task1_1)) = [];

c = 0;
for k = 0:500*cut_t:task_L-500*cut_t
    c = c + 1;
    c_13(c,:) = reshape (task_13(:,k+1:k+500*cut_t)',1, numel(task_13(:,k+1:k+500*cut_t)'));
end
c13 = reshape (c_13',1, numel(c_13'));
task13 = reshape(c13,500*cut_t,channel*times*round*trial)';
for cc = 0:channel:size(task13,1)-channel
    task1_3(cc+1,:) = {task13(cc+1:cc+30,:)};
end
task1_3(cellfun(@isempty,task1_3)) = [];

member1 = [rest1_1;task1_1;task1_3];


%% Member2

rest21 = struct2array(load('D:\USER\Desktop\0611_project\rest\rest21.mat'));
run211_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run211_data1.mat'));
run211_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run211_data2.mat'));
run211_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run211_data3.mat'));
run213_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run213_data1.mat'));
run213_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run213_data2.mat'));
run213_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run21\run213_data3.mat'));

rest22 = struct2array(load('D:\USER\Desktop\0611_project\rest\rest22.mat'));
run221_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run221_data1.mat'));
run221_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run221_data2.mat'));
run221_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run221_data3.mat'));
run223_data1 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run223_data1.mat'));
run223_data2 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run223_data2.mat'));
run223_data3 = struct2array(load('D:\USER\Desktop\0611_project\task\run22\run223_data3.mat'));

rest_2 = [rest21;rest22];
task_21 = [run211_data1;run211_data2;run211_data3;run221_data1;run221_data2;run221_data3];
task_23 = [run213_data1;run213_data2;run213_data3;run223_data1;run223_data2;run223_data3];

rest_L = length(rest_2);
task_L = length(task_21);

a = 0;
for i = 0:500*cut_t:rest_L-500*cut_t
    a = a + 1;
    a_2(a,:) = reshape (rest_2(:,i+1:i+500*cut_t)',1, numel(rest_2(:,i+1:i+500*cut_t)'));
end
a2 = reshape (a_2',1, numel(a_2'));
rest2 = reshape(a2,500*cut_t,channel*round*rest_L/(500*cut_t))';
for aa = 0:channel:size(rest2,1)-channel
    rest2_2(aa+1,:) = {rest2(aa+1:aa+30,:)};
end
rest2_2(cellfun(@isempty,rest2_2)) = [];

b = 0;
for j = 0:500*cut_t:task_L-500*cut_t
    b = b + 1;
    b_2(b,:) = reshape (task_21(:,j+1:j+500*cut_t)',1, numel(task_21(:,j+1:j+500*cut_t)'));
end
b2 = reshape (b_2',1, numel(b_2'));
task21 = reshape(b2,500*cut_t,channel*times*round*trial)';
for bb = 0:channel:size(task21,1)-channel
    task2_1(bb+1,:) = {task21(bb+1:bb+30,:)};
end
task2_1(cellfun(@isempty,task2_1)) = [];


c = 0;
for k = 0:500*cut_t:task_L-500*cut_t
    c = c + 1;
    c_2(c,:) = reshape (task_23(:,k+1:k+500*cut_t)',1, numel(task_23(:,k+1:k+500*cut_t)'));
end
c2 = reshape (c_2',1, numel(c_2'));
task23 = reshape(c2,500*cut_t,channel*times*round*trial)';
for cc = 0:channel:size(task23,1)-channel
    task2_3(cc+1,:) = {task23(cc+1:cc+30,:)};
end
task2_3(cellfun(@isempty,task2_3)) = [];

member2 = [rest2_2;task2_1;task2_3];

rest_level1_1 = [rest1_1;task1_1];
rest_level3_1 = [rest1_1;task1_3];
level1_level3_1 = [task1_1;task1_3];

rest_level1_2 = [rest2_2;task2_1];
rest_level3_2 = [rest2_2;task2_3];
level1_level3_2 = [task2_1;task2_3];

rest_level1_12 = [rest1_1;rest2_2;task1_1;task2_1];
rest_level3_12 = [rest1_1;rest2_2;task1_3;task2_3];
level1_level3_12 = [task1_1;task2_1;task1_3;task2_3];





