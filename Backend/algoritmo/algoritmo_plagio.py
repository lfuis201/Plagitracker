# algoritmo_plagio.py

import hashlib

# Función para generar valores hash
def generar_hash(text):
    hashval = hashlib.sha1(text.encode('utf-8'))
    hashval = hashval.hexdigest()[-4:]
    return int(hashval, 16)

# Función para generar k-grams
def generar_kgrams(text, k=25):
    token_list = list(text)
    n = len(token_list)
    kgrams = []
    for i in range(n - k + 1):
        kgram = ''.join(token_list[i: i + k])
        hv = generar_hash(kgram)
        kgrams.append((kgram, hv, i, i + k))
    return kgrams

# Encuentra el índice del valor mínimo en una lista
def min_index(arr):
    minI = 0
    minV = arr[0]
    for i in range(len(arr)):
        if arr[i] < minV:
            minV = arr[i]
            minI = i
    return minI

# Generación de fingerprints usando min-hash
def generar_fingerprints(arr, winSize=4):
    arrLen = len(arr)
    prevMin = 0
    fingerprint_list = []
    for i in range(arrLen - winSize):
        win = arr[i: i + winSize]
        currMin = i + min_index(win)
        if currMin != prevMin:
            fingerprint_list.append(arr[currMin])
            prevMin = currMin
    return fingerprint_list

# Convierte la lista de k-grams en una lista de valores hash
def convertir_a_hash_list(arr):
    return [i[1] for i in arr]

# Función de similitud de Jaccard
def jaccard_similarity(set1, set2):
    intersection = len(set(set1).intersection(set(set2)))
    union = len(set(set1).union(set(set2)))
    return intersection / union if union else 0
