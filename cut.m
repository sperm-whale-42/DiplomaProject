 %%
% ���ݲü�
% ��ȡ��Χ���źų��ֵ�һ����������֮���15000�������㣬��Ӧ�����������

% ���룺��x��N*1ά����,1ά�ź�����
% �������new_x���ü�����ź�����

%�ο�������ʦ��
%%
function [ new_x ] = cut(x)       

    [max_val, max_loc] = findpeaks(x,'minpeakheight',3);  % ����
    [min_val, min_loc] = findpeaks(10-x, 'minpeakheight',13);  % ����
    j = min_loc(1,:);
    new_x = x(j:j+15000-1);
    
end