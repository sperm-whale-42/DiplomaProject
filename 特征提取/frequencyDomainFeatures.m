%% 
% 计算频域统计特征
% 输入：①src,N*1维矩阵,一维信号数据
%       ②fs，信号频率 
% 输出： frequencystruct 频域统计特征
%
%%

function [ frequencystruct ] = frequencyDomainFeatures( src,fs)
%计算频域统计特征
%***********************对信号进行FFT变换*******************************
FS=fs;
N=length(src);n=0:N-1;
freq=n*fs/N; 
f=abs(fft(src,N)*2/N); 

x=f(1:N/2);  %纵坐标    频率幅值
freq=freq(1:N/2)';  %横坐标    频率值

% plot(freq,x);
% title('原始信号频域波形');
% xlabel('频率/hz');
% ylabel('幅值/v');

%********************************计算频域特征值*****************************
frequencystruct.MF=mean(x); %平均频率
frequencystruct.FC=sum(freq.*x)/sum(x);%重心频率
frequencystruct.RMSF=sqrt(sum([freq.^2].*x)/sum(x));%频率均方根
frequencystruct.RVF=sqrt(sum([(freq-frequencystruct.FC).^2].*x)/sum(x));%频率标准差
end






