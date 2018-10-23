function [ vetor_freq] = GeraVetorFreq( fs,sig_len )
    if mod(sig_len,2)==0
        delta_f     = fs/sig_len;
        fpos        = 0 : delta_f : ((sig_len/2)-1)*delta_f;
        fneg        = -(sig_len/2)*delta_f : delta_f : -delta_f;
        vetor_freq  = [fneg fpos];
    else
       delta_f      = fs/sig_len;
        fpos        = 0 : delta_f : ceil(((sig_len/2))*delta_f);
        fneg        = -(sig_len/2)*delta_f : delta_f : -delta_f;
        vetor_freq  = [fneg fpos]; 
    end
end

