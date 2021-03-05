%%
% ���룺x_input,ԭʼ�ź�
% �����
% ��final_x 
%   С�����ع���Ĺؼ�ģ̬�ź�(Ĭ�ϱ���7��8�ڵ�)
% ��coeff 
%   С�����ֽ�󣨵ײ�ڵ��źš��ؼ�ģ̬�źţ���ԭʼ�źŵ�Ƥ��ѷ���ϵ��
%   [7�Žڵ� 8�Žڵ� ����14�Žڵ� �ؼ�ģ̬�ź�]
% �۸���figure
%     figure(6) �ؼ�ģ̬�źŵ�ʱ����
%     figure(11)�ؼ�ģ̬�źŵ�Ƶ��ͼ
%     figure(7) ����Ƶ��������ռ�ı���

% ͼ�����Ĭ�Ϲرգ���Ҫͼ��������Ӧע��
% ������ͼ���ں����⻭����

%�������Դ���
% load('D:\My files\diploma project\��������������\�ظ���ʵ��1\����4.2J\signal_e42_d4_s4_1.mat');
% x_input = signal_e42_d4_s4_1_20(:,1);
% [a1 a2] = xiaobobao(x_input);

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com
%�ο���https://blog.csdn.net/cqfdcw/article/details/84995904
%%

function [ final_x , coeff ] = xiaobobao(x_input)

    %% ��������
%     load('D:\My files\diploma project\��������������\�ظ���ʵ��1\����4.2J\signal_e42_d4_s4_1.mat');
%     x_input = signal_e42_d4_s4_1_20(:,1);
%     x = sgolayfilt(x_input,6,501); %ȥ����,���ֵ����̫���ˡ�
      x = x_input;

    %% �鿴Ƶ�׷�Χ/����Ƶ��ͼ
    fs = 3000000;
    N = length(x); %���������

    %figure(1);plot(x);title('�����ź�ʱ��ͼ��') %���������ź�ʱ��ͼ��

    signalFFT = abs(fft(x,N)); %��ʵ�ķ�ֵ
    Y = 2*signalFFT/N;
    f = (0:N/2)*(fs/N);
    %figure(2);plot(f,Y(1:N/2+1)); %���fftƵ��ͼ -signal_1(:,1)��Ƶ��
    % ylabel('amp'); xlabel('frequency');title('�����źŵ�Ƶ��');grid on 

    %% С�����ֽ�
    wpt = wpdec(x,3,'dmey'); %����dmeyС������4��С�����ֽ�
    %figure(3);plot(wpt); %����С������

    %% ʵ�ֶԽڵ�˳����Ƶ�ʵ�������������
    nodes = [7;8;9;10;11;12;13;14]; %��3��Ľڵ��
    ord = wpfrqord(nodes);  %С����ϵ�����ţ�ord�����ź�С����ϵ���������ɵľ�����3��ֽ��[1;2;4;3;7;8;6;5]
    nodes_ord = nodes(ord); %���ź��С��ϵ��

    %% ���Ƶ�3������ڵ�ֱ��ع����źŵ�Ƶ��
    for i=1:8
    rex3(:,i)=wprcoef(wpt,nodes_ord(i)); %ʵ�ֶԽڵ�С���ڵ�����ع�        
    end

    %figure(4);                         
    for i=0:7
    % subplot(2,4,i+1);
    x_sign= rex3(:,i+1); 
    N=length(x_sign); %���������
    signalFFT=abs(fft(x_sign,N));%��ʵ�ķ�ֵ
    Y=2*signalFFT/N;
    f=(0:N/2)*(fs/N);
    %plot(f,Y(1:N/2+1));
    %ylabel('amp'); xlabel('frequency');grid on
    %axis([0 1500000 0 0.05]); title(['С������3��',num2str(i),'�ڵ��ź�Ƶ��']);
    end

    %% ��ȡС�����ֽ�ĸ���Ƶ�ε�С����ϵ��
    cfs3_0=wpcoef(wpt,nodes_ord(1));  %����������3��0�ڵ��С����ϵ�� 000000-187500Hz
    cfs3_1=wpcoef(wpt,nodes_ord(2));  %����������3��0�ڵ��С����ϵ�� 187500-375000Hz
    cfs3_2=wpcoef(wpt,nodes_ord(3));  %����������3��0�ڵ��С����ϵ�� 375000-562500Hz
    cfs3_3=wpcoef(wpt,nodes_ord(4));  %����������3��0�ڵ��С����ϵ�� 562500-750000Hz
    cfs3_4=wpcoef(wpt,nodes_ord(5));  %����������3��0�ڵ��С����ϵ�� 750000-937500Hz
    cfs3_5=wpcoef(wpt,nodes_ord(6));  %����������3��0�ڵ��С����ϵ�� 937500-1125000Hz
    cfs3_6=wpcoef(wpt,nodes_ord(7));  %����������3��0�ڵ��С����ϵ�� 1125000-1312500Hz
    cfs3_7=wpcoef(wpt,nodes_ord(8));  %����������3��0�ڵ��С����ϵ�� 1312500-1500000Hz

    %% �����Ƶ���ź���ԭʼ�źż��Ƥ��ѷ���ϵ��

    coeff = zeros(1,9);
    %��¼8���ڵ��ź���ԭʼ�źŵ�Ƥ��ѷ���ϵ��,��9�������������źŵ����ϵ��

    sNod = read(wpt,'sizes',nodes); %��ȡ������ڵ��size

    for i=1:8

    % ��������7���ڵ��зǹؼ�ģ̬ȫ������
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
    13,cfs_list_new{7},'cfs',14,cfs_list_new{8}); %�ź�����

    new_x_3{i} = wprec(new_wpt); % ������ź�ֵ

    coeff(i) = corr(new_x_3{i} , x); %�������i�ڵ��ź���ԭʼ�źŵ�Ƥ��ѷ���ϵ��
    end

    %% ����С������new_wpt/����ǹؼ��ڵ�

    % ��������7���ڵ��зǹؼ�ģ̬ȫ������
    new_cfs3_0  = zeros(sNod(1,:));
    new_cfs3_1  = zeros(sNod(2,:));
    new_cfs3_2  = zeros(sNod(3,:));
    new_cfs3_3  = zeros(sNod(4,:));
    new_cfs3_4  = zeros(sNod(5,:));
    new_cfs3_5  = zeros(sNod(6,:));
    new_cfs3_6  = zeros(sNod(7,:));
    new_cfs3_7  = zeros(sNod(8,:));

    % С����ϵ���б�
    cfs_list_new = {new_cfs3_0,new_cfs3_1,new_cfs3_2,new_cfs3_3,new_cfs3_4,new_cfs3_5,new_cfs3_6,new_cfs3_7};
    cfs_list_old = {cfs3_0,cfs3_1,cfs3_2,cfs3_3,cfs3_4,cfs3_5,cfs3_6,cfs3_7};

    % ѡ��������1�͵�2�ڵ��ź���Ϊ�ؼ�ģ̬�����ڵ�7��8��
    cfs_list_new{1} = cfs_list_old{1};
    cfs_list_new{2} = cfs_list_old{2};

    final_wpt = write(wpt,'cfs',7,cfs_list_new{1},'cfs',8,cfs_list_new{2},...
    'cfs',9,cfs_list_new{3},'cfs',10,cfs_list_new{4},'cfs',...
    11,cfs_list_new{5},'cfs',12,cfs_list_new{6},'cfs',...
    13,cfs_list_new{7},'cfs',14,cfs_list_new{8}); %�ź�����

    %figure(5);plot (final_wpt);%������С������

    final_x = wprec(final_wpt); % �ؼ�ģ̬�ź�ֵ
    coeff(9) = corr(final_x , x); %�ؼ�ģ̬�ź���ԭʼ�źŵ�Ƥ��ѷ���ϵ��

    %figure(6);plot(final_x);title('�ؼ�ģ̬�ź�ʱ��ͼ��'); %����ģ̬�ź�ʱ����
    %figure(8);wpviewcf(final_wpt,1);        %����ʱ��Ƶ��ͼ

    % figure(11);%�ؼ��źŵ�Ƶ��ͼ
    signalFFT_new = abs(fft(final_x,N)); %��ʵ�ķ�ֵ
    Y_new = 2*signalFFT_new/N;
    f_new = (0:N/2)*(fs/N);
    % plot(f_new,Y_new(1:N/2+1)); %���fftƵ��ͼ -signal_1(:,1)��Ƶ��
    % ylabel('amp'); xlabel('frequency');title('�ؼ��źŵ�Ƶ��');grid on 


    %% ��ȡС�����ֽ�ĸ���Ƶ�ε�����
    E_cfs3_0=norm(cfs3_0,2)^2;  %% 1-����������norm(...,1)������Ԫ�ؾ���ֵ֮�ͣ�2-����������norm(...,2)������Ԫ��ƽ���Ϳ����ţ�
    E_cfs3_1=norm(cfs3_1,2)^2;
    E_cfs3_2=norm(cfs3_2,2)^2;
    E_cfs3_3=norm(cfs3_3,2)^2;
    E_cfs3_4=norm(cfs3_4,2)^2;
    E_cfs3_5=norm(cfs3_5,2)^2;
    E_cfs3_6=norm(cfs3_6,2)^2;
    E_cfs3_7=norm(cfs3_7,2)^2;
    E_total=E_cfs3_0+E_cfs3_1+E_cfs3_2+E_cfs3_3+E_cfs3_4+E_cfs3_5+E_cfs3_6+E_cfs3_7;

    p_node(1)= 100*E_cfs3_0/E_total;           % ���ÿ���ڵ��ռ��
    p_node(2)= 100*E_cfs3_1/E_total;           % ���ÿ���ڵ��ռ��
    p_node(3)= 100*E_cfs3_2/E_total;           % ���ÿ���ڵ��ռ��
    p_node(4)= 100*E_cfs3_3/E_total;           % ���ÿ���ڵ��ռ��
    p_node(5)= 100*E_cfs3_4/E_total;           % ���ÿ���ڵ��ռ��
    p_node(6)= 100*E_cfs3_5/E_total;           % ���ÿ���ڵ��ռ��
    p_node(7)= 100*E_cfs3_6/E_total;           % ���ÿ���ڵ��ռ��
    p_node(8)= 100*E_cfs3_7/E_total;           % ���ÿ���ڵ��ռ��

    % figure(7);
    % i=1:8;
    % bar(i,p_node);
    % title('����Ƶ��������ռ�ı���');
    % xlabel('Ƶ��');
    % ylabel('�����ٷֱ�/%');
    % for j=1:8
    % text(i(j),p_node(j),num2str(p_node(j),'%0.2f'),...
    %     'HorizontalAlignment','center',...
    %     'VerticalAlignment','bottom')
    % end

    % E = wenergy(wpt);       %��ȡ�����ڵ�����

    %% �����ع�ǰ��������Ƶ��С����ϵ����ͼ��
    % figure(9);
    % subplot(3,1,1);
    % plot(x);title('ԭʼ�ź�');
    % subplot(3,1,2);
    % plot(cfs3_0);
    % title(['���� ',num2str(3) '  �ڵ� 0��С��000000-187500Hz',' ϵ��'])
    % subplot(3,1,3);
    % plot(cfs3_1);
    % title(['���� ',num2str(3) '  �ڵ� 1��С��187500-375000Hz',' ϵ��'])


    %% �����ع���ʱ���������Ƶ�ε�ͼ��
    % figure(10);
    % subplot(2,1,1);
    % plot(rex3(:,1));
    % title('�ع���000000-187500HzƵ���ź�');
    % subplot(2,1,2);
    % plot(rex3(:,2));
    % title('�ع���187500-375000HzƵ���ź�')

end
