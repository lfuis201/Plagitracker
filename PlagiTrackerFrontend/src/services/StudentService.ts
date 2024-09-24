import type { Student } from '@/types/Student';
import axiosInstance from './axiosInstance';

// Definición del endpoint base para las acciones relacionadas con los estudiantes
const API_ENDPOINT = '/Student';

class StudentService {
  /**
   * Registra un nuevo estudiante en el sistema.
   * 
   * @param {Student} student - Un objeto que contiene la información del estudiante que se va a registrar.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al registrar al estudiante.
   */
  static async registerStudent(student: Student): Promise<any> {
    try {
      // Envía el objeto Student completo en el cuerpo de la solicitud
      const response = await axiosInstance.post(`${API_ENDPOINT}/SignUp`, student);
      return response.data;
    } catch (error) {
      console.error('Error registering student:', error);
      throw error;
    }
  }

  /**
   * Inicia sesión un estudiante en el sistema.
   * 
   * @param {string} email - El correo electrónico del estudiante.
   * @param {string} passwordHash - El hash de la contraseña del estudiante.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al iniciar sesión.
   */
  static async loginStudent(email: string, passwordHash: string): Promise<any> {
    try {
      // Crea el cuerpo de la solicitud
      const requestBody = {
        email,
        passwordHash
      };
      
      // Envía la solicitud POST al endpoint de login
      const response = await axiosInstance.post(`${API_ENDPOINT}/LogIn`, requestBody);
      
      // Devuelve los datos de la respuesta
      return response;
    } catch (error) {
      console.error('Error logging in student:', error);
      throw error;
    }
  }

}

export default StudentService;
