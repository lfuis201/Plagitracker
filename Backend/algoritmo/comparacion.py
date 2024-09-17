# comparacion.py

from thefuzz import fuzz
from sentence_transformers import SentenceTransformer
import numpy as np
from algoritmo_plagio import jaccard_similarity  # Importar si defines jaccard en algoritmo_plagio.py
from algoritmo_plagio import generar_kgrams, generar_fingerprints, convertir_a_hash_list

# Modelo pre-entrenado para similitud semántica
model = SentenceTransformer('all-mpnet-base-v2')

# Función de coincidencia difusa usando Levenshtein
def fuzzy_match(code1, code2):
    return fuzz.ratio(code1, code2)

# Función de similitud semántica usando embeddings
def semantic_similarity(code1, code2):
    embeddings1 = model.encode(code1)
    embeddings2 = model.encode(code2)
    similarity = np.dot(embeddings1, embeddings2.T)
    return similarity

# Análisis contextual para reducir falsos positivos
def contextual_analysis(code1, code2):
    common_patterns = ["main", "for", "while", "if", "return"]  # Ejemplo de patrones comunes
    for pattern in common_patterns:
        if pattern in code1 and pattern in code2:
            return 0  # Descartar patrones comunes
    return 1

# Modificar esta función para incluir todas las técnicas de comparación
def comparar_pareja_archivos(file1, kGrams1, HL1, fpList1, file2, kGrams2, HL2, fpList2):
    with open(file1, "r") as f1:
        code1 = f1.read()
    with open(file2, "r") as f2:
        code2 = f2.read()

    # Primera comparación con similitud de k-grams usando Jaccard
    kgram_similarity = jaccard_similarity(fpList1, fpList2)

    # Si hay similitud suficiente, proceder con análisis más profundo
    if kgram_similarity > 0.5:
        fuzzy_score = fuzzy_match(code1, code2)
        nlp_score = semantic_similarity(code1, code2)

        # Ponderar los resultados
        combined_score = (0.4 * kgram_similarity) + (0.3 * fuzzy_score / 100) + (0.3 * nlp_score)

        # Aplicar análisis contextual para reducir falsos positivos
        if contextual_analysis(code1, code2):
            # Realizar el resaltado de plagio como lo tenías antes
            new_code = ""
            puntos = []

            for i in fpList1:
                for j in fpList2:
                    if i == j:
                        match = HL1.index(i)
                        new_start = kGrams1[match][2]
                        new_end = kGrams1[match][3]
                        puntos.append([new_start, new_end])

            # Ordenar y fusionar regiones superpuestas
            puntos.sort(key=lambda x: x[0])
            if puntos:
                merged_points = [puntos[0]]
                for i in range(1, len(puntos)):
                    last = merged_points[-1]
                    if puntos[i][0] <= last[1]:
                        merged_points[-1][1] = max(merged_points[-1][1], puntos[i][1])
                    else:
                        merged_points.append(puntos[i])

                new_code = code1[:merged_points[0][0]]
                plagio_count = 0

                for i in range(len(merged_points)):
                    plagio_count += merged_points[i][1] - merged_points[i][0]
                    new_code += '\x1b[6;30;42m' + code1[merged_points[i][0]:merged_points[i][1]] + '\x1b[0m'
                    if i < len(merged_points) - 1:
                        new_code += code1[merged_points[i][1]:merged_points[i+1][0]]
                    else:
                        new_code += code1[merged_points[i][1]:]

                ratio_plagio = plagio_count / len(code1)
                return combined_score, new_code
            else:
                return combined_score, code1
        else:
            return 0, ""
    else:
        return 0, ""
