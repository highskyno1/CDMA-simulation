userCode = [1,0,-1];

carrier_freq = 1e3; %载波频率
SampleRate = 25*1e3; %载波采样率
SamplePoint = 25; %载波采样点数

%生成载波
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);
%调制
send = modulate(userCode,carrier);

plot(send)

%加扰
receive = awgn(send,0,powerCnt(carrier));

%解调(相干解调)
res_demodulate = demodulate(receive,carrier);

disp(compare(res_demodulate,userCode));