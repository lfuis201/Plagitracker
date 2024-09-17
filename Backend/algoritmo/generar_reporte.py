# generar_reporte.py

from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.pagesizes import letter

# Función para generar el reporte PDF
def generar_reporte_pdf(subcarpetas, output_filename="reporte_plagio.pdf"):
    doc = SimpleDocTemplate(output_filename, pagesize=letter)
    elements = []
    styles = getSampleStyleSheet()

    # Añadir título
    elements.append(Paragraph("<b>Reporte de Plagio</b>", styles['Title']))
    elements.append(Spacer(1, 12))

    for carpeta, comparaciones in subcarpetas.items():
        elements.append(Paragraph(f"<b>Carpeta: {carpeta}</b>", styles['Heading2']))
        elements.append(Spacer(1, 12))

        for comparacion in comparaciones:
            archivo1, archivo2, ratio, code_snippet = comparacion
            elements.append(Spacer(1, 12))
            elements.append(Paragraph(f"<b>Comparando {archivo1} con {archivo2}:</b>", styles['Heading3']))
            elements.append(Paragraph(f"Ratio aproximado de plagio: {ratio:.4f}", styles['Normal']))
            elements.append(Spacer(1, 6))

            # Añadir fragmentos de código
            lines = code_snippet.split('\n')
            for line in lines:
                if '\x1b[6;30;42m' in line:  # Detectar plagio resaltado
                    line = line.replace('\x1b[6;30;42m', '').replace('\x1b[0m', '')
                    elements.append(Paragraph(f"<font color='red'>{line}</font>", styles['Normal']))
                else:
                    elements.append(Paragraph(line, styles['Normal']))

            elements.append(Spacer(1, 12))

    # Guardar el PDF
    doc.build(elements)
