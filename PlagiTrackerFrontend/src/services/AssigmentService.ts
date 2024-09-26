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
}

export default AssignmentService
