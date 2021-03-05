%%
% 原始信号处理的相关函数整合
% 便于批处理

% 输入：①X，N*4维矩阵,4维信号数据,每列代表一个传感器数据
%       ②sensor，传感器编号，数字
%       ③num，信号对应的冲击点序号1~25，数字
%       ④e，激光能量，字符串
%       ⑤p，第i次重复实验，字符串
%       ⑥scale，粗粒化尺度，用于添加样本量,数字

% 输出：①Features 特征矩阵
%       ②FeaturesName 特征矩阵对应的特征名

% 测试：
% load('D:\My files\diploma project\变能量参数数据\重复组实验1\能量4.2J\signal_e42_d4_s4_1.mat');
% X = signal_e42_d4_s4_1_20;
% [ Features, FeaturesName] = processing(X,1,20,'e42',1,1);
% 滑动窗步长30的话跑一个信号要34s

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com
%参考：A new acoustic emission on-line monitoring method of laser shock peening
%%
function [ Features, FeaturesName] = processing(X,sensor,num,e,p,scale)

    % 1.数据加载
    x = X(:,sensor);
    
    % 2.消除信号衰减影响
    x = AntiDecay(x,sensor,num);
    
    % 3.数据裁剪
    x = cut(x);
    
    % 3.1 粗粒化 2021/2/22添加
    x = CoarseGraining(x,scale);

    % 4.去除趋势波动与小波包去躁
    x = xiaobobao(x);
    
    % 5.添加滑动窗
    Y = SlidingWindow(x,5000,250);
    T = size(Y,2); % 窗口总数

    % 5.特征提取
    % Features 特征矩阵，T×40数组
    % FeaturesName 特征矩阵对应的特征名，T×40元组
    
    % 初始化一个T×40的特征矩阵
    Features = zeros(T,40);
    FeaturesName = cell(T,40);

    for iter = 1:T
        x_t = Y(:,iter);
        timestruct = timeDomainFeatures(x_t); % 提取时域特征参数
        frequencystruct = frequencyDomainFeatures(x_t,3000000); % 提取频域特征参数
        waveletstruct =  waveletFeatures(x_t); % 提取小波域特征参数
        % 将两个特征结构体数据输入特征矩阵中
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

%     % 保存特征矩阵
%     fname = ['D:\My files\diploma project\data\Features_',e,'_',p,'_',num2str(num),'_',num2str(sensor),'.mat']
%     save(fname ,'Features');
%     % Features_e42(激光能量4.2J)_1(重复实验组1)_1(第一个冲击点)_1(1号传感器)
end
