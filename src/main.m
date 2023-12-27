%{
    ���������ڶ��û�CDMAͨ��ϵͳ����,ͬʱ�����˶Զྶ˥���ģ�⣬����Walsh����Ϊ��Ƶ��
�������ʹ��BPSK���ơ�
%}
% close all;
user_num = 8; %�û������������ڻ����walsh�����
user_code = 1e5;    %ÿ���û�����Ԫ��

walsh_order = 8;   %walsh�����,Ҳ����Ƶ����,������2���ݴη�

multipath_fading_num = 5;   %�ྶ˥��ͨ������

carrier_freq = 1e3; %�ز�Ƶ��
SampleRate = 25*1e3; %�ز�������
SamplePoint = 25; %�ز���������

frame_size = 8; %������һ֡�Ķ�����λ��

mix_frame_size = 8; %��֯����һ֡�Ķ�����λ��

%�����û���Ԫ
userCode = genBipolar(user_num,user_code);

%�����ྶ˥��ʱ����
mult_fading_code = multiPathCodeGen(multipath_fading_num);

%��֯����
foo = mixed(userCode,mix_frame_size,@mixed_encode);

%��ÿ���û��ֱ���к��������
foo = hamming(foo,frame_size);

%����Walsh����
walshCode = walsh(walsh_order);

%��Ƶ
foo = spreadSpectrum(foo,walshCode);

%��Ƶ�����Ԫ���
%!!���ն��յ����ǵ��ƺ���ӵĶ���źţ�Ϊ�˼����ڴ濪�����ȵ����ٵ��ƣ�
%ʵ��Ӧ���ȵ����ٵ��ӣ����ڷ��������ǵ�Ч��)
foo = overlay2(foo);

%�����ز�
carrier = carrierGen(carrier_freq,SampleRate,SamplePoint);
%����
foo = modulate(foo,carrier);

%���Բ�ͬ�������(dB)
snr_max = 30;
snr_min = -10;
snr_div = 1;
snr_array = floor((snr_max-snr_min)/snr_div);
%��¼ÿ���û�ÿ��������µ��û�������
user_errorRate = zeros(snr_array,user_num);
%��¼ƽ��������
mean_errorRate = zeros(1,snr_array);
parfor snr_index = 1:snr_array
    
    %��ǰ�����
    snr = snr_min + snr_div * snr_index;
    
    %����
    bar = awgn(foo,snr,powerCnt(carrier));
    
    %���ʱ��ЧӦ
    length_bar = length(bar);
    bar = conv(bar,mult_fading_code);
    bar = arrayCut(bar,length_bar);
    
    %���(��ɽ��)
    bar = demodulate(bar,carrier);
    
    %����
    bar = deSpreadSpectrum(bar,walshCode,user_num);
    
    %��Ԫ�о�
    bar = codeJudge(bar,walsh_order);
    
    %���������
    bar = unhamming(bar,frame_size);
    
    %�潻֯����
    bar = mixed(bar,mix_frame_size,@mixed_decode);
    
    %����������
    error_rate = 1 - compare(bar,userCode);
    
    %����������
    user_errorRate(snr_index,:) = error_rate;
    mean_errorRate(snr_index) = mean(error_rate);
    
    fprintf('��ǰ�����%f��ƽ��������%f\n',snr,mean(error_rate));
end

%��������������
foo_x = linspace(snr_min,snr_max,snr_array);
%���ɱ�ǩ
legend_plot = cell(1,user_num);
figure;
for i = 1:user_num
    semilogy(foo_x,user_errorRate(:,i));
    legend_plot{i} = ['�û�',num2str(i)];
    hold on;
end
title('�û�����������');
legend(legend_plot);
xlabel('�����(dB)');
ylabel('������');

%����ƽ������������
figure;
%����ƽ��������
semilogy(foo_x,mean_errorRate);
title('ƽ������������');
xlabel('�����(dB)');
ylabel('������');