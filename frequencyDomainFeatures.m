%% 
% ����Ƶ��ͳ������
% ���룺��src,N*1ά����,һά�ź�����
%       ��fs���ź�Ƶ�� 
% ����� frequencystruct Ƶ��ͳ������
%
%%

function [ frequencystruct ] = frequencyDomainFeatures( src,fs)
%����Ƶ��ͳ������
%***********************���źŽ���FFT�任*******************************
FS=fs;
N=length(src);n=0:N-1;
freq=n*fs/N; 
f=abs(fft(src,N)*2/N); 

x=f(1:N/2);  %������    Ƶ�ʷ�ֵ
freq=freq(1:N/2)';  %������    Ƶ��ֵ

% plot(freq,x);
% title('ԭʼ�ź�Ƶ����');
% xlabel('Ƶ��/hz');
% ylabel('��ֵ/v');

%********************************����Ƶ������ֵ*****************************
frequencystruct.MF=mean(x); %ƽ��Ƶ��
frequencystruct.FC=sum(freq.*x)/sum(x);%����Ƶ��
frequencystruct.RMSF=sqrt(sum([freq.^2].*x)/sum(x));%Ƶ�ʾ�����
frequencystruct.RVF=sqrt(sum([(freq-frequencystruct.FC).^2].*x)/sum(x));%Ƶ�ʱ�׼��
end






