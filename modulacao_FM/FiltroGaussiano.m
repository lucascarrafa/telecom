function [H,HdB] = FiltroGaussiano(f,fFWHM,fc,m);
%
%    function [H,HdB] = FiltroGaussiano(f,fFWHM,fc,m);
%
%  Filtro Super-Gaussiano
%
%   Entrada:
%		f   -> Freqüência
%		f0  -> Largura do filtro
%		fc  -> Freqüência central do filtro
%		m   -> ordem da super-gaussiana
%   Saida:
%  		H   -> Função de transferência do filtro
%		HdB -> Função de transferência em dB
if nargin < 4,
  m = 1;
end
%
if fc == 0,
  fFWHM = 2.1*fFWHM;
end
f0 = inv(2*log(1 + sqrt(2)))*fFWHM;
H   = exp(-((f - fc)/f0).^(2*m));

% raz=max(H);
% H=H/raz;
%
warning off
HdB = 10*log10(H);
warning on
