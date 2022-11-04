%{
    本程序用于多用户CDMA通信系统仿真,同时引入了对多径衰落的模拟，采用Walsh码作为扩频码
传输过程使用BPSK调制,加入了对不同载波振幅的测试
%}
close all
user_num = 8; %用户数，必须少于或等于walsh码阶数
user_code = 1e4;    %每个用户的码元数

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
foo = overlay2(foo);

%尝试不同的信噪比(dB)
snr_max = 30;
snr_min = -10;
snr_div = 1;
snr_array = floor((snr_max-snr_min)/snr_div);

%尝试不同的振幅
amp_len = 10;
amp_min = 0.1;
amp_max = 5;
car_amp_list = linspace(amp_min,amp_max,amp_len);

amp_rec = zeros(amp_len,snr_array);

parfor car_ind = 1:10
    %生成载波
    car_amp = car_amp_list(car_ind);
    carrier = car_amp .* carrierGen(carrier_freq,SampleRate,SamplePoint);
    %调制
    par_foo = modulate(foo,carrier);
    for snr_index = 1:snr_array

        %当前信噪比
        snr = snr_min + snr_div * snr_index;

        %加噪
        bar = awgn(par_foo,snr,powerCnt(carrier));

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
        amp_rec(car_ind,snr_index) = mean(error_rate);

    end
    fprintf('当前载波%f\r\n',car_amp);
end
%绘制误码率曲线
foo_x = linspace(snr_min,snr_max,snr_array);

%绘制平均误码率曲线
figure(2);
hold on
%计算平均误码率
for i = 1:amp_len
    plot(foo_x,amp_rec(i,:));
end
title('平均误码率曲线');
xlabel('信噪比(dB)');
ylabel('误码率');