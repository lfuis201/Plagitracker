# archivo_processing.py

import os

# Implementación básica de tokenize (puedes adaptarla según tu lógica)
def tokenize(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        return f.read().split()

# Convierte la lista de tokens a texto (opcional)
def toText(tokens):
    return ' '.join(tokens)

# Función para cargar archivos y convertirlos a texto tokenizado
def cargar_archivos_desde_carpeta(ruta_subcarpeta):
    file_paths = [os.path.join(ruta_subcarpeta, f) for f in os.listdir(ruta_subcarpeta) if os.path.isfile(os.path.join(ruta_subcarpeta, f))]
    archivos_procesados = []

    for file in file_paths:
        token = tokenize(file)
        str_token = toText(token)
        archivos_procesados.append((file, str_token))
    
    return archivos_procesados
