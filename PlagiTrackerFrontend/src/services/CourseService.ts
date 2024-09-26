// src/services/CourseService.ts
import type { Course } from '@/types/Course'
import axiosInstance from './axiosInstance'

const API_ENDPOINT = '/Course'

class CourseService {
  /**
   * Crea un nuevo curso en el sistema.
   *
   * @param {Course} course - Un objeto que contiene la información del curso que se va a crear.
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al crear el curso.
   */
  static async createCourse(course: Omit<Course, 'id'>): Promise<any> {
    // Al eliminar el 'id' aquí ya que se generará en el servidor
    try {
      const response = await axiosInstance.post(`${API_ENDPOINT}/Create`, course);
      return response;
    } catch (error) {
      console.error('Error creating course:', error);
      throw error;
    }
  }

  /**
   * Obtiene un curso por su ID.
   *
   * @param {string} courseId - El ID del curso a buscar.
   * @returns {Promise<Course>} - Los datos del curso.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener el curso.
   */
  static async getCourseById(courseId: string): Promise<Course> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetById`, {
        params: { id: courseId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting course by ID:', error)
      throw error
    }
  }

  /**
   * Obtiene un curso por su nombre.
   *
   * @param {string} name - El nombre del curso a buscar.
   * @returns {Promise<Course>} - Los datos del curso.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener el curso.
   */
  static async getCourseByName(name: string): Promise<Course> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetByName`, {
        params: { name }
      })
      return response.data
    } catch (error) {
      console.error('Error getting course by name:', error)
      throw error
    }
  }

  /**
   * Obtiene todos los cursos asociados a un estudiante.
   *
   * @param {string} studentId - El ID del estudiante.
   * @returns {Promise<Course[]>} - Una lista de cursos asociados al estudiante.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener los cursos.
   */
  static async getCoursesByStudent(studentId: string): Promise<Course[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByStudent`, {
        params: { studentId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting courses for student:', error)
      throw error
    }
  }

  /**
   * Actualiza un curso existente.
   *
   * @param {Course} course - El objeto Course con los datos actualizados.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al actualizar el curso.
   */
  static async updateCourse(course: Course): Promise<any> {
    try {
      const response = await axiosInstance.put(`${API_ENDPOINT}/Update`, course)
      return response.data
    } catch (error) {
      console.error('Error updating course:', error)
      throw error
    }
  }

  /**
   * Elimina un curso por su ID.
   *
   * @param {string} courseId - El ID del curso a eliminar.
   * @returns {Promise<any>} - La respuesta del servidor.
   * @throws {Error} - Lanza un error si ocurre algún problema al eliminar el curso.
   */
  static async deleteCourse(courseId: string): Promise<any> {
    try {
      const response = await axiosInstance.delete(`${API_ENDPOINT}/Delete`, {
        params: { id: courseId }
      })
      return response.data
    } catch (error) {
      console.error('Error deleting course:', error)
      throw error
    }
  }

  /**
   * Obtiene todos los cursos asociados a un profesor.
   *
   * @param {string} teacherId - El ID del profesor.
   * @returns {Promise<Course[]>} - Una lista de cursos asociados al profesor.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener los cursos.
   */
  static async getAllByTeacher(teacherId: string): Promise<Course[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllByTeacher`, {
        params: { teacherId }
      })
      return response.data
    } catch (error) {
      console.error('Error getting courses for teacher:', error)
      throw error
    }
  }

   /**
   * Obtiene todos los cursos disponibles.
   *
   * @returns {Promise<Course[]>} - Una promesa que se resuelve con la lista de cursos.
   * @throws {Error} - Lanza un error si ocurre algún problema al obtener los cursos.
   */
   static async getAllCourses(): Promise<Course[]> {
    try {
      const response = await axiosInstance.get(`${API_ENDPOINT}/GetAllCourses`);
      return response.data;
    } catch (error) {
      console.error('Error getting all courses:', error);
      throw error;
    }
  }

}

export default CourseService
