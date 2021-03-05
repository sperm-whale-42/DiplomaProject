%%
% 给信号加个滑动窗
% 输入：①x,时序信号
%       ②width,窗口大小
%       ③step,滑动窗每次移动的距离

% 输出：①y，多时序信号，按列储存

% 示例：
% >>a = 1:20;
% >>c = SlidingWindow(a,5,3)
% 
% c =
%      1     4     7    10    13
%      2     5     8    11    14
%      3     6     9    12    15
%      4     7    10    13    16
%      5     8    11    14    17

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com

%%
function [y] = SlidingWindow(x,width,step)
ind = 1:width;
iter =1;
while max(ind) <= length(x)
    y(:,iter) = x(ind);
    ind = ind + step;
    iter = iter+1;
end
% 获取窗口数
T = size(y,2);% 函数外
T = iter - 1; % 函数内
end
