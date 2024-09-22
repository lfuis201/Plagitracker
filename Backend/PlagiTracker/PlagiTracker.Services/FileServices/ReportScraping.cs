using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.IO;

namespace PlagiTracker.Services.Reportes
{
    public class ReporteScraping
    {
        public void GenerarReportePDF(string rutaArchivo, string nombreEstudiante, float porcentajeSimilitud, string codigo, string rutaLogo)
        {
            // Crear un documento PDF con tamaño A4 y márgenes
            Document documento = new Document(PageSize.A4, 25, 25, 30, 30);

            try
            {
                // Asegúrate de que el directorio existe
                string directorio = Path.GetDirectoryName(rutaArchivo);
                if (!Directory.Exists(directorio))
                {
                    Directory.CreateDirectory(directorio);
                }

                // Crear el escritor para el documento PDF
                PdfWriter writer = PdfWriter.GetInstance(documento, new FileStream(rutaArchivo, FileMode.Create));

                // Abrir el documento para añadir contenido
                documento.Open();

                // Añadir el logo (si tienes uno), ajusta la ruta y dimensiones
                if (!string.IsNullOrEmpty(rutaLogo) && File.Exists(rutaLogo))
                {
                    iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(rutaLogo);
                    logo.ScaleToFit(150f, 150f); // Ajusta el tamaño del logo
                    logo.Alignment = Element.ALIGN_CENTER; // Centrar el logo
                    documento.Add(logo);
                }

                
                Font tituloFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 24, BaseColor.BLACK);
                Paragraph titulo = new Paragraph("PLAGITRACKER", tituloFont)
                {
                    Alignment = Element.ALIGN_CENTER
                };
                documento.Add(titulo);

                // Añadir un salto de línea
                documento.Add(new Paragraph("\n"));

                // Añadir los datos del estudiante y el porcentaje de similitud
                Font datosFont = FontFactory.GetFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);
                Paragraph datosEstudiante = new Paragraph($"Nombre del Estudiante: {nombreEstudiante}\nPorcentaje de Similitud: {porcentajeSimilitud}%", datosFont);
                datosEstudiante.Alignment = Element.ALIGN_LEFT;
                documento.Add(datosEstudiante);

                // Añadir un salto de línea
                documento.Add(new Paragraph("\n"));

                // Añadir el código scrapeado en el PDF
                Font codigoFont = FontFactory.GetFont(FontFactory.COURIER, 10, BaseColor.BLACK);
                Paragraph codigoTitulo = new Paragraph("Código:", codigoFont);
                codigoTitulo.Alignment = Element.ALIGN_LEFT;
                documento.Add(codigoTitulo);

                // Añadir el código con formato de texto
                Paragraph codigoContenido = new Paragraph(codigo, codigoFont);
                codigoContenido.Alignment = Element.ALIGN_LEFT;
                documento.Add(codigoContenido);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error al generar el PDF: " + ex.Message);
            }
            finally
            {
                // Asegúrate de cerrar el documento correctamente
                if (documento.IsOpen())
                {
                    documento.Close();
                }
            }
        }
    }
}
