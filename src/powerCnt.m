%���������źŵ�ƽ������(dBW)
function res = powerCnt(input)
    res = 10*log10(sum(input.*input));
end