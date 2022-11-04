function res = arrayCut(array,size)
%arrayCut 根据需要的长度，居中截取数组
%   因为在FIR滤波之后，结果会增长，对于解调来说，
%   滤波卷积结果两端的部分是多余的，应该去除。
    start = floor((length(array)-size)/2+1);
    res = array(start:start+size-1);
end

