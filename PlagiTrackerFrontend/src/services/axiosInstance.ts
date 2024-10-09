import axios from 'axios'
import router from '@/router/index' // Importa directamente el router creado

// Obtener la URL del backend desde las variables de entorno
const backendUrl = process.env.PLAGITRACKER_BACKEND_URL

// Crear una instancia de Axios
const axiosInstance = axios.create({
  baseURL: backendUrl, // URL base de la API
  headers: {
    'Content-Type': 'application/json'
  }
})

// Interceptor para manejar errores
axiosInstance.interceptors.response.use(
  (response) => {
    // Si la respuesta es exitosa, simplemente la retornamos
    return response
  },
  (error) => {
    const statusCode = error.response ? error.response.status : null


    // Manejar errores específicos del servidor (5xx)
    if (statusCode >= 500) {
      router.push({ name: 'ServerError' }) // Redirigir a la vista de error del servidor
    }

    // Manejar la falta de conexión o error de red
    if (error.message === 'Network Error' || error.code === 'ERR_CONNECTION_REFUSED') {
      router.push({ name: 'ServerError' }) // Redirigir a la vista de error del servidor
    }

    // Retornar una promesa rechazada para manejar el error más adelante
    return Promise.reject(error)
  }
)
export default axiosInstance
