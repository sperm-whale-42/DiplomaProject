%%
% ���źżӸ�������
% ���룺��x,ʱ���ź�
%       ��width,���ڴ�С
%       ��step,������ÿ���ƶ��ľ���

% �������y����ʱ���źţ����д���

% ʾ����
% >>a = 1:20;
% >>c = SlidingWindow(a,5,3)
% 
% c =
%      1     4     7    10    13
%      2     5     8    11    14
%      3     6     9    12    15
%      4     7    10    13    16
%      5     8    11    14    17

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com

%%
function [y] = SlidingWindow(x,width,step)
ind = 1:width;
iter =1;
while max(ind) <= length(x)
    y(:,iter) = x(ind);
    ind = ind + step;
    iter = iter+1;
end
% ��ȡ������
T = size(y,2);% ������
T = iter - 1; % ������
end