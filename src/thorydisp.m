%{
    原理展示代码,以用户2为例
%}
close all;

user_num = 8; %用户数，必须少于或等于walsh码阶数
user_code = 1e4;    %每个用户的码元数

walsh_order = 8;   %walsh码阶数,也是扩频增益,必须是2的幂次方

carrier_freq = 1e3; %载波频率
SampleRate = 25*1e3; %载波采样率
SamplePoint = 25; %载波采样点数

%产生用户码元
userCode = genBipolar(user_num,user_code);

%产生Walsh矩阵
walshCode = walsh(walsh_order);

%扩频
res_spreadSpectrum = spreadSpectrum(userCode,walshCode);
%为了原理展示，进行码元拉长
disp_codeNum = 3;   %显示的码元数量
[~,user2_code] = selfCopy(userCode(2,:),walsh_order);
user2_spreadSpectrum = res_spreadSpectrum(2,:);
[ssCode,~] = selfCopy(walshCode(2,:),disp_codeNum);
%对比扩频前后时域
figure;
subplot(3,1,1)
stairs(user2_code(1:walsh_order*disp_codeNum));
set(gca,'YLim',[-2 2]); %Y轴的数据显示范围
title('扩频前')
subplot(3,1,2)
stairs(ssCode);
set(gca,'YLim',[-2 2]); %Y轴的数据显示范围
title('扩频码')
subplot(3,1,3)
stairs(user2_spreadSpectrum(1:walsh_order*disp_codeNum));
title('扩频后')
set(gca,'YLim',[-2 2]); %Y轴的数据显示范围

%生成载波
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);

%绘制扩频对比频谱图
%计算不扩频的调制结果
res_unSS = modulate(user2_code,carrier);
%计算扩频的调制结果
res_SS = modulate(user2_spreadSpectrum,carrier);
%频谱分析
fft_unSS = abs(fft(res_unSS));
fft_SS = abs(fft(res_SS));
fft_size = length(fft_unSS) / 2;
fft_x = linspace(0,1,fft_size);
figure;
plot(fft_x,fft_unSS(1:fft_size));
hold on
plot(fft_x,fft_SS(1:fft_size));
title('扩频前后频谱对比图');
legend('扩频前','扩频后');

%扩频后的码元相加
res_overlay = overlay(res_spreadSpectrum);

%生成载波
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);

%调制
send = modulate(res_overlay,carrier);
%对比调制前后的结果
user = [-1,0,1];
user_modu = modulate(user,carrier);
[~,user_show] = selfCopy(user,length(carrier));
[carrier_show,~] = selfCopy(carrier,length(user));
figure;
subplot(3,1,1);
stairs(user_show);
set(gca,'YLim',[-2 2]); %Y轴的数据显示范围
title('调制前')
subplot(3,1,2);
plot(carrier_show);
title('载波')
subplot(3,1,3);
plot(user_modu);
title('调制后')

%当前信噪比
snr = 20;

%加噪
receive = awgn(send,snr,powerCnt(carrier));

%解调(相干解调)
res_demodulate = demodulate(receive,carrier);

%解扩
res_deSpreadSpectrum = deSpreadSpectrum(res_demodulate,walshCode,user_num);

%码元判决
res_codeJudge = codeJudge(res_deSpreadSpectrum,walsh_order);

%计算误码率
error_rate = 1 - compare(res_codeJudge,userCode);
