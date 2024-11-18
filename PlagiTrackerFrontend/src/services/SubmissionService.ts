import type { Submission } from '@/types/Submission'
import axiosInstance from './axiosInstance'

const API_ENDPOINT = '/Submission'

class SubmissionService {
  /**
   * Crea una nueva entrega (submission) en el sistema.
   *
   * @param {Omit<Submission, 'id'>} submission - Un objeto que contiene la información de la entrega que se va a crear.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al crear la entrega.
   */
  static async createSubmission(submission: Omit<Submission, 'id'>): Promise<any> {
    try {
      const response = await axiosInstance.post(`${API_ENDPOINT}/Create`, submission)
      return response.data
    } catch (error) {
      console.error('Error creating submission:', error)
      throw error
    }
  }

  /**
   * Obtiene una entrega específica por su ID.
   *
   * @param {string} submissionId - El ID de la entrega que se quiere obtener.
   * @returns {Promise<Submission>} - La entrega solicitada.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener la entrega.
   */
  static async getSubmissionById(submissionId: string): Promise<Submission> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/Get`, {
        params: { id: submissionId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting submission by ID:', error)
      throw error
    }
  }

  /**
   * Obtiene todas las entregas hechas por un estudiante específico.
   *
   * @param {string} studentId - El ID del estudiante cuyas entregas se quieren obtener.
   * @returns {Promise<Submission[]>} - Una lista de entregas asociadas al estudiante.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener las entregas.
   */
  static async getAllSubmissionsByStudent(studentId: string): Promise<Submission[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByStudent`, {
        params: { studentId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting submissions by student:', error)
      throw error
    }
  }

  /**
   * Actualiza una entrega existente.
   *
   * @param {Submission} submission - El objeto Submission con los datos actualizados.
   * @param {Date} submissionDate - La fecha y hora de la actualización de la entrega.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al actualizar la entrega.
   */
  static async updateSubmission(submission: Submission, submissionDate: Date): Promise<any> {
    try {
      const response = await axiosInstance.put(`${API_ENDPOINT}/Update`, {
        ...submission,
        dateTime: submissionDate
      })
      return response.data
    } catch (error) {
      console.error('Error updating submission:', error)
      throw error
    }
  }

  /**
   * Elimina una entrega del sistema.
   *
   * @param {string} submissionId - El ID de la entrega que se va a eliminar.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al eliminar la entrega.
   */
  static async deleteSubmission(submissionId: string): Promise<any> {
    try {
      const response = await axiosInstance.delete(`${API_ENDPOINT}/Delete`, {
        params: { id: submissionId }
      })
      return response.data
    } catch (error) {
      console.error('Error deleting submission:', error)
      throw error
    }
  }

   /**
   * Obtiene todas las entregas asociadas a una asignación específica.
   *
   * @param {string} assignmentId - El ID de la asignación cuyas entregas se quieren obtener.
   * @returns {Promise<Submission[]>} - Una lista de entregas asociadas a la asignación.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener las entregas.
   */
   static async getAllByAssignment(assignmentId: string): Promise<any[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByAssignment`, {
        params: { assignmentId } // Envía el assignmentId como parámetro de consulta
      })
      return response.data
    } catch (error) {
      console.error('Error getting submissions by assignment:', error)
      throw error
    }
  }


  /**
   * Obtiene una entrega (submission) por su ID.
   *
   * @param {string} id - El ID de la entrega que se va a obtener.
   * @returns {Promise<Submission>} - Una promesa que se resuelve con la entrega obtenida.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener la entrega.
   */
  static async getSubmission(id: string): Promise<Submission> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/Get`, {
        params: { id }
      })
      return response.data
    } catch (error) {
      console.error('Error retrieving submission:', error)
      throw error
    }
  }


  /**
   * Verifica si el estudiante ya ha realizado una entrega para una tarea específica.
   *
   * @param {string} assignmentId - El ID de la tarea.
   * @param {string} studentId - El ID del estudiante.
   * @returns {Promise<boolean>} - Retorna true si la entrega ya existe, false de lo contrario.
   * @throws {Error} - Lanza un error si ocurre algún problema al verificar la entrega.
   */
  static async verifySubmission(assignmentId: string, studentId: string): Promise<boolean> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/VerifySubmission`, {
        params: { assignmentId, studentId }
      });
      return response.data;
    } catch (error) {
      console.error('Error verifying submission:', error);
      throw error;
    }
  }

   /**
   * Obtiene una entrega (submission) por su assignmentId y studentId.
   *
   * @param {Guid} assignmentId - El ID de la tarea (assignment).
   * @param {Guid} studentId - El ID del estudiante (student).
   * @returns {Promise<Submission>} - Una promesa que se resuelve con los datos de la entrega.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener la entrega.
   */
   static async getSubmissionByAssignmentAndStudent(
    assignmentId: string,
    studentId: string
  ): Promise<Submission> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetByAssignment/${assignmentId}/${studentId}`)
      return response.data
    } catch (error) {
      console.error('Error fetching submission by assignment and student:', error)
      throw error
    }
  }
  
}

export default SubmissionService
