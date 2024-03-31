import pytesseract

image = Image.open('screenshot.png')
text = pytesseract.image_to_string(image)
print(text[:500]) 
