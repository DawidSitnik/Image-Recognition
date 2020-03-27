function pdf = pdf_parzen(pts, para)

	pdf = zeros(rows(pts), rows(para.samples));

    %iterating through points
    for n = 1:rows(pts)

        %iterating through classes
        for u=1:rows(para.labels)

            %defining space for calculation for one class
            pdfs{u} = zeros(rows(para.samples(u,1){1,1}), columns(para.samples(u,1){1,1})+1);

            %iterating through columns in one class
            for i=1:columns(para.samples(u,1){1,1})

                %iterating through rows in one class
                for j=1:rows(para.samples(u,1){1,1})

                    %callculating pdf for one attribute of one sample, where mu equals to the sample and std is window width
                    pdfs{u}(j,i) = normpdf(pts(n,i), para.samples(u,1){1,1}(j,i), para.parzenw);
                    
                end
            end

            %for each class get the product of the attributes
            pdfs{u}(:, columns(para.samples(u,1){1,1})+1) = transpose(prod(transpose(pdfs{u}(:,1:size(pdfs{u})(2)-1))));

            %get the mean of the products
            pdf(n,u) = mean(pdfs{u}(:,columns(para.samples(u,1){1,1})+1));
        end
    end





end
