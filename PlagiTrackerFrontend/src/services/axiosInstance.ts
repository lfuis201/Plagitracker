import axios from 'axios';

// Obtener la URL del backend desde las variables de entorno
const backendUrl = process.env.PLAGITRACKER_BACKEND_URL;

// Crear una instancia de Axios
const axiosInstance = axios.create({
  baseURL: backendUrl, // URL base de la API
  headers: {
    'Content-Type': 'application/json',
  },
});


axiosInstance.interceptors.response.use(
  (response) => {
    return response;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default axiosInstance;
