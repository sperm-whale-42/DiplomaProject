%%
% ���źŽ��б���

% ���룺��e�������������ַ���
% �������target��������Ӧ�ı�ţ�����

% e30-0,e34-1,e38-2,e40-3,e42-4,e46-5,e50-6

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com
%%
function [ target] = Encoding(e)

        if e == 'e30'
            target = 0;
        elseif e == 'e34'
            target = 1;
        elseif e == 'e38'
            target = 2;
        elseif e == 'e40'
            target = 3;
        elseif e == 'e42'
            target = 4;
        elseif e == 'e46'
            target = 5;
        elseif e == 'e50'
            target = 6;
        else 
            error(message('��������'));
        end
end