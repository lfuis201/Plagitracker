import { defineStore } from 'pinia'
import { ref } from 'vue'
import CourseService from '@/services/CourseService'
import type { Course } from '@/types/Course'
import { useUserStore } from '@/stores/userStore'

export const useCoursesStore = defineStore('coursesStore', () => {
  const courses = ref<Course[]>([])
  const isLoading = ref(false)
  const errorMessage = ref('')

  // Obtener los cursos del profesor
  const fetchCoursesByTeacher = async () => {
    const userStore = useUserStore()
    const user = userStore.getUser
    // Reset courses and error message at the start of the fetch
    courses.value = [] // Clear the courses before fetching new ones
    errorMessage.value = '' // Clear any previous error message
    if (user && user.id) {
      try {
        isLoading.value = true
        errorMessage.value = ''
        await new Promise(resolve => setTimeout(resolve, 2000));
        const coursesData = await CourseService.getAllByTeacher(user.id)
        courses.value = coursesData

        courses.value = coursesData.filter(course => course.isEnabled && !course.isArchived)


      } catch (error) {
        console.error('Error fetching courses:', error)
        errorMessage.value = 'Failed to load courses'
      } finally {
        isLoading.value = false
      }
    } else {
      console.error('User not authenticated or ID not available.')
      errorMessage.value = 'User not authenticated or ID not available.'
    }
  }

  return {
    courses,
    isLoading,
    errorMessage,
    fetchCoursesByTeacher
  }
})
