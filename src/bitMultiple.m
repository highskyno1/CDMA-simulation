function res = bitMultiple(signal_1,signal_2)
%������λѭ����˺���,����źų��Ȳ�һ��,��϶̵��źű�ѭ��ʹ��
%ʾ��:bitMultiple([1 2],[2 3 4 5]) = [2 6 4 10]
%signal1:����ź�1
%signal2:����ź�2
%res:��˽��
    sizeSource = length(signal_1);
    sizePNCode = length(signal_2);
    %������Ȳ���������ʱ,����˳��ݹ����
    if sizeSource < sizePNCode
        res = bitMultiple(signal_2,signal_1);
        return;
    end
    res = zeros(1,sizeSource);
    for i = 1:sizeSource
        res(i) = signal_1(i) * signal_2(mod(i-1,sizePNCode)+1);
    end
end