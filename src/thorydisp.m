%{
    ԭ��չʾ����,���û�2Ϊ��
%}
close all;

user_num = 8; %�û������������ڻ����walsh�����
user_code = 1e4;    %ÿ���û�����Ԫ��

walsh_order = 8;   %walsh�����,Ҳ����Ƶ����,������2���ݴη�

carrier_freq = 1e3; %�ز�Ƶ��
SampleRate = 25*1e3; %�ز�������
SamplePoint = 25; %�ز���������

%�����û���Ԫ
userCode = genBipolar(user_num,user_code);

%����Walsh����
walshCode = walsh(walsh_order);

%��Ƶ
res_spreadSpectrum = spreadSpectrum(userCode,walshCode);
%Ϊ��ԭ��չʾ��������Ԫ����
disp_codeNum = 3;   %��ʾ����Ԫ����
[~,user2_code] = selfCopy(userCode(2,:),walsh_order);
user2_spreadSpectrum = res_spreadSpectrum(2,:);
[ssCode,~] = selfCopy(walshCode(2,:),disp_codeNum);
%�Ա���Ƶǰ��ʱ��
figure;
subplot(3,1,1)
stairs(user2_code(1:walsh_order*disp_codeNum));
set(gca,'YLim',[-2 2]); %Y���������ʾ��Χ
title('��Ƶǰ')
subplot(3,1,2)
stairs(ssCode);
set(gca,'YLim',[-2 2]); %Y���������ʾ��Χ
title('��Ƶ��')
subplot(3,1,3)
stairs(user2_spreadSpectrum(1:walsh_order*disp_codeNum));
title('��Ƶ��')
set(gca,'YLim',[-2 2]); %Y���������ʾ��Χ

%������Ƶ�Ա�Ƶ��ͼ
%���㲻��Ƶ�ĵ��ƽ��
res_unSS = modulate(user2_code,carrier);
%������Ƶ�ĵ��ƽ��
res_SS = modulate(user2_spreadSpectrum,carrier);
%Ƶ�׷���
fft_unSS = abs(fft(res_unSS));
fft_SS = abs(fft(res_SS));
fft_size = length(fft_unSS) / 2;
fft_x = linspace(0,1,fft_size);
figure;
plot(fft_x,fft_unSS(1:fft_size));
hold on
plot(fft_x,fft_SS(1:fft_size));
title('��Ƶǰ��Ƶ�׶Ա�ͼ');
legend('��Ƶǰ','��Ƶ��');

%��Ƶ�����Ԫ���
res_overlay = overlay(res_spreadSpectrum);

%�����ز�
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);

%����
send = modulate(res_overlay,carrier);
%�Աȵ���ǰ��Ľ��
user = [-1,0,1];
user_modu = modulate(user,carrier);
[~,user_show] = selfCopy(user,length(carrier));
[carrier_show,~] = selfCopy(carrier,length(user));
figure;
subplot(3,1,1);
stairs(user_show);
set(gca,'YLim',[-2 2]); %Y���������ʾ��Χ
title('����ǰ')
subplot(3,1,2);
plot(carrier_show);
title('�ز�')
subplot(3,1,3);
plot(user_modu);
title('���ƺ�')

%��ǰ�����
snr = 20;

%����
receive = awgn(send,snr,powerCnt(carrier));

%���(��ɽ��)
res_demodulate = demodulate(receive,carrier);

%����
res_deSpreadSpectrum = deSpreadSpectrum(res_demodulate,walshCode,user_num);

%��Ԫ�о�
res_codeJudge = codeJudge(res_deSpreadSpectrum,walsh_order);

%����������
error_rate = 1 - compare(res_codeJudge,userCode);