// src/services/EnrollmentService.ts
import axiosInstance from './axiosInstance'

const API_ENDPOINT = '/Enrollment'

class EnrollmentService {
  /**
   * Inscribe a un estudiante en un curso.
   *
   * @param {string} courseId - El ID del curso al que se inscribirá el estudiante.
   * @param {string} studentId - El ID del estudiante que se inscribirá.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al inscribir al estudiante.
   */
  static async createEnrollment(courseId: string, studentId: string): Promise<any> {
    try {
      const response = await axiosInstance.post(`${API_ENDPOINT}/Create`, null, {
        params: {
          courseId,
          studentId
        }
      });
      return response;
    } catch (error) {
      console.error('Error creating enrollment:', error);
      throw error;
    }
  }

  /**
   * Obtiene la inscripción por ID.
   *
   * @param {string} enrollmentId - El ID de la inscripción a buscar.
   * @returns {Promise<any>} - Los datos de la inscripción.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener la inscripción.
   */
  static async getEnrollmentById(enrollmentId: string): Promise<any> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/Get`, {
        params: { id: enrollmentId }
      });
      return response.data;
    } catch (error) {
      console.error('Error getting enrollment by ID:', error);
      throw error;
    }
  }

  /**
   * Obtiene todas las inscripciones de un estudiante.
   *
   * @param {string} studentId - El ID del estudiante cuyas inscripciones se desean obtener.
   * @returns {Promise<any[]>} - Una lista de inscripciones del estudiante.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener las inscripciones.
   */
  static async getAllEnrollmentsByStudent(studentId: string): Promise<any[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByStudent`, {
        params: { studentId }
      });
      return response.data;
    } catch (error) {
      console.error('Error getting enrollments by student:', error);
      throw error;
    }
  }

  /**
   * Elimina una inscripción.
   *
   * @param {string} courseId - El ID del curso de la inscripción.
   * @param {string} studentId - El ID del estudiante de la inscripción.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al eliminar la inscripción.
   */
  static async deleteEnrollment(courseId: string, studentId: string): Promise<any> {
    try {
      const response = await axiosInstance.delete(`${API_ENDPOINT}/Delete`, {
        data: { courseId, studentId } // Enviando el cuerpo de la solicitud DELETE
      });
      return response;
    } catch (error) {
      console.error('Error deleting enrollment:', error);
      throw error;
    }
  }
}

export default EnrollmentService;
