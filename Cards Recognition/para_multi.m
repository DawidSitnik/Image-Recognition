function para = para_multi(ts)
% Liczy parametry dla funkcji pdf_multi
% ts zbi�r ucz�cy (pr�bka = wiersz; w pierwszej kolumnie etykiety)
% para - struktura zawieraj�ca parametry:
%	para.labels - etykiety klas
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - macierze kowariancji cech (warstwa na klas�)

	labels = unique(ts(:,1));
	para.labels = labels;
	para.mu = zeros(rows(labels), columns(ts)-1);
	para.sig = zeros(columns(ts)-1, columns(ts)-1, rows(labels));

	% tu trzeba wypelnic wartosci srednie i odchylenie standardowe dla klas
	para.mu(1, :) = mean(ts(ts(:,1)==1, :))(2:3);
	para.mu(2, :) = mean(ts(ts(:,1)==2, :))(2:3);

	para.sig(:, :, 1) = cov(ts(ts(:,1)==1, :))(2:3, 2:3);
	para.sig(:, :, 2) = cov(ts(ts(:,1)==2, :))(2:3, 2:3);

	% tu trzeba wype�ni� warto�ci �rednie i macierze kowariancji dla klas
	% macierz kowariancji liczy funkcja cov

end
