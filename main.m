%%
% �ź�˵����
% signal_e42(��������4.2J)_d4(���ֱ��4mm)_s1(��һ�γ��)_1(�ظ�ʵ����1)_1(��һ�������)(:,1(1�Ŵ�����));
% ��cmd�����롾D:\My files\diploma project\��������������>tree /f >tree.txt������ļ���tree.txt(���е�main.mat�ļ�����)
% ��������һ�Σ��޶�߶ȣ���Ҫ5253s
%
%%
clear all;

% 1.��������
datadir = dir('D:\My files\diploma project\��������������\��һ�γ��\*.mat');
dirlength = length(datadir);
for i = 1:dirlength
      % �������е�һ�γ������
      %eval(['X',num2str(i),' = load(''D:\My files\diploma project\��������������\��һ�γ��\',datadir(i).name,''');']);
      eval(['load(''D:\My files\diploma project\��������������\��һ�γ��\',datadir(i).name,''');']);
end

datalist = who; %��ȡ��ǰ�����ռ������б�������353��1��cell����
datalist(1:3) = []; %ɾ��ǰ3����������datadir��dirlength��i��
listlength = length(datalist);
% ע����who *s ���Ի��������s��ͷ�ı����������ǲ�֪��Ϊɶ���ܸ�ֵ
for i = 1:listlength
    cell_str = strsplit(datalist{i},'_');
    % �и�ɣ�'signal' 'e30' 'd3' 's1' '1' 'j'
    % cell_str{2}������  cell_str{6}����������
    
    e{i,:} = cell_str{2}; % ��ȡ�źŶ�Ӧ�ļ���������ǩ
    p{i,:} = cell_str{5}; % ��ȡ�ظ�ʵ����
    num{i,:} = str2num(cell_str{6}); % ��ȡ��������
end

Datastruct=struct('name',datalist,'e',e,'p',p,'num',num);

n = 0;
for i =  1:length(Datastruct)  
    for j = 1:4 % ����1-4��������
        for k = 1:2 % ͨ������������������������
            %features = processing(X,sensor,num,e,p,scale)
            ins = ['features = processing(',datalist{i},',',num2str(j),',',num2str(num{i}),',''',e{i},''',''',p{i},''',',num2str(k),');']
            %ins = ['features = processing(',datalist{i},',',num2str(j),',',num2str(num{i}),',''',e{i},''',''',p{i},'''',')']
            eval(ins);
            n = n+1
            Features(:,:,n) = features; % �ź�����
            targets(n,:) = Encoding(e{i}); % �źű�ǩ
            sensor(n,:) = j; % ���������
            number(n,:) = num{i}; % ��������
            rg(n,:) = str2num(p{i});% �ظ�ʵ����
            name{n,:} = Datastruct(i).name; % �ź���
            scale(n,:) = k; % �������߶�
            
        end
    end
end

fname = ['D:\My files\diploma project\data\data.mat'];
save(fname ,'Features','targets','sensor','number','rg','name','scale');

