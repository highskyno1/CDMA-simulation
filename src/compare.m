function accuracy = compare(input1,input2)
%比较两个数组
%input1:矩阵1，每一行为一个用户所有码元
%input2:矩阵2
%accuracy:正确率数组
[row,~] = size(input1);
accuracy = zeros(row,1);
for i = 1:row
    temp = (input1(i,:) == input2(i,:));
    res = length(find(temp == 1));
    sizeInput = max(length(input1),length(input2));
    accuracy(i) = res/double(sizeInput);
end
end