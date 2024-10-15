import type { Teacher } from '@/types/Teacher'
import axiosInstance from './axiosInstance'

// Definición del endpoint base para las acciones relacionadas con los profesores
const API_ENDPOINT = '/Teacher'

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
      const response = await axiosInstance.post(`${API_ENDPOINT}/SignUp`, teacher)
      return response.data
    } catch (error) {
      console.error('Error registering teacher:', error)
      throw error
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
      }

      // Envía la solicitud POST al endpoint de login
      const response = await axiosInstance.post(`${API_ENDPOINT}/Login`, requestBody)

      // Devuelve los datos de la respuesta
      return response
    } catch (error) {
      console.error('Error logging in teacher:', error)
      throw error
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
      const response = await axiosInstance.post(
        `${API_ENDPOINT}/SendResetPasswordEmail?email=${encodeURIComponent(email)}`
      )
      return response.data
    } catch (error) {
      console.error('Error sending reset password email:', error)
      throw error
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
            email: email, // Se envía el email como query parameter
            code: code // Se envía el código como query parameter
          }
        }
      )
      return response.data // Retorna la respuesta de la API
    } catch (error) {
      console.error('Error verifying reset password code:', error)
      throw error // Lanza el error para manejo posterior
    }
  }

  /**
   * Restablece la contraseña de un profesor.
   *
   * @param {Object} resetPasswordRequest - Objeto que contiene los detalles para restablecer la contraseña.
   * @param {string} resetPasswordRequest.email - El correo electrónico del profesor.
   * @param {number} resetPasswordRequest.verificationCode - El código de verificación del restablecimiento.
   * @param {string} resetPasswordRequest.newPasswordHash - El hash de la nueva contraseña.
   *
   * @returns {Promise<any>} - Una promesa que se resuelve con la respuesta del servidor en caso de éxito.
   * @throws {Error} - Lanza un error si ocurre algún problema al restablecer la contraseña.
   */
  static async resetPassword(resetPasswordRequest: {
    email: string
    verificationCode: number
    newPasswordHash: string
  }): Promise<any> {
    try {
      // Hacemos la solicitud POST al servidor
      const response = await axiosInstance.post(
        `${API_ENDPOINT}/ResetPassword`,
        resetPasswordRequest
      )
      return response.data
    } catch (error) {
      console.error('Error resetting password:', error)
      throw error
    }
  }
}

export default TeacherService
