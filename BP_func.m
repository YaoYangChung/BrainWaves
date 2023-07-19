function [ BP_data ] = BP_func( class_data )
num = size(class_data{1, 1}{1, 1},2);
time = num/500;
for n = 1:size(class_data{1,1},1)
    B = class_data{1, 1}{n, 1};
    func = fft(B,num,2);
    PSD = (abs(func)).^2;
    delta(:,n) = sum(PSD(:,time*1+1:time*4),2);
    theta(:,n) = sum(PSD(:,time*4+1:time*8),2);
    alpha(:,n) = sum(PSD(:,time*8+1:time*13),2);
    beta(:,n) = sum(PSD(:,time*13+1:time*30),2);
    BP_data(n,:) = [delta(:,n)',theta(:,n)',alpha(:,n)',beta(:,n)'];
end

end

