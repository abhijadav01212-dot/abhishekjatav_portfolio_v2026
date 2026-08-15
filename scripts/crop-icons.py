from pathlib import Path
from PIL import Image

source = Image.open(r"C:\Users\ABHISH~1\AppData\Local\Temp\codex-clipboard-1d66a5ee-a951-4b8a-a053-42a531d41cd7.png").convert("RGBA")
icons = {
    "unified": (0, 0), "ibm": (1, 0), "packt": (2, 0), "maven": (3, 0),
    "microsoft": (4, 0), "tableau": (5, 0), "google": (6, 0), "coursera": (7, 0), "aws": (8, 0),
    "excel": (0, 1), "sql": (1, 1), "powerbi": (2, 1), "python": (3, 1),
    "skill-tableau": (4, 1), "analysis": (5, 1), "visualization": (6, 1),
}
output = Path("public/icons")
for name, (column, row) in icons.items():
    icon = source.crop((column * 170, row * 145, (column + 1) * 170, (row + 1) * 145))
    pixels = icon.load()
    for y in range(icon.height):
        for x in range(icon.width):
            red, green, blue, alpha = pixels[x, y]
            if red < 18 and green < 18 and blue < 18:
                pixels[x, y] = (red, green, blue, 0)
    icon.save(output / f"{name}.png")
