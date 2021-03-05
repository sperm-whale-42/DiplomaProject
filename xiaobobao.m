%%
% 输入：x_input,原始信号
% 输出：
% ①final_x 
%   小波包重构后的关键模态信号(默认保留7，8节点)
% ②coeff 
%   小波包分解后（底层节点信号、关键模态信号）与原始信号的皮尔逊相关系数
%   [7号节点 8号节点 ……14号节点 关键模态信号]
% ③各种figure
%     figure(6) 关键模态信号的时域波形
%     figure(11)关键模态信号的频谱图
%     figure(7) 各个频段能量所占的比例

% 图形输出默认关闭，需要图形请解除相应注释
% 另，建议图像在函数外画……

%函数测试代码
% load('D:\My files\diploma project\变能量参数数据\重复组实验1\能量4.2J\signal_e42_d4_s4_1.mat');
% x_input = signal_e42_d4_s4_1_20(:,1);
% [a1 a2] = xiaobobao(x_input);

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com
%参考：https://blog.csdn.net/cqfdcw/article/details/84995904
%%

function [ final_x , coeff ] = xiaobobao(x_input)

    %% 加载数据
%     load('D:\My files\diploma project\变能量参数数据\重复组实验1\能量4.2J\signal_e42_d4_s4_1.mat');
%     x_input = signal_e42_d4_s4_1_20(:,1);
%     x = sgolayfilt(x_input,6,501); %去波动,这个值好像太狠了。
      x = x_input;

    %% 查看频谱范围/绘制频谱图
    fs = 3000000;
    N = length(x); %采样点个数

    %figure(1);plot(x);title('输入信号时域图像') %绘制输入信号时域图像

    signalFFT = abs(fft(x,N)); %真实的幅值
    Y = 2*signalFFT/N;
    f = (0:N/2)*(fs/N);
    %figure(2);plot(f,Y(1:N/2+1)); %输出fft频谱图 -signal_1(:,1)的频谱
    % ylabel('amp'); xlabel('frequency');title('输入信号的频谱');grid on 

    %% 小波包分解
    wpt = wpdec(x,3,'dmey'); %采用dmey小波进行4层小波包分解
    %figure(3);plot(wpt); %绘制小波包树

    %% 实现对节点顺序按照频率递增进行重排序
    nodes = [7;8;9;10;11;12;13;14]; %第3层的节点号
    ord = wpfrqord(nodes);  %小波包系数重排，ord是重排后小波包系数索引构成的矩阵　如3层分解的[1;2;4;3;7;8;6;5]
    nodes_ord = nodes(ord); %重排后的小波系数

    %% 绘制第3层各个节点分别重构后信号的频谱
    for i=1:8
    rex3(:,i)=wprcoef(wpt,nodes_ord(i)); %实现对节点小波节点进行重构        
    end

    %figure(4);                         
    for i=0:7
    % subplot(2,4,i+1);
    x_sign= rex3(:,i+1); 
    N=length(x_sign); %采样点个数
    signalFFT=abs(fft(x_sign,N));%真实的幅值
    Y=2*signalFFT/N;
    f=(0:N/2)*(fs/N);
    %plot(f,Y(1:N/2+1));
    %ylabel('amp'); xlabel('frequency');grid on
    %axis([0 1500000 0 0.05]); title(['小波包第3层',num2str(i),'节点信号频谱']);
    end

    %% 求取小波包分解的各个频段的小波包系数
    cfs3_0=wpcoef(wpt,nodes_ord(1));  %对重排序后第3层0节点的小波包系数 000000-187500Hz
    cfs3_1=wpcoef(wpt,nodes_ord(2));  %对重排序后第3层0节点的小波包系数 187500-375000Hz
    cfs3_2=wpcoef(wpt,nodes_ord(3));  %对重排序后第3层0节点的小波包系数 375000-562500Hz
    cfs3_3=wpcoef(wpt,nodes_ord(4));  %对重排序后第3层0节点的小波包系数 562500-750000Hz
    cfs3_4=wpcoef(wpt,nodes_ord(5));  %对重排序后第3层0节点的小波包系数 750000-937500Hz
    cfs3_5=wpcoef(wpt,nodes_ord(6));  %对重排序后第3层0节点的小波包系数 937500-1125000Hz
    cfs3_6=wpcoef(wpt,nodes_ord(7));  %对重排序后第3层0节点的小波包系数 1125000-1312500Hz
    cfs3_7=wpcoef(wpt,nodes_ord(8));  %对重排序后第3层0节点的小波包系数 1312500-1500000Hz

    %% 计算各频段信号与原始信号间的皮尔逊相关系数

    coeff = zeros(1,9);
    %记录8个节点信号与原始信号的皮尔逊相关系数,第9个是最后输出的信号的相关系数

    sNod = read(wpt,'sizes',nodes); %读取第三层节点的size

    for i=1:8

    % 将第三层7个节点中非关键模态全部置零
    new_cfs3_0  = zeros(sNod(1,:));
    new_cfs3_1  = zeros(sNod(2,:));
    new_cfs3_2  = zeros(sNod(3,:));
    new_cfs3_3  = zeros(sNod(4,:));
    new_cfs3_4  = zeros(sNod(5,:));
    new_cfs3_5  = zeros(sNod(6,:));
    new_cfs3_6  = zeros(sNod(7,:));
    new_cfs3_7  = zeros(sNod(8,:));
    cfs_list_new = {new_cfs3_0,new_cfs3_1,new_cfs3_2,new_cfs3_3,new_cfs3_4,new_cfs3_5,new_cfs3_6,new_cfs3_7};
    cfs_list_old = {cfs3_0,cfs3_1,cfs3_2,cfs3_3,cfs3_4,cfs3_5,cfs3_6,cfs3_7};

    cfs_list_new{i} = cfs_list_old{i};

    new_wpt = write(wpt,'cfs',7,cfs_list_new{1},'cfs',8,cfs_list_new{2},...
    'cfs',9,cfs_list_new{3},'cfs',10,cfs_list_new{4},'cfs',...
    11,cfs_list_new{5},'cfs',12,cfs_list_new{6},'cfs',...
    13,cfs_list_new{7},'cfs',14,cfs_list_new{8}); %信号重组

    new_x_3{i} = wprec(new_wpt); % 重组的信号值

    coeff(i) = corr(new_x_3{i} , x); %第三层第i节点信号与原始信号的皮尔逊相关系数
    end

    %% 重组小波包树new_wpt/置零非关键节点

    % 将第三层7个节点中非关键模态全部置零
    new_cfs3_0  = zeros(sNod(1,:));
    new_cfs3_1  = zeros(sNod(2,:));
    new_cfs3_2  = zeros(sNod(3,:));
    new_cfs3_3  = zeros(sNod(4,:));
    new_cfs3_4  = zeros(sNod(5,:));
    new_cfs3_5  = zeros(sNod(6,:));
    new_cfs3_6  = zeros(sNod(7,:));
    new_cfs3_7  = zeros(sNod(8,:));

    % 小波包系数列表
    cfs_list_new = {new_cfs3_0,new_cfs3_1,new_cfs3_2,new_cfs3_3,new_cfs3_4,new_cfs3_5,new_cfs3_6,new_cfs3_7};
    cfs_list_old = {cfs3_0,cfs3_1,cfs3_2,cfs3_3,cfs3_4,cfs3_5,cfs3_6,cfs3_7};

    % 选择第三层第1和第2节点信号作为关键模态（即节点7、8）
    cfs_list_new{1} = cfs_list_old{1};
    cfs_list_new{2} = cfs_list_old{2};

    final_wpt = write(wpt,'cfs',7,cfs_list_new{1},'cfs',8,cfs_list_new{2},...
    'cfs',9,cfs_list_new{3},'cfs',10,cfs_list_new{4},'cfs',...
    11,cfs_list_new{5},'cfs',12,cfs_list_new{6},'cfs',...
    13,cfs_list_new{7},'cfs',14,cfs_list_new{8}); %信号重组

    %figure(5);plot (final_wpt);%重组后的小波包树

    final_x = wprec(final_wpt); % 关键模态信号值
    coeff(9) = corr(final_x , x); %关键模态信号与原始信号的皮尔逊相关系数

    %figure(6);plot(final_x);title('关键模态信号时域图像'); %绘制模态信号时域波形
    %figure(8);wpviewcf(final_wpt,1);        %画出时间频率图

    % figure(11);%关键信号的频谱图
    signalFFT_new = abs(fft(final_x,N)); %真实的幅值
    Y_new = 2*signalFFT_new/N;
    f_new = (0:N/2)*(fs/N);
    % plot(f_new,Y_new(1:N/2+1)); %输出fft频谱图 -signal_1(:,1)的频谱
    % ylabel('amp'); xlabel('frequency');title('关键信号的频谱');grid on 


    %% 求取小波包分解的各个频段的能量
    E_cfs3_0=norm(cfs3_0,2)^2;  %% 1-范数：就是norm(...,1)，即各元素绝对值之和；2-范数：就是norm(...,2)，即各元素平方和开根号；
    E_cfs3_1=norm(cfs3_1,2)^2;
    E_cfs3_2=norm(cfs3_2,2)^2;
    E_cfs3_3=norm(cfs3_3,2)^2;
    E_cfs3_4=norm(cfs3_4,2)^2;
    E_cfs3_5=norm(cfs3_5,2)^2;
    E_cfs3_6=norm(cfs3_6,2)^2;
    E_cfs3_7=norm(cfs3_7,2)^2;
    E_total=E_cfs3_0+E_cfs3_1+E_cfs3_2+E_cfs3_3+E_cfs3_4+E_cfs3_5+E_cfs3_6+E_cfs3_7;

    p_node(1)= 100*E_cfs3_0/E_total;           % 求得每个节点的占比
    p_node(2)= 100*E_cfs3_1/E_total;           % 求得每个节点的占比
    p_node(3)= 100*E_cfs3_2/E_total;           % 求得每个节点的占比
    p_node(4)= 100*E_cfs3_3/E_total;           % 求得每个节点的占比
    p_node(5)= 100*E_cfs3_4/E_total;           % 求得每个节点的占比
    p_node(6)= 100*E_cfs3_5/E_total;           % 求得每个节点的占比
    p_node(7)= 100*E_cfs3_6/E_total;           % 求得每个节点的占比
    p_node(8)= 100*E_cfs3_7/E_total;           % 求得每个节点的占比

    % figure(7);
    % i=1:8;
    % bar(i,p_node);
    % title('各个频段能量所占的比例');
    % xlabel('频段');
    % ylabel('能量百分比/%');
    % for j=1:8
    % text(i(j),p_node(j),num2str(p_node(j),'%0.2f'),...
    %     'HorizontalAlignment','center',...
    %     'VerticalAlignment','bottom')
    % end

    % E = wenergy(wpt);       %求取各个节点能量

    %% 绘制重构前各个特征频段小波包系数的图形
    % figure(9);
    % subplot(3,1,1);
    % plot(x);title('原始信号');
    % subplot(3,1,2);
    % plot(cfs3_0);
    % title(['层数 ',num2str(3) '  节点 0的小波000000-187500Hz',' 系数'])
    % subplot(3,1,3);
    % plot(cfs3_1);
    % title(['层数 ',num2str(3) '  节点 1的小波187500-375000Hz',' 系数'])


    %% 绘制重构后时域各个特征频段的图形
    % figure(10);
    % subplot(2,1,1);
    % plot(rex3(:,1));
    % title('重构后000000-187500Hz频段信号');
    % subplot(2,1,2);
    % plot(rex3(:,2));
    % title('重构后187500-375000Hz频段信号')

end
