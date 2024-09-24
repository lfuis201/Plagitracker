// src/stores/userStore.ts
import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import TeacherService from '@/services/TeacherService';
import StudentService from '@/services/StudentService';
import type { Teacher } from '@/types/Teacher';
import type { Student } from '@/types/Student';

export const useUserStore = defineStore('user', () => {
  // Estado reactivo para almacenar el usuario (puede ser Teacher o Student)
  const user = ref<any>(null); // Se utiliza `any` para manejar tanto Teacher como Student

  // Getter para acceder al usuario
  const getUser = computed(() => user.value);

  // Setter para actualizar el usuario
  const setUser = (newUser: any) => {
    user.value = newUser;
  };

  // Acción para iniciar sesión (puede ser Teacher o Student)
  const login = async (email: string, password: string, userType: 'teacher' | 'student') => {
    // eslint-disable-next-line no-useless-catch
    try {
      let response;
      if (userType === 'teacher') {
        response = await TeacherService.loginTeacher(email, password);
      } else if (userType === 'student') {
        response = await StudentService.loginStudent(email, password);
      }
      setUser(response.data); // Usa el setter para guardar la información del usuario
      return response;
    } catch (error) {
      throw error;
    }
  };

  // Acción para registrar un nuevo usuario (puede ser Teacher o Student)
  const register = async (userData: Teacher | Student, userType: 'teacher' | 'student') => {
    // eslint-disable-next-line no-useless-catch
    try {
      let response;
      if (userType === 'teacher') {
        response = await TeacherService.registerTeacher(userData as Teacher);
      } else if (userType === 'student') {
        response = await StudentService.registerStudent(userData as Student);
      }
      setUser(response.data); // Guardar los datos después del registro
      return response;
    } catch (error) {
      throw error;
    }
  };

  // Acción para limpiar el estado del usuario
  const clearUser = () => {
    user.value = null;
  };

  return {
    getUser,     // Getter para acceder al usuario
    setUser,     // Setter para actualizar usuario
    login,       // Acción para iniciar sesión
    register,    // Acción para registrar
    clearUser,   // Acción para limpiar el usuario
  };
});
