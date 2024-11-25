import type { Assignment } from '@/types/Assigment'
import axiosInstance from './axiosInstance'

const API_ENDPOINT = '/Assignment'

class AssignmentService {
  /**
   * Crea una nueva asignación en el sistema.
   *
   * @param {Omit<Assignment, 'id'>} assignment - Un objeto que contiene la información de la asignación que se va a crear.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al crear la asignación.
   */
  static async createAssignment(assignment: Omit<Assignment, 'id'>): Promise<any> {
    try {
      const response = await axiosInstance.post(`${API_ENDPOINT}/Create`, assignment)
      return response.data
    } catch (error) {
      console.error('Error creating assignment:', error)
      throw error
    }
  }

  /**
   * Obtiene todas las asignaciones asociadas a un curso.
   *
   * @param {string} courseId - El ID del curso para el que se quieren obtener las asignaciones.
   * @returns {Promise<Assignment[]>} - Una lista de asignaciones asociadas al curso.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener las asignaciones.
   */
  static async getAssignmentsByCourse(courseId: string): Promise<Assignment[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByCourse`, {
        params: { courseId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting assignments by course:', error)
      throw error
    }
  }

  /**
   * Actualiza una asignación existente.
   *
   * @param {Assignment} assignment - El objeto Assignment con los datos actualizados.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al actualizar la asignación.
   */
  static async updateAssignment(assignment: Assignment): Promise<any> {
    try {
      const response = await axiosInstance.put(`${API_ENDPOINT}/Update`, assignment)
      return response.data
    } catch (error) {
      console.error('Error updating assignment:', error)
      throw error
    }
  }

  /**
   * Elimina una asignación existente.
   *
   * @param {string} assignmentId - El ID de la asignación que se va a eliminar.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al eliminar la asignación.
   */
  static async deleteAssignment(assignmentId: string): Promise<any> {
    try {
      const response = await axiosInstance.delete(`${API_ENDPOINT}/Delete`, {
        params: { id: assignmentId }
      })
      return response.data
    } catch (error) {
      console.error('Error deleting assignment:', error)
      throw error
    }
  }

  /**
   * Obtiene una asignación por su ID.
   *
   * @param {string} assignmentId - El ID de la asignación que se va a obtener.
   * @returns {Promise<Assignment>} - La asignación obtenida del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener la asignación.
   */
  static async getAssignmentById(assignmentId: string): Promise<Assignment> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetById`, {
        params: { id: assignmentId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting assignment by ID:', error)
      throw error
    }
  }

  /**
   * Analiza una asignación en el sistema y descarga el reporte en formato PDF.
   *
   * @param {string} assignmentId - El ID de la asignación a analizar.
   * @returns {Promise<void>} - Descarga el archivo PDF del análisis.
   * @throws {Error} - Lanza un error si ocurre algún problema al analizar la asignación.
   */
  static async analyzeAssignment(assignmentId: string): Promise<void> {
    try {
      // Configuramos Axios para manejar una respuesta binaria (el PDF)
      const response = await axiosInstance.post(
        `${API_ENDPOINT}/Analyze?assignmentId=${assignmentId}`,
        {},
        {
          responseType: 'blob' // Indica que esperamos un archivo binario (PDF)
        }
      )

      // Creamos un Blob con los datos del PDF
      const pdfBlob = new Blob([response.data], { type: 'application/pdf' })

      // Creamos una URL para el Blob y forzamos la descarga del archivo
      const downloadUrl = window.URL.createObjectURL(pdfBlob)
      const link = document.createElement('a')
      link.href = downloadUrl
      link.download = `PlagiarismReport-${assignmentId}.pdf` // Nombre del archivo
      document.body.appendChild(link)
      link.click()

      // Limpiar el DOM después de la descarga
      document.body.removeChild(link)
      window.URL.revokeObjectURL(downloadUrl)
    } catch (error) {
      console.error('Error analyzing assignment:', error)
      throw error
    }
  }

  /**
   * Obtiene todas las asignaciones y envíos asociados a un curso y estudiante.
   *
   * @param {string} studentId - El ID del estudiante.
   * @param {string} courseId - El ID del curso.
   * @returns {Promise<AssignmentSubmissionResponse[]>} - Una lista de respuestas que incluyen asignaciones y envíos.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener los datos.
   */
  static async getAllByCourseForStudent(
    studentId: string,
    courseId: string
  ): Promise<Assignment[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByCourseForStudent`, {
        params: { studentId, courseId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting assignments and submissions:', error)
      throw error
    }
  }


  /**
   * Analiza una asignación usando Dolos.
   *
   * @param {string} assignmentId - El ID de la asignación que se va a analizar.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema durante el análisis.
   */
  static async analyzeWithDolos(assignmentId: string, email: string): Promise<any> {
    try {
      const response = await axiosInstance.post(
        `${API_ENDPOINT}/DolosAnalysisCustomEmail`,
        null,
        {
          params: {
            assignmentId,
            email,
          },
        }
      );
      return response.data;
    } catch (error) {
      console.error('Error analyzing with Dolos:', error);
      throw error;
    }
  }
  

}

export default AssignmentService
