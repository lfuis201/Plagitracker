// src/stores/userStore.ts
import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import TeacherService from '@/services/TeacherService'
import StudentService from '@/services/StudentService'
import type { Teacher } from '@/types/Teacher'
import type { Student } from '@/types/Student'

export const useUserStore = defineStore('user', () => {
  // Estado reactivo para almacenar el usuario (puede ser Teacher o Student)
  const user = ref<any>(JSON.parse(localStorage.getItem('user') || 'null')) // Cargar el usuario desde localStorage
  const role = ref<string | null>(JSON.parse(localStorage.getItem('role') || 'null')) // Cargar el rol desde localStorage
  const token = ref<string | null>(localStorage.getItem('token'))

  // Getter para acceder al usuario
  const getUser = computed(() => user.value)
  const getRole = computed(() => role.value)
  const getToken = computed(() => token.value)

  // Setter para actualizar el usuario
  const setUser = (newUser: any) => {
    user.value = newUser
    localStorage.setItem('user', JSON.stringify(newUser)) // Guardar el usuario en localStorage
  }

  // Setter para el rol
  const setRole = (newRole: string) => {
    role.value = newRole
    localStorage.setItem('role', JSON.stringify(newRole)) // Guardar el rol en localStorage
  }

  // Setter to update the token
  const setToken = (newToken: string) => {
    token.value = newToken
    localStorage.setItem('token', newToken) // Save the token in localStorage
  }

  // Acción para iniciar sesión (puede ser Teacher o Student)
  const login = async (email: string, password: string, userType: 'teacher' | 'student') => {
    // eslint-disable-next-line no-useless-catch
    try {
      let response
      if (userType === 'teacher') {
        response = await TeacherService.loginTeacher(email, password)
        setRole('teacher')
      } else if (userType === 'student') {
        response = await StudentService.loginStudent(email, password)
        setRole('student')
      }
      setUser(response.data) // Usa el setter para guardar la información del usuario
      setToken(response.data.token);
      return response
    } catch (error) {
      throw error
    }
  }

  // Acción para registrar un nuevo usuario (puede ser Teacher o Student)
  const register = async (userData: Teacher | Student, userType: 'teacher' | 'student') => {
    // eslint-disable-next-line no-useless-catch
    try {
      let response
      if (userType === 'teacher') {
        response = await TeacherService.registerTeacher(userData as Teacher)
      } else if (userType === 'student') {
        response = await StudentService.registerStudent(userData as Student)
      }
      setUser(response.data) // Guardar los datos después del registro
      return response
    } catch (error) {
      throw error
    }
  }

  const clearUser = () => {
    user.value = null;
    role.value = null;
    token.value = null; // Clear the token
    localStorage.removeItem('user'); // Clear from localStorage
    localStorage.removeItem('role'); // Clear from localStorage
    localStorage.removeItem('token'); // Clear the token from localStorage
  };

  return {
    getUser,
    getRole,
    getToken,
    setUser,
    setRole,
    setToken,
    login,
    register,
    clearUser
  };
})
