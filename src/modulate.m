function res = modulate(source,carrier)
%���ƺ���
%source:�������ź�
%carrier:�ز��ź�
    sizeSource = length(source);
    sizeCarrier = length(carrier);
    res = zeros(sizeSource,sizeCarrier);
    for i = 1:sizeSource
        res(i,:) = double(source(i))*carrier;
    end
    %��res����ƴ�ӳ�һ��
    res = res';
    res = res(:);
end