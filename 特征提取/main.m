%%
% 信号说明：
% signal_e42(激光能量4.2J)_d4(光斑直径4mm)_s1(第一次冲击)_1(重复实验组1)_1(第一个冲击点)(:,1(1号传感器));
% 在cmd中输入【D:\My files\diploma project\变能量参数数据>tree /f >tree.txt】获得文件树tree.txt(剪切到main.mat文件夹下)
% 经测试跑一次（无多尺度）需要5253s
%
%%
clear all;

% 1.加载数据
datadir = dir('D:\My files\diploma project\变能量参数数据\第一次冲击\*.mat');
dirlength = length(datadir);
for i = 1:dirlength
      % 加载所有第一次冲击数据
      %eval(['X',num2str(i),' = load(''D:\My files\diploma project\变能量参数数据\第一次冲击\',datadir(i).name,''');']);
      eval(['load(''D:\My files\diploma project\变能量参数数据\第一次冲击\',datadir(i).name,''');']);
end

datalist = who; %获取当前向量空间中所有变量名，353×1的cell数组
datalist(1:3) = []; %删除前3个变量名（datadir、dirlength、i）
listlength = length(datalist);
% 注：用who *s 可以获得所有以s开头的变量名，但是不知道为啥不能赋值
for i = 1:listlength
    cell_str = strsplit(datalist{i},'_');
    % 切割成：'signal' 'e30' 'd3' 's1' '1' 'j'
    % cell_str{2}→能量  cell_str{6}→冲击点序号
    
    e{i,:} = cell_str{2}; % 获取信号对应的激光能量标签
    p{i,:} = cell_str{5}; % 获取重复实验组
    num{i,:} = str2num(cell_str{6}); % 获取冲击点序号
end

Datastruct=struct('name',datalist,'e',e,'p',p,'num',num);

n = 0;
for i =  1:length(Datastruct)  
    for j = 1:4 % 代表1-4个传感器
        for k = 1:2 % 通过粗粒化将样本扩大至二倍
            %features = processing(X,sensor,num,e,p,scale)
            ins = ['features = processing(',datalist{i},',',num2str(j),',',num2str(num{i}),',''',e{i},''',''',p{i},''',',num2str(k),');']
            %ins = ['features = processing(',datalist{i},',',num2str(j),',',num2str(num{i}),',''',e{i},''',''',p{i},'''',')']
            eval(ins);
            n = n+1
            Features(:,:,n) = features; % 信号特征
            targets(n,:) = Encoding(e{i}); % 信号标签
            sensor(n,:) = j; % 传感器序号
            number(n,:) = num{i}; % 冲击点序号
            rg(n,:) = str2num(p{i});% 重复实验组
            name{n,:} = Datastruct(i).name; % 信号名
            scale(n,:) = k; % 粗粒化尺度
            
        end
    end
end

fname = ['D:\My files\diploma project\data\data.mat'];
save(fname ,'Features','targets','sensor','number','rg','name','scale');

