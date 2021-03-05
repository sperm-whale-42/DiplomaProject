
%% 
% ����С����ͳ������
% wpcoef����С�����ֽ��ϵ����N��С�����ֽ���źŷֳ�2^N���Ӵ���û���Ӵ����źų�����ԭ���źŵ�1/2^N������ʵ���ǽ�ԭʼ�źŻ���2^N�Σ�ÿ�εĳ�������ȵ��ұ�ԭ�źŶ�
% wprcoef����С�����ֽ�ϵ���ع������ֽ�ĸ����Ӵ����ź���չΪԭʼ�ź���ô����
% ���ߵ��������wprcoef��wpcoef����չ��������ԭʼ�ź�һ����������ÿ���ڵ��������һ����
% 
% %С������һ��ͳ�ƣ�����һ�־�������㷨��
% ���°���С��ʱ���ء�С���߶���(С�������߶���)��С��ʱƵ�ء�С��������(С��������)
% С����س߶���(С����������߶���)��С�������ء�С���������ء�С���ռ�������(С���ռ������߶���)
% **********************************
% ���룺src,N*1ά����,һά�ź�����
% ����� waveletstruct С������������
%
%%
function [ waveletstruct ] =  waveletFeatures( src)

n=3;%3��С�����ֽ�
T=wpdec(src,n,'db6'); %3��С�����ֽ�   �õ�8���Ӵ�
for i=1:2^n   %%�ع�������ʹ�źź�ԭʼ�ź�һ����
       E(i)=norm(wprcoef(T,[n,i-1]),2)*norm(wprcoef(T,[n,i-1]),2); %���i���ڵ�Ķ�����������ƽ����������
end

E_total=sum(E);%������

%8���Ӵ���С��������
waveletstruct.p1=E(1)/E_total; 
waveletstruct.p2=E(2)/E_total; 
waveletstruct.p3=E(3)/E_total; 
waveletstruct.p4=E(4)/E_total; 
waveletstruct.p5=E(5)/E_total; 
waveletstruct.p6=E(6)/E_total; 
waveletstruct.p7=E(7)/E_total; 
waveletstruct.p8=E(8)/E_total; 


%��������ͼ
% p=[waveletstruct.p1,waveletstruct.p2,waveletstruct.p3,waveletstruct.p4,...
%     waveletstruct.p5,waveletstruct.p6,waveletstruct.p7,waveletstruct.p8];
% bar(p);
% set(gca,'XTickLabel',{'(3,0)','(3,1)','(3,2)','(3,3)' ,'(3,4)','(3,5)','(3,6)','(3,7)'});

%С��������(С��������)
waveletstruct.energyE=-sum(E/E_total.*log(E/E_total)); 


%8���Ӵ���С����(С���߶���)   �ڸ��߶��������shannon��=С���߶���(С�������߶���)
waveletstruct.E1=wentropy(wpcoef(T,[3,0]),'shannon');%
waveletstruct.E2=wentropy(wpcoef(T,[3,1]),'shannon');%
waveletstruct.E3=wentropy(wpcoef(T,[3,2]),'shannon');%
waveletstruct.E4=wentropy(wpcoef(T,[3,3]),'shannon');%
waveletstruct.E5=wentropy(wpcoef(T,[3,4]),'shannon');%
waveletstruct.E6=wentropy(wpcoef(T,[3,5]),'shannon');%
waveletstruct.E7=wentropy(wpcoef(T,[3,6]),'shannon');%
waveletstruct.E8=wentropy(wpcoef(T,[3,7]),'shannon');%


%С����������
%%����ȡ����ֵ��������ֵ�����������õ�����ֵ�ף�Ȼ�������ֵ����
%��һ����С���ֽ⣬�õ��������źţ���ϵ���ع����õ�����ϵ��
for i=1:2^n   %%�ع�������ʹ�źź�ԭʼ�ź�һ����
       q(:,i)=wprcoef(T,[n,i-1]); %��ϵ��
end

%����ֵ�ֽ�
s=svd(q);
S=sum(s);
dim=length(s);
for i=1:dim
    p(i)=s(i)/S;
end
waveletstruct.qyshang=-sum(p.*log(p));%С��������




end



