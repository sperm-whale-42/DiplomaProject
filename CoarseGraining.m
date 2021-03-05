%%
% ���źŽ��д�����
% ���룺��x,ʱ���ź�
%       ��scale���������߶�
% �������y�������������
% y(i)=mean{x(i),x(i+1),x(i+2),?,x(i+scale?1)}

%���ߣ���־�裨������ͨ��ѧ ����71��
%��ϵ��ʽ��mr_xuzhixiang@qq.com
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
            y(i+1,:) = y(i,:); % ĩλ��ȫ�������źų��Ȳ���
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