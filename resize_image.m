function resized_image = resize_image(image, scale)
    % Получаем размеры исходного изображения
    [rows, cols, ~] = size(image);

    % Определяем новые размеры изображения после изменения масштаба
    new_rows = round(rows * scale);
    new_cols = round(cols * scale);

    % Вычисляем индексы пикселей в новом масштабе
    [X, Y] = meshgrid(1:new_cols, 1:new_rows);
    %Прлучаем координаты пикселей в исходном изображении
    X_original = X / scale;
    Y_original = Y / scale;

    % Используем билинейную интерполяцию для вычисления новых значений пикселей
    resized_image = zeros(new_rows, new_cols, size(image, 3));
    for channel = 1:size(image, 3)
        resized_image(:, :, channel) = interp2(double(image(:, :, channel)), X_original, Y_original, 'linear', 0);
    end

    % Переводим изображение в формат uint8 (если оно не в этом формате)
    if ~isa(resized_image, 'uint8')
        resized_image = uint8(resized_image);
    end
end
