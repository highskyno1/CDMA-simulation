userCode = [1,0,-1];

carrier_freq = 1e3; %�ز�Ƶ��
SampleRate = 25*1e3; %�ز�������
SamplePoint = 25; %�ز���������

%�����ز�
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);
%����
send = modulate(userCode,carrier);

plot(send)

%����
receive = awgn(send,0,powerCnt(carrier));

%���(��ɽ��)
res_demodulate = demodulate(receive,carrier);

disp(compare(res_demodulate,userCode));