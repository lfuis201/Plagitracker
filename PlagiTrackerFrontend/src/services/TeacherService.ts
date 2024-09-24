import type { Teacher } from '@/types/Teacher';
import axiosInstance from './axiosInstance';

// Definición del endpoint base para las acciones relacionadas con los profesores
const API_ENDPOINT = '/Teacher';

class TeacherService {
  /**
   * Registra un nuevo profesor en el sistema.
   * 
   * @param {Teacher} teacher - Un objeto que contiene la información del profesor que se va a registrar.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al registrar al profesor.
   */
  static async registerTeacher(teacher: Teacher): Promise<any> {
    try {
      // Envía el objeto Teacher completo en el cuerpo de la solicitud
      const response = await axiosInstance.post(`${API_ENDPOINT}/SignUp`, teacher);
      return response.data;
    } catch (error) {
      console.error('Error registering teacher:', error);
      throw error;
    }
  }

  /**
   * Inicia sesión un profesor en el sistema.
   * 
   * @param {string} email - El correo electrónico del profesor.
   * @param {string} passwordHash - El hash de la contraseña del profesor.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al iniciar sesión.
   */
  static async loginTeacher(email: string, passwordHash: string): Promise<any> {
    try {
      // Crea el cuerpo de la solicitud
      const requestBody = {
        email,
        passwordHash
      };
      
      // Envía la solicitud POST al endpoint de login
      const response = await axiosInstance.post(`${API_ENDPOINT}/Login`, requestBody);
      
      // Devuelve los datos de la respuesta
      return response;
    } catch (error) {
      console.error('Error logging in teacher:', error);
      throw error;
    }
  }

  static async updateTeacher(): Promise<any> {
 
  }

  static async deleteTeacher(): Promise<any> {
 
  }
  static async getTeacher(): Promise<any> {
 
  }

}

export default TeacherService;
