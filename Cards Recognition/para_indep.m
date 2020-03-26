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
	for i=1:rows(labels)
		para.mu(i, :) = mean(ts(ts(:,1)==i, :))(2:3);
	    para.sig(i, :) = std(ts(ts(:,1)==i, :))(2:3);
	end


end