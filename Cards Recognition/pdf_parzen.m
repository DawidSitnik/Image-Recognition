function pdf = pdf_parzen(pts, para)
% Aproksymuje warto�� g�sto�ci prawdopodobie�stwa z wykorzystaniem okna Parzena
% pts zawiera punkty, dla kt�rych liczy si� f-cj� g�sto�ci (punkt = wiersz)
% para - struktura zawieraj�ca parametry:
%	para.samples - tablica kom�rek zawieraj�ca pr�bki z poszczeg�lnych klas
%	para.parzenw - szeroko�� okna Parzena
% pdf - macierz g�sto�ci prawdopodobie�stwa
%	liczba wierszy = liczba pr�bek w pts
%	liczba kolumn = liczba klas

	pdf = zeros(rows(pts), rows(para.samples));

	% tu trzeba policzy� warto�� funkcji g�sto�ci
	% jako iloczyn g�sto�ci jednowymiarowych



	for n = 1:rows(pts)
		for i = 1:rows(para.labels)
			%inicjalizujemy zakres okna parezna dla kazdego atrybutu
			for u = 1:columns(para.samples(i,1){1,1})
				para_min(u) = para.samples(i,1){1,1}(1,u)
				para_max(u) = para_min(u) + para.parzenw
			end
			min_v = para_min(1)
			smaller_attribute = 1
			size(para_min)
			for u = 1:size(para_min)
				if para_min(i) < para_min
					min_v = para_min(i)
					smaller_attribute = i
				end
			end
			min_v = min(para_min)
			para_max = min(para_max)
			%przechodzimy przez klasy oknem Parzena
			for u = 1:ceil(size(para.samples(i,1){1,1})(1))
				for x = 1:columns(para.samples(i,1){1,1})
					elements{x} = para.samples(i,1){1,1}(:,x)(para.samples(i,1){1,1}(:,smaller_attribute) >= min_v & para.samples(i,1){1,1}(:,smaller_attribute) < para_max)
				end
				x=0
				%dla kazdego wiersza z okna liczymy pdf (x)
				for p = 1:rows(elements(1,1){1,1})
					for j = 1:size(elements)(2)
						if j == 1
							elements(1,j){1,1}(p)
							x = normpdf(elements(1,j){1,1}(p), elements(1,j){1,1}(p), para.parzenw);
						else
							elements(1,j){1,1}(p)
							x = x * normpdf(elements(1,j){1,1}(p),elements(1,j){1,1}(p), para.parzenw);
						end
						end
						%dodajemy obliczone pdf do sumy za dane okno
						pdf(n,i) = pdf(n,i) + x
					end
					min_v=min_v+para.parzenw
					para_max=para_max+para.parzenw
			end
			%liczymy srednia
			pdf(n,i) = pdf(n,i) / size(para.samples(i,1){1,1})(1)
		end
	end
	% przy liczeniu g�sto�ci warto zastanowi� si�
	% nad kolejno�ci� oblicze� (p�tli)
end
