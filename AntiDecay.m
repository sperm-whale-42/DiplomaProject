%%
% 消除由距离带来的信号衰减对数据的影响
% Ex = E0·e^(-kx)

% 输入：①x，N*1维矩阵,1维信号数据
%       ②sensor，传感器编号
%       ③num，信号对应的冲击点序号1~25

% 输出：①new_x，消除了衰减效应的信号数据

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com
%参考：A new acoustic emission on-line monitoring method of laser shock peening
%%
function [ new_x ] = AntiDecay(x,sensor,num)

    k = 0.01242; % 定义衰减系数
    
    % 定义传感器与1~25个冲击点的距离
    [sensor1]=xlsread('D:\My files\diploma project\冲击点与传感器距离.xlsx','F1:F25');
    [sensor2]=xlsread('D:\My files\diploma project\冲击点与传感器距离.xlsx','D1:D25');
    [sensor3]=xlsread('D:\My files\diploma project\冲击点与传感器距离.xlsx','C1:C25');
    [sensor4]=xlsread('D:\My files\diploma project\冲击点与传感器距离.xlsx','E1:E25');
    
        if sensor == 1
            new_x = x*sqrt(exp(k*sensor1(num)));
        elseif sensor == 2
            new_x = x*sqrt(exp(k*sensor2(num)));
        elseif sensor == 3
            new_x = x*sqrt(exp(k*sensor3(num)));
        elseif sensor == 4
            new_x = x*sqrt(exp(k*sensor4(num)));
        else 
            error(message('参数有误，传感器编号为1到4'));
        end
        
end
