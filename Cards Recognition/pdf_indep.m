function pdf = pdf_indep(pts, para)
% Liczy funkcj� g�sto�ci prawdopodobie�stwa przy za�o�eniu, �e cechy s� niezale�ne
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz, bez etykiety!)
% para - struktura zawieraj�ca parametry:
%	para.mu - warto�ci �rednie cech (wiersz na klas�)
%	para.sig - odchylenia standardowe cech (wiersz na klas�)
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	% znam rozmiar wyniku, wi�c go alokuj�
	pdf = zeros(rows(pts), rows(para.mu))

	% tu trzeba policzy� warto�� funkcji g�sto�ci
	% jako iloczyn g�sto�ci jednowymiarowych
	for n = 1:rows(pts)
		for i = 1:rows(para.mu)
			for j = 1:columns(para.mu)
				if pdf(n,i) == 0
					pdf(n,i) = normpdf(pts(n,j), para.mu(i,j), para.sig(i,j));
				else
					pdf(n,i) = pdf(n,i) * normpdf(pts(n,j), para.mu(i,j), para.sig(i,j));
				end
			end
		end
	end
end
