function cropped_image = crop_image(image, x, y, width, height)
    % Получаем размеры изображения
    [image_height, image_width, ~] = size(image);
    
    % индексация массивов начинается с 1 поэтому, а координаты с 0, поэтому
    % прибавляем 1
    x = x + 1;
    y = y + 1;
    
    % Проверяем, что область обрезки находится в пределах изображения
    if x < 0 || y < 0 || x + width - 1 > image_width || y + height - 1 > image_height
        error('Выход за границы изображения');
    end
    
    % Вырезаем прямоугольную область изображения
    cropped_image = image(y:y+height-1, x:x+width-1, :);
end
