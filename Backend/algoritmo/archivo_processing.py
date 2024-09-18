import os
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
import string

# Cargar las stop words en español (puedes cambiar el idioma si es necesario)
stop_words = set(stopwords.words('spanish'))

# Tokenización avanzada: tokeniza el código, eliminando puntuación y stop words
def tokenize_code(file_path):
    with open(file_path, 'r', encoding='utf-8') as f:
        code = f.read()

    # Tokenización básica con NLTK
    tokens = word_tokenize(code)

    # Filtrar tokens: eliminar puntuación y stop words
    tokens_filtrados = [t for t in tokens if t not in stop_words and t not in string.punctuation]

    return tokens_filtrados

# Convierte la lista de tokens a texto (opcional)
def toText(tokens):
    return ' '.join(tokens)

# Función para cargar archivos y convertirlos a texto tokenizado
def cargar_archivos_desde_carpeta(ruta_subcarpeta):
    file_paths = [os.path.join(ruta_subcarpeta, f) for f in os.listdir(ruta_subcarpeta) if os.path.isfile(os.path.join(ruta_subcarpeta, f))]
    archivos_procesados = []

    for file in file_paths:
        tokens = tokenize_code(file)
        str_token = toText(tokens)  # Esto es opcional si prefieres trabajar con tokens directamente
        archivos_procesados.append((file, str_token))
    
    return archivos_procesados
