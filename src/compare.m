function accuracy = compare(input1,input2)
%�Ƚ���������
%input1:����1��ÿһ��Ϊһ���û�������Ԫ
%input2:����2
%accuracy:��ȷ������
[row,~] = size(input1);
accuracy = zeros(row,1);
for i = 1:row
    temp = (input1(i,:) == input2(i,:));
    res = length(find(temp == 1));
    sizeInput = max(length(input1),length(input2));
    accuracy(i) = res/double(sizeInput);
end
end