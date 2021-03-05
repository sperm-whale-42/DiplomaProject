%%
% 对信号进行编码

% 输入：①e，激光能量，字符串
% 输出：①target，能量对应的编号，数字

% e30-0,e34-1,e38-2,e40-3,e42-4,e46-5,e50-6

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com
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
            error(message('参数有误'));
        end
end