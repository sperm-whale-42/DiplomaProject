%%
% ԭʼ�źŴ������غ�������
% ����������

% ���룺��X��N*4ά����,4ά�ź�����,ÿ�д���һ������������
%       ��sensor����������ţ�����
%       ��num���źŶ�Ӧ�ĳ�������1~25������
%       ��e�������������ַ���
%       ��p����i���ظ�ʵ�飬�ַ���
%       ��scale���������߶ȣ��������������,����

% �������Features ��������
%       ��FeaturesName ���������Ӧ��������

% ���ԣ�
% load('D:\My files\diploma project\��������������\�ظ���ʵ��1\����4.2J\signal_e42_d4_s4_1.mat');
% X = signal_e42_d4_s4_1_20;
% [ Features, FeaturesName] = processing(X,1,20,'e42',1,1);
% ����������30�Ļ���һ���ź�Ҫ34s

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com
%�ο���A new acoustic emission on-line monitoring method of laser shock peening
%%
function [ Features, FeaturesName] = processing(X,sensor,num,e,p,scale)

    % 1.���ݼ���
    x = X(:,sensor);
    
    % 2.�����ź�˥��Ӱ��
    x = AntiDecay(x,sensor,num);
    
    % 3.���ݲü�
    x = cut(x);
    
    % 3.1 ������ 2021/2/22���
    x = CoarseGraining(x,scale);

    % 4.ȥ�����Ʋ�����С����ȥ��
    x = xiaobobao(x);
    
    % 5.��ӻ�����
    Y = SlidingWindow(x,5000,250);
    T = size(Y,2); % ��������

    % 5.������ȡ
    % Features ��������T��40����
    % FeaturesName ���������Ӧ����������T��40Ԫ��
    
    % ��ʼ��һ��T��40����������
    Features = zeros(T,40);
    FeaturesName = cell(T,40);

    for iter = 1:T
        x_t = Y(:,iter);
        timestruct = timeDomainFeatures(x_t); % ��ȡʱ����������
        frequencystruct = frequencyDomainFeatures(x_t,3000000); % ��ȡƵ����������
        waveletstruct =  waveletFeatures(x_t); % ��ȡС������������
        % �����������ṹ��������������������
        f1 = fieldnames(timestruct);
        n1 = length(f1);
        for i = 1:n1
            Features(iter,i) = timestruct.(f1{i});
            FeaturesName{iter,i} = f1{i};
        end
        f2 = fieldnames(frequencystruct);
        n2 = length(f2);
        for j = 1:length(f2)
            Features(iter,j+n1) = frequencystruct.(f2{j});
            FeaturesName{iter,j+n1} = f2{j};
        end
        f3 = fieldnames(waveletstruct);
        n3 = length(f3);
        for k = 1:length(f3)
            Features(iter,k+n1+n2) = waveletstruct.(f3{k});
            FeaturesName{iter,k+n1+n2} = f3{k};
        end
    end

%     % ������������
%     fname = ['D:\My files\diploma project\data\Features_',e,'_',p,'_',num2str(num),'_',num2str(sensor),'.mat']
%     save(fname ,'Features');
%     % Features_e42(��������4.2J)_1(�ظ�ʵ����1)_1(��һ�������)_1(1�Ŵ�����)
end