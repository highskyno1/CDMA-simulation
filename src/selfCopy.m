%������ʵ���������������
%input:��Ҫ���ص�����
%times-1:���صĴ���
%����selfCopy([1,2,3],2) = [[1,2,3,1,2,3,1,2,3],[1 1 2 2 3 3]]
function [res,res2] = selfCopy(input,times)
    if times <= 1
        res = input;
        res2 = res;
    else
        res = zeros(length(input),times);
        for i = 1:times
            res(:,i) = input;
        end
        res2 = res';
        res2 = res2(:)';
        res = res(:)';
    end
end