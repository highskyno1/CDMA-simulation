function [res] = carrierGen(freq,sampleRate,size)
%carrierGen 产出载波
%   参数：freq:频率 sampleRate:采样率 size:载波长度
    n=0:size-1;
    t=n/sampleRate;%时间序列
    res=sin(2*pi*freq*t);
end

