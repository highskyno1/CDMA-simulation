%{
    本程序用于多用户CDMA通信系统仿真,同时引入了对多径衰落的模拟，采用Walsh码作为扩频码
传输过程使用BPSK调制。
%}
% close all;
user_num = 8; %用户数，必须少于或等于walsh码阶数
user_code = 1e5;    %每个用户的码元数

walsh_order = 8;   %walsh码阶数,也是扩频增益,必须是2的幂次方

multipath_fading_num = 5;   %多径衰落通道数量

carrier_freq = 1e3; %载波频率
SampleRate = 25*1e3; %载波采样率
SamplePoint = 25; %载波采样点数

frame_size = 8; %汉明码一帧的二进制位数

mix_frame_size = 8; %交织编码一帧的二进制位数

%产生用户码元
userCode = genBipolar(user_num,user_code);

%产生多径衰落时滞码
mult_fading_code = multiPathCodeGen(multipath_fading_num);

%交织编码
foo = mixed(userCode,mix_frame_size,@mixed_encode);

%对每个用户分别进行汉明码编码
foo = hamming(foo,frame_size);

%产生Walsh矩阵
walshCode = walsh(walsh_order);

%扩频
foo = spreadSpectrum(foo,walshCode);

%扩频后的码元相加
%!!接收端收到的是调制后叠加的多个信号，为了减少内存开销，先叠加再调制，
%实际应该先调制再叠加，但在仿真中这是等效的)
foo = overlay2(foo);

%生成载波
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);
%调制
foo = modulate(foo,carrier);

%尝试不同的信噪比(dB)
snr_max = 30;
snr_min = -10;
snr_div = 1;
snr_array = floor((snr_max-snr_min)/snr_div);
%记录每个用户每个信噪比下的用户误码率
user_errorRate = zeros(snr_array,user_num);
%记录平均误码率
mean_errorRate = zeros(1,snr_array);
parfor snr_index = 1:snr_array
    
    %当前信噪比
    snr = snr_min + snr_div * snr_index;
    
    %加噪
    bar = awgn(foo,snr,powerCnt(carrier));
    
    %添加时滞效应
    length_bar = length(bar);
    bar = conv(bar,mult_fading_code);
    bar = arrayCut(bar,length_bar);
    
    %解调(相干解调)
    bar = demodulate(bar,carrier);
    
    %解扩
    bar = deSpreadSpectrum(bar,walshCode,user_num);
    
    %码元判决
    bar = codeJudge(bar,walsh_order);
    
    %汉明码解码
    bar = unhamming(bar,frame_size);
    
    %逆交织编码
    bar = mixed(bar,mix_frame_size,@mixed_decode);
    
    %计算误码率
    error_rate = 1 - compare(bar,userCode);
    
    %保存误码率
    user_errorRate(snr_index,:) = error_rate;
    mean_errorRate(snr_index) = mean(error_rate);
    
    fprintf('当前信噪比%f，平均误码率%f\n',snr,mean(error_rate));
end

%绘制误码率曲线
foo_x = linspace(snr_min,snr_max,snr_array);
%生成标签
legend_plot = cell(1,user_num);
figure;
for i = 1:user_num
    semilogy(foo_x,user_errorRate(:,i));
    legend_plot{i} = ['用户',num2str(i)];
    hold on;
end
title('用户误码率曲线');
legend(legend_plot);
xlabel('信噪比(dB)');
ylabel('误码率');

%绘制平均误码率曲线
figure;
%计算平均误码率
semilogy(foo_x,mean_errorRate);
title('平均误码率曲线');
xlabel('信噪比(dB)');
ylabel('误码率');