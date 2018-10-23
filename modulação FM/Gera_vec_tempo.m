function tempo=Gera_vec_tempo( fs,len )
%fs denota a frequencia de amostragem do sinal
%   Detailed explanation goes here
ts=1/fs;
tempo=0:ts:(len-1)*ts;
end

