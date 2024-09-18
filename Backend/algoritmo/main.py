# main.py

import os
from archivo_processing import cargar_archivos_desde_carpeta
from algoritmo_plagio import generar_kgrams, convertir_a_hash_list, generar_fingerprints
from comparacion import comparar_pareja_archivos
from generar_reporte import generar_reporte_pdf

# Función principal para ejecutar la comparación y generar el reporte
def plagiarismCheckMultiReport(root_folder, output_filename="reporte_plagio.pdf"):
    subcarpetas_comparaciones = {}

    # Obtener todas las subcarpetas de la ruta base
    try:
        subcarpetas = [d for d in os.listdir(root_folder) if os.path.isdir(os.path.join(root_folder, d))]
    except FileNotFoundError:
        print(f"La ruta especificada no existe: {root_folder}")
        return
    except PermissionError:
        print(f"Permiso denegado para acceder a la ruta: {root_folder}")
        return

    # Comprobar que haya subcarpetas en la ruta
    if len(subcarpetas) < 1:
        print("No se encontraron subcarpetas en la ruta.")
        return

    # Comparar cada subcarpeta con las demás subcarpetas
    for i in range(len(subcarpetas)):
        for j in range(i + 1, len(subcarpetas)):
            subcarpeta1 = subcarpetas[i]
            subcarpeta2 = subcarpetas[j]

            ruta_subcarpeta1 = os.path.join(root_folder, subcarpeta1)
            ruta_subcarpeta2 = os.path.join(root_folder, subcarpeta2)

            print(f"Procesando subcarpeta: {ruta_subcarpeta1}")
            archivos_procesados1 = cargar_archivos_desde_carpeta(ruta_subcarpeta1)
            print(f"Procesando subcarpeta: {ruta_subcarpeta2}")
            archivos_procesados2 = cargar_archivos_desde_carpeta(ruta_subcarpeta2)

            if len(archivos_procesados1) < 1 or len(archivos_procesados2) < 1:
                print(f"Una o ambas subcarpetas no contienen archivos válidos: {ruta_subcarpeta1}, {ruta_subcarpeta2}")
                continue

            kGramData1 = []
            kGramData2 = []
            hashLists1 = []
            hashLists2 = []
            fingerprintsList1 = []
            fingerprintsList2 = []
            comparaciones = []

            # Imprimir las carpetas que se están comparando
            print(f"\nComparando {subcarpeta1} con {subcarpeta2}:")

            # Procesar cada archivo en la primera subcarpeta
            for archivo1, strToken1 in archivos_procesados1:
                kGrams1 = generar_kgrams(strToken1)
                hashL1 = convertir_a_hash_list(kGrams1)
                fprints1 = generar_fingerprints(hashL1)

                kGramData1.append(kGrams1)
                hashLists1.append(hashL1)
                fingerprintsList1.append(fprints1)


                """


                # Leer e imprimir el contenido del archivo1
                print(f"\nContenido de {archivo1}:")
                with open(archivo1, 'r', encoding='utf-8') as f:
                    contenido_archivo1 = f.read()
                    print(contenido_archivo1)

                """






            # Procesar cada archivo en la segunda subcarpeta
            for archivo2, strToken2 in archivos_procesados2:
                kGrams2 = generar_kgrams(strToken2)
                hashL2 = convertir_a_hash_list(kGrams2)
                fprints2 = generar_fingerprints(hashL2)

                kGramData2.append(kGrams2)
                hashLists2.append(hashL2)
                fingerprintsList2.append(fprints2)


                """
                print(f"\nContenido de {archivo2}:")
                with open(archivo2, 'r', encoding='utf-8') as f:
                    contenido_archivo2 = f.read()
                    print(contenido_archivo2)
                """





            # Comparar archivos entre sí
            for k in range(len(archivos_procesados1)):
                for l in range(len(archivos_procesados2)):
                    archivo1 = archivos_procesados1[k][0]
                    archivo2 = archivos_procesados2[l][0]
                    ratio, code_snippet = comparar_pareja_archivos(archivo1, kGramData1[k], hashLists1[k], fingerprintsList1[k],
                                                                  archivo2, kGramData2[l], hashLists2[l], fingerprintsList2[l])
                    comparaciones.append((archivo1, archivo2, ratio, code_snippet))

                    # Imprimir el resultado de la comparación
                    print(f"{archivo1} vs {archivo2}: {ratio:.2f}% de similitud")

            subcarpetas_comparaciones[f"Comparación entre {subcarpeta1} y {subcarpeta2}"] = comparaciones

    # Generar el PDF o el reporte con la información de `subcarpetas_comparaciones`
    generar_reporte_pdf(subcarpetas_comparaciones, output_filename)

# Llamada de la función principal
if __name__ == "__main__":
    ruta_principal = input("Ingrese la ruta principal: ")
    plagiarismCheckMultiReport(ruta_principal)
