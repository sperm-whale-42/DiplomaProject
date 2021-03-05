%%
% �����ɾ���������ź�˥�������ݵ�Ӱ��
% Ex = E0��e^(-kx)

% ���룺��x��N*1ά����,1ά�ź�����
%       ��sensor�����������
%       ��num���źŶ�Ӧ�ĳ�������1~25

% �������new_x��������˥��ЧӦ���ź�����

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com
%�ο���A new acoustic emission on-line monitoring method of laser shock peening
%%
function [ new_x ] = AntiDecay(x,sensor,num)

    k = 0.01242; % ����˥��ϵ��
    
    % ���崫������1~25�������ľ���
    [sensor1]=xlsread('D:\My files\diploma project\������봫��������.xlsx','F1:F25');
    [sensor2]=xlsread('D:\My files\diploma project\������봫��������.xlsx','D1:D25');
    [sensor3]=xlsread('D:\My files\diploma project\������봫��������.xlsx','C1:C25');
    [sensor4]=xlsread('D:\My files\diploma project\������봫��������.xlsx','E1:E25');
    
        if sensor == 1
            new_x = x*sqrt(exp(k*sensor1(num)));
        elseif sensor == 2
            new_x = x*sqrt(exp(k*sensor2(num)));
        elseif sensor == 3
            new_x = x*sqrt(exp(k*sensor3(num)));
        elseif sensor == 4
            new_x = x*sqrt(exp(k*sensor4(num)));
        else 
            error(message('�������󣬴��������Ϊ1��4'));
        end
        
end
