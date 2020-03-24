function para = para_indep(ts)
% Liczy parametry dla funkcji pdf_indep
% ts zbior uczacy (probka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawierajaca parametry:
%	para.labels - etykiety klas
%	para.mu - wartosci srednie cech (wiersz na klase)
%	para.sig - odchylenia standardowe cech (wiersz na klase)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(rows(labels), columns(ts)-1);

	% tu trzeba wypelnic wartosci srednie i odchylenie standardowe dla klas
  para.mu(1, :) = mean(ts(ts(:,1)==1, :))(2:3)
  para.mu(2, :) = mean(ts(ts(:,1)==2, :))(2:3)
  
  para.sig(1, :) = std(ts(ts(:,1)==1, :))(2:3)
  para.sig(2, :) = std(ts(ts(:,1)==2, :))(2:3)

end