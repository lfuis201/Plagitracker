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


  /**
   * Envía un email para restablecer la contraseña del estudiante.
   * 
   * @param {string} email - El correo electrónico del estudiante.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al enviar el correo de restablecimiento.
   */
  static async sendResetPasswordEmail(email: string): Promise<any> {
    try {
      // Enviar el email como query parameter
      const response = await axiosInstance.post(`${API_ENDPOINT}/SendResetPasswordEmail?email=${encodeURIComponent(email)}`);
      return response.data;
    } catch (error) {
      console.error('Error sending reset password email:', error);
      throw error;
    }
  }
  

  /**
   * Verifica el código de restablecimiento de contraseña.
   * 
   * @param {string} email - El correo electrónico del estudiante.
   * @param {number} code - El código de verificación enviado al correo.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al verificar el código.
   */
  static async resetPasswordVerification(email: string, code: number): Promise<any> {
    try {
      // Realiza la solicitud POST enviando los parámetros como query
      const response = await axiosInstance.post(
        `${API_ENDPOINT}/ResetPasswordVerification`, // URL de la API
        null, // No se envía un cuerpo en la solicitud
        {
          params: {
            email: email,  // Se envía el email como query parameter
            code: code      // Se envía el código como query parameter
          }
        }
      );
      return response.data; // Retorna la respuesta de la API
    } catch (error) {
      console.error('Error verifying reset password code:', error);
      throw error; // Lanza el error para manejo posterior
    }
  }
  /**
   * Restablece la contraseña de un estudiante.
   * 
   * @param {Object} resetPasswordRequest - Objeto que contiene los detalles para restablecer la contraseña.
   * @param {string} resetPasswordRequest.email - El correo electrónico del estudiante.
   * @param {number} resetPasswordRequest.verificationCode - El código de verificación del restablecimiento.
   * @param {string} resetPasswordRequest.newPasswordHash - El hash de la nueva contraseña.
   * 
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al restablecer la contraseña.
   */
  static async resetPassword(resetPasswordRequest: { email: string, verificationCode: number, newPasswordHash: string }): Promise<any> {
    try {
      const response = await axiosInstance.post(`${API_ENDPOINT}/ResetPassword`, resetPasswordRequest);
      return response.data;
    } catch (error) {
      console.error('Error resetting password:', error);
      throw error;
    }
  }

}

export default StudentService;
