import cv2

# загружаем каскад Хаара для поиска лиц
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

image_path = 'image.png'
# TODO допишите считывания изображения (на строчки 8)
image = cv2.imread()

if image is None:
    print(f"Ошибка: Не удалось загрузить изображение по пути '{image_path}'")
    exit()

# конвертируем в ч/б для работы алгоритма
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# TODO найдите лица на изображение
# faces = 

print(f"Найдено лиц: {len(faces)}")

# обводим каждое найденное лицо
for (x, y, w, h) in faces:
    cv2.rectangle(image, (x, y), (x + w, y + h), (255, 0, 0), 2)

# сохраняем результат в новый файл (вместо отрисовки в окне)
output_path = 'result.jpg'
cv2.imwrite(output_path, image)

print(f"Успех. Сохранено как '{output_path}'")
