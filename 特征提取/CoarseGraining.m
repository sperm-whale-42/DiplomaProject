%%
% 对信号进行粗粒化
% 输入：①x,时序信号
%       ②scale，粗粒化尺度
% 输出：①y，粗粒化的输出
% y(i)=mean{x(i),x(i+1),x(i+2),?,x(i+scale?1)}

%作者：许志翔（西安交通大学 车辆71）
%联系方式：mr_xuzhixiang@qq.com
%%
function [y] = CoarseGraining(x,scale)
        if scale == 1
            y = x;
        elseif scale == 2
            Y = SlidingWindow(x,scale,1);
            N = size(Y,2);
            for i = 1:N
                y(i,:) = mean(Y(:,i));
            end
            y(i+1,:) = y(i,:); % 末位补全，保持信号长度不变
%             k = 0;
%             N = floor(length(x)/scale);
%             for i = 1:N
%                 for j = 1+(i-1)*scale:i*scale
%                      %Y(i,mod(j,scale)+1) = x(j);
%                      k=k+x(j);
%                 end
%                 %y(i) = mean(Y(i,:));
%                 y(i,:) = k/scale;
%                 k = 0;
%              end
        end
end
