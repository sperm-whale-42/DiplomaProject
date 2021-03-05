%% 
% ����ʱ��ͳ������
% ���룺src,N*1ά����,һά�ź�����
% �����timestruct ʱ��ͳ������
%
% �ο���https://blog.csdn.net/qq_37240982/article/details/107425077
% ע���У����ǰ��*��ʾ���Լ��󲹵Ĳ�������*1.��λ��
%
%%
function [ timestruct ] = timeDomainFeatures( src)

    if nargin>2
    error(message('��������ֻ��ֻ����һ����2���������'));
    end

    %////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    timestruct.max=max(src);%1.���ֵ
    timestruct.min=min(src);%2.��Сֵ
    timestruct.median = median(src); % *1.��λ��
    timestruct.peak=max(abs(src)); %3.��ֵ
    timestruct.p2p=max(src)-min(src);%4.���ֵ
    timestruct.mean=mean(src);%5.��ֵ
    timestruct.averageAmplitude=mean(abs(src));%6.����ƽ��ֵ��ƽ����ֵ��
    timestruct.rootAmplitude=mean(sqrt(abs(src)))^2;%7.������ֵ
    timestruct.var=var(src,1);%8.����  ��ƫ
    timestruct.std=std(src,1);%9.��׼��
    timestruct.rms=sqrt(sum(src.^2)/length(src));%10.��Чֵ����������
    timestruct.kurtosis=kurtosis(src,1);%11.�Ͷ�
    timestruct.skewness=skewness(src,1);%12.ƫ��
    timestruct.shapeFactor=timestruct.rms/timestruct.averageAmplitude;%13.��������
    timestruct.peakingFactor=timestruct.peak/timestruct.rms;%14.��ֵ���ӣ��������ӣ�
    timestruct.pulseFactor=timestruct.peak/timestruct.averageAmplitude;%15.��������
    timestruct.marginFactor=timestruct.peak/timestruct.rootAmplitude;%16.ԣ������
    timestruct.clearanceFactor=timestruct.peak/timestruct.rms^2;%17.��϶����


    %//////////////////////////////////////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    % if nargin==2
    %      switch(option)
    %          case 'max'
    %              disp('max value=');
    %              disp(timestruct.max);
    %          case 'min'
    %              disp('min value=');
    %              disp(timestruct.min);           
    %      end 
    % end 
end
