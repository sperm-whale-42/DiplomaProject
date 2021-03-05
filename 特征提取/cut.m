 %%
% 数据裁剪
% 截取范围：信号出现第一个波谷起至之后的15000个采样点，对应半个采样周期

% 输入：①x，N*1维矩阵,1维信号数据
% 输出：①new_x，裁剪后的信号数据

%参考：秦锐师兄
%%
function [ new_x ] = cut(x)       

    [max_val, max_loc] = findpeaks(x,'minpeakheight',3);  % 波峰
    [min_val, min_loc] = findpeaks(10-x, 'minpeakheight',13);  % 波谷
    j = min_loc(1,:);
    new_x = x(j:j+15000-1);
    
end
