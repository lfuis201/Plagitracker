// src/stores/teacherStore.ts
import { defineStore } from 'pinia';
import { ref, computed } from 'vue';
import TeacherService from '@/services/TeacherService';
import type { Teacher } from '@/types/Teacher';

export const useTeacherStore = defineStore('teacher', () => {
  // Estado reactivo para almacenar el Teacher
  const teacher = ref<Teacher | null>(null);

  // Getter para acceder al Teacher
  const getTeacher = computed(() => teacher.value);

  // Setter para actualizar el Teacher
  const setTeacher = (newTeacher: Teacher) => {
    teacher.value = newTeacher;
  };

  // Acción para iniciar sesión
  const login = async (email: string, password: string) => {
    // eslint-disable-next-line no-useless-catch
    try {
      const response = await TeacherService.loginTeacher(email, password);
      console.log(response)
      setTeacher(response); // Usa el setter para guardar la información del Teacher
      return response;
    } catch (error) {
      throw error;
    }
  };

  // Acción para registrar un nuevo Teacher
  const register = async (teacherData: Teacher) => {
    // eslint-disable-next-line no-useless-catch
    try {
      const response = await TeacherService.registerTeacher(teacherData);
      setTeacher(response.data); // Guardar los datos después del registro
      return response;
    } catch (error) {
      throw error;
    }
  };

  // Acción para limpiar el estado del Teacher
  const clearTeacher = () => {
    teacher.value = null;
  };

  return {
    getTeacher, // Getter para acceder a teacher
    setTeacher, // Setter para actualizar teacher
    login,
    register,
    clearTeacher,
  };
});
