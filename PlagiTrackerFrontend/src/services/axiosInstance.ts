import axios from 'axios';
import { useUserStore } from '@/stores/userStore'; // Import your Pinia store
import router from '@/router/index';

// Get the backend URL from environment variables
const backendUrl = process.env.PLAGITRACKER_BACKEND_URL;

// Create an Axios instance
const axiosInstance = axios.create({
  baseURL: backendUrl, // Base URL for the API
  headers: {
    'Content-Type': 'application/json'
  }
});

axiosInstance.interceptors.request.use(
  (config) => {
    const userStore = useUserStore(); 

    const token = userStore.getToken;
    //console.log(token)
    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }

    return config;
  },
  (error) => {
    // Handle request errors
    return Promise.reject(error);
  }
);

// Interceptor to handle errors in the response
axiosInstance.interceptors.response.use(
  (response) => {
    return response; // Simply return the response if successful
  },
  (error) => {
    const statusCode = error.response ? error.response.status : null;

    // Handle server errors (5xx)
    if (statusCode >= 500) {
      router.push({ name: 'ServerError' }); // Redirect to server error page
    }

    // Handle network errors or connection issues
    if (error.message === 'Network Error' || error.code === 'ERR_CONNECTION_REFUSED') {
      router.push({ name: 'ServerError' }); // Redirect to server error page
    }

    // Return a rejected promise to handle the error elsewhere
    return Promise.reject(error);
  }
);

export default axiosInstance;
