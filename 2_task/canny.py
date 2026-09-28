import cv2 as cv
import numpy as np


image_path = 'image.png'
img = cv.imread(image_path)

if img is None:
    print(f"Не удалось загрузить '{image_path}'")
    exit()

# Требуется получить маску изображения
lower_range = np.array([200, 200, 200])
upper_range = np.array([255, 255, 255])
# TODO выделите маску и инвертируйте ее
# mask = 
# mask = 

# Нарисуйте контур вокруг изображения
img2 = cv.bitwise_and(img, img, mask= mask) # вырезали изображение по маске
# TODO найдите контуры
# contours, hierarchy =
cv.drawContours(img, contours, -1, (0,255,0), 3)

cv.imshow("Mask",mask)
cv.imshow("Contour",img)
cv.waitKey(0)


# TODO попробуйте метод Канни

image_gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

# TODO применить детектор границ Канни
# edges = 

cv.imshow("Canny", edges)