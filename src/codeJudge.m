function res = codeJudge(input,spreadSpectrumGain)
%codeJudge ��Ԫ�о������ڷ�������о�ԭ��
%input ����������û��ľ���ÿһ��Ϊһ���û�
%spreadSpectrumGain ��Ƶ����
[row,col] = size(input);
res = int8(ones(row,floor(col/spreadSpectrumGain)));
%����ÿһ���û�
for i = 1:row
   %�����о�
   res_group = arrayGroupSum(input(i,:),spreadSpectrumGain);
   for j = 1:length(res_group)
       if res_group(j) < 0
           res(i,j) = -1;
       end
   end
end
end