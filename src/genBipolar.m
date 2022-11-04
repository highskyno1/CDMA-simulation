function res = genBipolar(num_user,num_code)
% 产生双极性码
% num_code:双极性码的规模
% num_user:用户数
% res:[用户1双极性码;用户二双极性码。。。;]
    res = rand(num_user,num_code);
    res = value2Bipolar(res);
end