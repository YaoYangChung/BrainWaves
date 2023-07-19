tic
clc;clear;close all;
%% 
class_data = struct2cell(load('D:\USER\Desktop\0611_project\2class_data\rest_level1_1_40_60.mat'));
[ BP_data ] = BP_func( class_data );     % BP

%%
class1_L = 40;
class2_L = 60;
% [ KFD_data ] = KFD_func( class_data );   % KFD

data = BP_data;
channel = importdata('D:\USER\Desktop\0611_project\band\all band.txt');
[ FS_data,channel_txt ] = FS_func( data, channel, class1_L, class2_L );       % FS
                                  


%%
K = 3;
trn_data = FS_data;

for feature = 1:30
    [ CR_KNN(feature,:) ] = KNN_loo_func( K, trn_data, feature, class1_L, class2_L );       % KNN
    [ CR_LDA(feature,:) ] = LDA_loo_func(    trn_data, feature, class1_L, class2_L );       % LDA
end

% for y = 1:99
%     for feature = 1:y
%         [ CR_KNN(feature,y) ] = KNN_loo_func( K, trn_data(:,:,y), feature, class1_L, class2_L );       % KNN
%         [ CR_LDA(feature,:) ] = LDA_loo_func(    trn_data, feature, class1_L, class2_L );       % LDA
%     end
% end

for C = 1
    for feature = 1:30
        [ CR_SVM( C ,feature) ] = SVM_loo_func( C, trn_data, feature, class1_L, class2_L );       % SVM
    end
end

for C = 5:5:100
    for feature = 1:30
        [ CR_SVM( C/5+1 ,feature) ] = SVM_loo_func( C, trn_data, feature, class1_L, class2_L );       % SVM
    end
end

toc