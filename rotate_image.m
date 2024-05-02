function imagerot = rotate_image(image, degree )
    switch mod(degree, 360)
    % Частные случаи
    case 0
        imagerot = image;
    case 90
        imagerot = rot90(image);
    case 180
         imagerot = rot90(image, 2);
    case 270
        imagerot = rot90(image, 3);
    otherwise

        % Конвертируем градусы в радианы и создаем матрицу поворота
        a = degree*pi/180;
        R = [+cos(a) +sin(a); -sin(a) +cos(a)];

        % Вычисляем размеры нового изображения
        [m,n,p] = size(image);
        dest = round( [1 1; 1 n; m 1; m n]*R );
        dest = bsxfun(@minus, dest, min(dest)) + 1;
        imagerot = zeros([max(dest) p],class(image));

        % Сравниваем пиксели преобразованного изображения с исходным изображением
        for ii = 1:size(imagerot,1)
            for jj = 1:size(imagerot,2)
                source = ([ii jj]-dest(1,:))*R.';
                if all(source >= 1) && all(source <= [m n])

                    % Получаем 4 окружающих пикселя
                    C = ceil(source);
                    F = floor(source);

                    % Вычисляем новую область для изображения
                    A = [...
                        ((C(2)-source(2))*(C(1)-source(1))),...
                        ((source(2)-F(2))*(source(1)-F(1)));
                        ((C(2)-source(2))*(source(1)-F(1))),...
                        ((source(2)-F(2))*(C(1)-source(1)))];

                    % Извлекаем цвета и меняем их масштаб относительно площади
                    cols = bsxfun(@times, A, double(image(F(1):C(1),F(2):C(2),:)));

                    % Присваиваем значения                     
                    imagerot(ii,jj,:) = sum(sum(cols),2);

                end
            end
        end        
    end
end